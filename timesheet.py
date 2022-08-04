from datetime import *
import time

f = open("timesheet", 'r')

line = f.readlines()[-1]
print(line)
action = line.split()[-1]
print(action)
timestamp = line.split()[1:-1]
print(timestamp)


timestamp_date_str = ""
for word in timestamp:
    timestamp_date_str += word

print(timestamp_date_str)
    
# timestamp_date = datetime.strftime(timestamp_date_str)
# print(timestamp_date)

f.close()