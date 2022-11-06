import random
# import numpy as np

first = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
second = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
third = '김이박정윤최장한오우배변곽공류홍표조주도신은혜선명진수국종경'
did= [111, 112, 113, 120, 130]
sidList = []

base = 'INSERT INTO STUDENT (s_name, student_id, major_did) VALUES'
sql = []
for i in range(100000):
    if i % 10000 == 0: print(i)
    f_idx = random.randint(0, len(first)-1)
    s_idx = random.randint(0, len(first)-1)
    t_idx = random.randint(0, len(first)-1)
    d_idx = random.randint(0, len(did)-1)
    sid = random.randint(11000000, 19999999)
    while sid in sidList:
        sid = random.randint(11000000, 19999999)
    sidList.append(sid)

    s_name = first[f_idx] + second[s_idx] + third[t_idx]
    studentid = sid
    major_did = did[d_idx]

    query = base + '("' + s_name + '", ' + str(studentid) + ', ' + str(major_did) + ');\n'

    sql.append(query)

f = open('inha_db_data.sql', 'w')
for i, s in enumerate(sql):
    f.writelines(s)

f.close()