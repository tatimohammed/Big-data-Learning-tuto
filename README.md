# Big data Project - Learning: Fatalities in the Palestinian-Israeli
- What we are trying to is to get started with `hadoop`, `pig`, `hive` technologies.

 ## Install Docker 
 - You can work on VM(ubuntu) or WSL(ubuntu). Choose what suit for you!  
```bash
sudo apt update
```
 Install Prerequisite Packages
```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```
Then add the GPG key for the official Docker repository to your system:
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Add the Docker repository to APT sources:
```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
Specify Installation Source
```bash
apt-cache policy docker-ce
```
Install Docker
```bash
sudo apt install docker-ce -y
```
Check Installation
```bash
sudo systemctl status docker
```
 ## Pull the images
 - This is an image based on Ubuntu and have hadoop, hive, pig and spark installed on it.
 ```bash
sudo docker pull suhothayan/hadoop-spark-pig-hive:2.9.2
```
- run the image
 ```bash
sudo docker run -it -p 50070:50070 -p 8088:8088 -p 8080:8080 suhothayan/hadoop-spark-pig-hive:2.9.2 bash
```
- **Now you can start killing the machine!!**
## Work with hadoop , hive, pig
### Checking for null values using PIG
- The basic thing to get started with any data processing is checking for null values.
```bash
pig -x local null_values_checker.pig > null_values.txt
```
- The output:
```text
(took_part_in_the_hostilities,1430)
(notes,280)
(gender,20)
(age,130)
(type_of_injury,291)
(ammunition,5253)
(place_of_residence,68)
(place_of_residence_district,68)
```
### Do some tranformation to the data
```bash
pig -x local transform_data.pig
```
- The output is a folder named transformed_data contains those files:
```text
.
├── _SUCCESS
└── part-m-00000

0 directories, 2 files
```
The file that we are intersted in is `part-m-00000`, These must be another way to get it directly as a CSV file, for now We will use Python the get the job done :), that where we will use the python script `from_file_to_csv.py`
```bash
python from_file_to_csv.py
```
### Loading data into HDFS
- The output is a file named `transformed_data.csv`
- Let's load this file in our HDFS:  
```bash
hadoop fs -put transformed_data.csv /projects/palestine/transformed_data.csv
```
- **Note**: We should of cource create the folders in HDFS.
```bash
hadoop fs -mkdir -p /projects/palestine
```
## Creating Hive Tables and run so queries
- To create hive table let's run the HQL script that we have:
```bash
hive -f loading_data_into_hive.hql
```
This script will create a database called project, use it, create table and load data into it.

- Do some analysis using HiveQL:
```bash
hive -f number_of_fatalilies.hql
```
this script will use the project  database and the table called `data` to run some queries and store the results as a `Hive tables`.
```bash
0: jdbc:hive2://> show tables;
OK
+---------------------+
|      tab_name       |
+---------------------+
| data                |
| fatalities_by_age   |
| fatalities_by_year  |
+---------------------+
```
- How is the data inside hive looks like in HDFS
 ```bash
root@36c3d670ced2:/# hadoop fs -ls -R /user/hive/warehouse/project.db
drwxr-xr-x   - root supergroup          0 2023-10-30 17:15 /user/hive/warehouse/project.db/data
-rwxr-xr-x   1 root supergroup    1041416 2023-10-30 17:02 /user/hive/warehouse/project.db/data/transformed_data.csv
drwxr-xr-x   - root supergroup          0 2023-10-30 17:47 /user/hive/warehouse/project.db/fatalities_by_age
-rwxr-xr-x   1 root supergroup        578 2023-10-30 17:47 /user/hive/warehouse/project.db/fatalities_by_age/000000_0
drwxr-xr-x   - root supergroup          0 2023-10-30 17:36 /user/hive/warehouse/project.db/fatalities_by_year
-rwxr-xr-x   1 root supergroup        221 2023-10-30 17:36 /user/hive/warehouse/project.db/fatalities_by_year/000000_0
```
- Get the number of fatalities over years:
```bash
0: jdbc:hive2://> select * from fatalities_by_year;
OK
+--------------------------+--------------------------------+
| fatalities_by_year.year  | fatalities_by_year.fatalities  |
+--------------------------+--------------------------------+
| 2000                     | 35                             |
| 2001                     | 353                            |
| 2002                     | 1325                           |
| 2003                     | 733                            |
| 2004                     | 928                            |
| 2005                     | 234                            |
| 2006                     | 684                            |
| 2007                     | 395                            |
| 2008                     | 915                            |
| 2009                     | 1045                           |
| 2010                     | 89                             |
| 2011                     | 129                            |
| 2012                     | 261                            |
| 2013                     | 41                             |
| 2014                     | 2332                           |
| 2015                     | 177                            |
| 2016                     | 116                            |
| 2017                     | 76                             |
| 2018                     | 302                            |
| 2019                     | 145                            |
| 2020                     | 30                             |
| 2021                     | 325                            |
| 2022                     | 205                            |
| 2023                     | 249                            |
+--------------------------+--------------------------------+
25 rows selected (2.179 seconds)
```
- The number of fatalities over age:
```bash
0: jdbc:hive2://> select * from fatalities_by_age;
OK
+------------------------+-------------------------------+
| fatalities_by_age.age  | fatalities_by_age.fatalities  |
+------------------------+-------------------------------+
| NULL                   | 130                           |
| 1                      | 59                            |
| 2                      | 70                            |
| 3                      | 62                            |
| 4                      | 64                            |
| 5                      | 55                            |
| 6                      | 48                            |
| 7                      | 67                            |
| 8                      | 47                            |
| 9                      | 80                            |
| 10                     | 81                            |
| 11                     | 87                            |
| 12                     | 91                            |
| 13                     | 154                           |
| 14                     | 199                           |
| 15                     | 275                           |
| 16                     | 391                           |
| 17                     | 409                           |
| 18                     | 391                           |
| 19                     | 534                           |
| 20                     | 589                           |
| 21                     | 610                           |
| 22                     | 630                           |
| 23                     | 581                           |
| 24                     | 483                           |
| 25                     | 490                           |
| 26                     | 383                           |
| 27                     | 352                           |
| 28                     | 317                           |
| 29                     | 229                           |
| 30                     | 260                           |
| 31                     | 171                           |
| 32                     | 207                           |
| 33                     | 169                           |
| 34                     | 145                           |
| 35                     | 159                           |
| 36                     | 133                           |
| 37                     | 96                            |
| 38                     | 104                           |
| 39                     | 96                            |
| 40                     | 116                           |
| 41                     | 78                            |
| 42                     | 80                            |
| 43                     | 77                            |
| 44                     | 63                            |
| 45                     | 91                            |
| 46                     | 57                            |
| 47                     | 53                            |
| 48                     | 73                            |
| 49                     | 55                            |
| 50                     | 78                            |
| 51                     | 54                            |
| 52                     | 54                            |
| 53                     | 51                            |
| 54                     | 50                            |
| 55                     | 49                            |
| 56                     | 39                            |
| 57                     | 27                            |
| 58                     | 41                            |
| 59                     | 26                            |
| 60                     | 32                            |
| 61                     | 19                            |
| 62                     | 31                            |
| 63                     | 30                            |
| 64                     | 29                            |
| 65                     | 29                            |
| 66                     | 22                            |
| 67                     | 23                            |
| 68                     | 15                            |
| 69                     | 12                            |
| 70                     | 22                            |
| 71                     | 14                            |
| 72                     | 14                            |
| 73                     | 12                            |
| 74                     | 8                             |
| 75                     | 17                            |
| 76                     | 6                             |
| 77                     | 12                            |
| 78                     | 10                            |
| 79                     | 14                            |
| 80                     | 4                             |
| 81                     | 6                             |
| 82                     | 8                             |
| 83                     | 1                             |
| 84                     | 4                             |
| 85                     | 6                             |
| 86                     | 3                             |
| 87                     | 3                             |
| 88                     | 1                             |
| 89                     | 1                             |
| 90                     | 1                             |
| 91                     | 1                             |
| 92                     | 1                             |
| 94                     | 2                             |
| 101                    | 1                             |
| 112                    | 1                             |
+------------------------+-------------------------------+
96 rows selected (0.291 seconds)
```
### Some visualization using Python 
`< I was hoping to explore Apache SuperSet But there was no time I hope you guys use it :) >`
  ![newplot (1)](https://github.com/tatimohammed/Big-data-Project-Learning-/assets/95311883/2b66aafb-ffe3-4cbb-9cbd-45b7e49e8c18)
  ![newplot](https://github.com/tatimohammed/Big-data-Project-Learning-/assets/95311883/c67629b9-b245-48ca-8fa7-0942eb703d5e)
