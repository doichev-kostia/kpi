from TEquation import TEquation


class QuadraticEquation(TEquation):
    def __init__(self, *coefficients):
        _number_of_coefficients = 3
        super().__init__(*coefficients)

    def find_roots(self):
        a = self.get_coefficients()[0]
        b = self.get_coefficients()[1]
        c = self.get_coefficients()[2]
        discriminant = b ** 2 - 4 * a * c
        if discriminant < 0:
            self._roots = None
        elif discriminant == 0:
            self._roots = [-b / (2 * a)]
        else:
            self._roots = [(-b + discriminant ** 0.5) / (2 * a), (-b - discriminant ** 0.5) / (2 * a)]
        return self._roots

