n = int(input("Enter a natural number: "))

for i in range(1, n, 1):
    have_same_divisor = False
    have_different_divisor = False

    # the loop starts from 2 as every number can be divided by 1
    for j in range(2, i + 1, 1):
        if i % j == 0:
            if n % j == 0:
                have_same_divisor = True
            else:
                have_different_divisor = True

    if not have_same_divisor and have_different_divisor:
        print(i)
    # 1 is co-prime number with any other number
    elif i == 1:
        print(i)
