CLS
SCREEN 12
INPUT "x"; tx
INPUT "y"; ty
INPUT "power"; pow
INPUT "angle"; ang
h = ((COS(ang) * pow) / 2) + tx
k = ty - ((SIN(ang) * pow) / 2)
a = ((tx - h) * (tx - h)) / (ty - k)
FOR x = tx TO 2 * tx STEP .001
y = a * ((x - h) * (x - h)) - k
PSET (x, y), 14
NEXT x
PRINT a, h, k, x, y

