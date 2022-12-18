import random

midList = [10000, 10001, 10002, 20000, 20001, 30000, 31000, 31001]
priceList = [40000, 18000, 40000, 35000, 45000, 20000, 210000, 35000]

base = 'INSERT INTO `car_dealer`.`Vehicle` (`Vin`, `Mid`, `Price`, `Ssn`) VALUES '
sql = []
for i in range(100000, 200000):
    if i % 10000 == 0: print(i)

    m_idx = random.randint(0, len(midList)-1)
    sid = random.randint(11000000, 19999999)


    mid = midList[m_idx]
    price = (int(random.randint(priceList[m_idx], priceList[m_idx] * 1.2) / 100))*100

    query = base + '(' + str(i) + ', ' + str(mid) + ', ' + str(price) + ', NULL);\n'

    sql.append(query)

f = open('car_dealer_vehicle_data.sql', 'w')
for i, s in enumerate(sql):
    f.writelines(s)

f.close()