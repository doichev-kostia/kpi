def transform_celsius_to_fahrenheit(temperature):
    """ Transforms temperature from Celsius to Fahrenheit

    :param float temperature: temperature in Celsius
    :return : temperature in Fahrenheit
    """
    return 9 * temperature / 5 + 32


celsiusTemperature = int(input("Enter the positive temperature in Celsius: "))
temperatures = []

for i in range(0, celsiusTemperature + 1):
    fahrenheit = transform_celsius_to_fahrenheit(i)
    values = [i, fahrenheit]
    temperatures.append(values)

print("The result is: ")
for row in temperatures:
    print("Celsius: " + str(row[0]) + " Fahrenheit: " + str(row[1]))





