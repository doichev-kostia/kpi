from TEquation import TEquation


class LinearEquation(TEquation):
    def __init__(self, *coefficients):
        _number_of_coefficients = 2
        super().__init__(*coefficients)

    def find_roots(self):
        a = self.get_coefficients()[0]
        b = self.get_coefficients()[1]
        root = -b / a
        self._roots = [root]
        return self._roots

