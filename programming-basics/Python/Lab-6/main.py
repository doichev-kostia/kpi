import math

def calculate_step(a, b, n):
    return (b - a) / n


def calculate_sin (a, b, n):
    h = calculate_step(a, b, n)
    sum = 0
    for i in range(1, n):
        sum += pow(math.atan(a + i * h), 2)

    func_sum = pow(math.atan(a), 2) + pow(math.atan(b), 2)
    return h * (func_sum / 2 + sum)


def calculate_arctg (a, b, n):
    h = calculate_step(a, b, n)
    sum = 0
    for i in range(1, n):
        exponent = 10 * (a + i * h)
        sum += math.sin(math.pow(math.e, exponent))

    func_sum = math.sin(math.pow(math.e, 10 * a)) + math.sin(math.pow(math.e, 10 * b))
    return h * (func_sum / 2 + sum)


def calculate_integral(a, b, n):
    return calculate_arctg(a, b, n) + calculate_sin(0, math.pi, n)


a = int(input("Enter a: "))
b = int(input("Enter b: "))
n = int(input("Enter natural n: "))

while n <= 0:
    n = int(input("Enter natural n: "))

res = calculate_integral(a, b, n)

print(res)


