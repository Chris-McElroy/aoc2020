from collections import defaultdict

i = 6
list = defaultdict(lambda: i)
list[2] = 0
list[20] = 1
list[0] = 2
list[4] = 3
list[1] = 4
list[17] = 5
next = 0

while (i != 29999999):
    temp = next
    next = i-list[next]
    list[temp] = i
    i += 1

print(next)
