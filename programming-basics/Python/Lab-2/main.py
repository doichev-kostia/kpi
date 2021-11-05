coordX = float(input("Enter x coordinate: "))
coordY = float(input("Enter y coordinate: "))

output = ""

if coordX == 0 and coordY == 0:
    output = "The point is lying on the origin of the coordinate system"
elif coordX == 0:
    output = "The point is lying on Y-axis"
elif coordY == 0:
    output = "The point is lying on X-axis"
elif coordX > 0 and coordY > 0:
    output = "The point is lying on the first quadrant"
elif coordX > 0 and coordY < 0:
    output = "The point is lying on the forth quadrant"
elif coordX < 0 and coordY > 0:
    output = "The point is lying on the second quadrant"
else:
    output = "The point is lying on the third quadrant"

print(output)
