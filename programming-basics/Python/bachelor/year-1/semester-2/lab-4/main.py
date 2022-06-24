from QuadraticEquation import QuadraticEquation
from LinearEquation import LinearEquation
from random import randint


def generate_random_equation(Equation, min_coeff, max_coeff, number_of_instances, number_of_coefficients):
    try:
        equations = []
        for i in range(number_of_instances):
            coefficients = []
            for j in range(number_of_coefficients):
                coefficients.append(randint(min_coeff, max_coeff))
            eq = Equation(*coefficients)
            equations.append(eq)
        return equations
    except ValueError as e:
        print(str(e))


def main():
    n = int(input("Number of linear equations: "))
    m = int(input("Number of quadratic equations: "))
    min_coeff = int(input("Minimum coefficient: "))
    max_coeff = int(input("Maximum coefficient: "))

    linear_equations = generate_random_equation(LinearEquation, min_coeff, max_coeff, n, 2)
    quadratic_equations = generate_random_equation(QuadraticEquation, min_coeff, max_coeff, m, 3)

    for i in range(len(linear_equations)):
        print("Linear equation {}:\nRoot: {}; Coefficients: {};\n".format(i + 1, *linear_equations[i].find_roots(),
                                                                          linear_equations[i].get_coefficients()))

    print('\n')

    for i in range(len(quadratic_equations)):
        print("Quadratic equation {}:\nRoots: {}; Coefficients: {}\n".format(i + 1, quadratic_equations[i].find_roots(),
                                                                             quadratic_equations[i].get_coefficients()))

    linear_roots_sum = [eq.calculate_roots_sum() for eq in linear_equations]
    quadratic_equations_roots = [eq.calculate_roots_sum() for eq in quadratic_equations]

    linear_sum = sum(linear_roots_sum)
    quadratic_sum = 0

    for i in range(len(quadratic_equations_roots)):
        if quadratic_equations_roots[i] is not None:
            quadratic_sum += quadratic_equations_roots[i]

    print("Linear equations sum:", linear_sum)
    print("Quadratic equations sum:", quadratic_sum)

    possible_root = float(input("Possible root: "))
    is_linear = True if input('Check linear equation? (y/n): ') == 'y' else False
    equation_index = int(input("Equation index: "))

    equations = linear_equations if is_linear else quadratic_equations
    is_root_correct = False
    for index in range(len(equations)):
        if index == equation_index and equations[index].is_root(possible_root):
            is_root_correct = True
            break

    print('Root is correct' if is_root_correct else 'Root is incorrect')


if __name__ == '__main__':
    main()
