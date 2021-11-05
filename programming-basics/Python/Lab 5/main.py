n = int(input("Enter a natural number: "))

for i in range(2, n, 1):
    have_same_divisor = False
    have_different_divisor = False

    for j in range(2, i + 1, 1):
        if i % j == 0:
            if n % j == 0:
                have_same_divisor = True
            else:
                have_different_divisor = True

    if not have_same_divisor and have_different_divisor:
        print(i)
