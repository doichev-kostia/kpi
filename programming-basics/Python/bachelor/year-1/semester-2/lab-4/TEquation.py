class TEquation:
    _number_of_coefficients = 0
    _coefficients = []
    _roots = []

    def __init__(self, *coefficients):
        if self.are_coefficients_valid(coefficients):
            self._coefficients = coefficients
        else:
            raise ValueError("Invalid coefficients: {}".format(coefficients))

    def are_coefficients_valid(self, coefficients):
        is_valid_quantity = len(self.get_coefficients()) == self.get_number_of_coefficients()
        return is_valid_quantity and coefficients[0] != 0

    def find_roots(self):
        pass

    def get_roots(self):
        return self._roots

    def get_coefficients(self):
        return self._coefficients

    def get_number_of_coefficients(self):
        return self._number_of_coefficients

    def is_root(self, root):
        if self.get_roots() is None:
            return False

        if len(self.get_roots()) == 0:
            self.find_roots()

        for r in self.get_roots():
            if r == root:
                return True

    def calculate_roots_sum(self):
        if self.get_roots() is None:
            return None

        if len(self.get_roots()) == 0:
            self.find_roots()

        return sum(self.get_roots())