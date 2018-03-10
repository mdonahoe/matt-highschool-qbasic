SCREEN 12
xmin = -8 / 3
ymin = -2
xmax = 8 / 3
ymax = 2
DIM xs AS DOUBLE
DIM ys AS DOUBLE
DIM x AS DOUBLE
DIM y AS DOUBLE
DO
INPUT n
xs = (xmax - xmin) / 640
ys = (ymax - ymin) / 480
FOR x = xmin TO xmax STEP xs
FOR y = ymin TO ymax STEP ys
a = x
b = y
c = 0
DO WHILE ((SQR(a * a + b * b) < 2) AND (c < n))
'LOCATE 1, 1: PRINT (x - xmin) / xs, (y - ymin / ys),j
z = a
a = a * a - b * b + x
b = 2 * z * b + y
c = c + 1
LOOP
j = c
IF (SQR(a * a + b * b) >= 2) THEN PSET ((x - xmin) / xs, (y - ymin) / ys), INT(c / n * 15)
NEXT y
NEXT x
xrt = (xmax - xmin) / 3
yrt = (ymax - ymin) / 3
LINE (xrt / xs, 0)-(xrt / xs, 480), 15
LINE (xrt * 2 / xs, 0)-(xrt * 2 / xs, 480), 15
LINE (0, yrt / ys)-(640, yrt / ys), 15
LINE (0, yrt * 2 / ys)-(640, yrt * 2 / ys), 15
INPUT q
xmint = xmin
ymint = ymin
IF q = 7 THEN
xmin = xmint
ymin = ymint
xmax = xmint + xrt
ymax = ymint + yrt
END IF
IF q = 8 THEN
xmin = xmint + xrt
ymin = ymint
xmax = xmint + xrt * 2
ymax = ymint + yrt
END IF

IF q = 9 THEN
xmin = xmint + xrt * 2
ymin = ymint
xmax = xmax
ymax = ymint + yrt
END IF

IF q = 4 THEN
xmin = xmint
ymin = ymint + yrt
xmax = xmint + xrt
ymax = ymint + yrt * 2
END IF

IF q = 5 THEN
xmin = xmint + xrt
ymin = ymint + yrt
xmax = xmint + xrt * 2
ymax = ymint + yrt * 2
END IF

IF q = 6 THEN
xmin = xmint + xrt * 2
ymin = ymint + yrt
xmax = xmax
ymax = ymin + yrt * 2
END IF

IF q = 1 THEN
xmin = xmint
ymin = ymint + yrt * 2
xmax = xmint + xrt
ymax = ymax
END IF

IF q = 2 THEN
xmin = xmint + xrt
ymin = ymint + yrt * 2
xmax = xmin + xrt * 2
ymax = ymax
END IF

IF q = 3 THEN
xmin = xmint + xrt * 2
ymin = ymint + yrt * 2
xmax = xmax
ymax = ymax
END IF
CLS
LOOP

