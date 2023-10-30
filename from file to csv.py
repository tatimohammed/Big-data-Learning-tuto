data = 'part-m-00000'

with open(data, 'r') as f:
    csv = f.read()
f.close()
with open('transformed_data.csv', 'w') as f:
    f.write(csv)
f.close()