from math import *


def get_decimal_fractions(integer):
    """Divides the number by decimal fractions.
        :param int integer: a number that needs to be transformed
        :return: list of fractions

     Example:

     get_decimal_fractions(123)

     Output: [3, 2, 1]

    """
    fractions = []
    while integer != 0:
        fractions.append(integer % 10)
        integer = integer // 10
    return fractions


M = int(input("Enter the first natural number: "))

while M <= 0:
    M = int(input("Enter the first natural number: "))

N = int(input("Enter the second natural number: "))

while N <= 0:
    N = int(input("Enter the second natural number: "))

division_result = M / N

tenths = int(division_result * 10 - trunc(division_result) * 10)
ones = get_decimal_fractions(int(division_result))[0]

print("Tenths: " + str(tenths))
print("Ones: " + str(ones))
