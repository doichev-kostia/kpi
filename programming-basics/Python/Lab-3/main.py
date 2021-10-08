from math import *


def fact(number):
    """Calculates factorial

    :param int number: a number which factorial should be calculated
    :return: factorial
    """
    if number <= 1:
        return 1
    else:
        return number * fact(number - 1)


def calculate_sinus(sin, iteration, sinArgument):
    sin_numerator = pow(-1, iteration) * pow(sinArgument, 2 * iteration + 1)
    return sin + sin_numerator / fact(2 * iteration + 1)


sinArgument = float(input("Enter sinus argument: "))
accuracy = float(input("Enter accuracy: "))

iteration = 1
sin = sinArgument
prev_value = sin

sin = calculate_sinus(sin, iteration, sinArgument)
difference = abs(sin - prev_value)

while difference > accuracy:
    prev_value = sin
    iteration += 1
    sin = calculate_sinus(sin, iteration, sinArgument)
    difference = abs(sin - prev_value)

print("The result is " + str(sin))
