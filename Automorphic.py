n = int(input())

s = n*n

l = []

l1 = []

for i in str(n):

    l.append(i)

for i in str(s):

    l1.append(i)

flag = 0

if(set(l) & set(l1)==set(l)):

    flag = 1

if(flag):

    print("Automotphic Number")

else:

    print("Not an automorphic number ")


 

