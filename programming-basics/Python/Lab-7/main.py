import random


def fill(list, length, callback):
    for i in range(0, length):
        list.append(callback(i))


def fill_array_d(index):
    array_a_el = list_a[index]
    array_c_el = list_c[index]
    if array_a_el > array_c_el:
        return array_a_el
    elif array_a_el < array_c_el:
        return array_c_el
    else:
        return 0


MIN_VALUE = -1000
MAX_VALUE = 1000
LENGTH = 10

list_a = []
list_c = []
list_d = []

fill_callback = lambda index: random.randint(MIN_VALUE, MAX_VALUE)

fill(list_a, LENGTH, fill_callback)
fill(list_c, LENGTH, fill_callback)

fill(list_d, LENGTH, fill_array_d)

min_value = list_d[0]

for i in list_d:
    if i < min_value:
        min_value = i

last_item = list_d[-1]

print("Min value: ", "{:> 5}".format(min_value), "|", "Last item: ", "{:> 5}".format(last_item))
[min_value, last_item] = [last_item, min_value]
print("Min value: ", "{:> 5}".format(min_value), "|", "Last item: ", "{:> 5}".format(last_item))
