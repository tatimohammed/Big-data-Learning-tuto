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

