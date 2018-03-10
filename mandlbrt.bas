SCREEN 12
xmin = -8 / 3
xmax = 8 / 3
ymin = -2
ymax = 2
DIM xs AS DOUBLE
DIM ys AS DOUBLE
DIM x AS DOUBLE
DIM y AS DOUBLE
DO
LOCATE 1, 1: INPUT n
xs = (xmax - xmin) / 640
ys = (ymax - ymin) / 480
FOR x = xmin TO xmax STEP xs
FOR y = ymin TO ymax STEP ys
a = x
b = y
c = 0
DO WHILE ((SQR(a * a + b * b) < 2) AND (c < n))
'LOCATE 1, 1: PRINT (x - xmin) / xs, (y - ymin / ys), j
z = a
a = a * a - b * b + x
b = 2 * z * b + y
c = c + 1
LOOP
j = c
IF SQR(a * a + b * b) >= 2 THEN PSET ((x - xmin) / xs, (y - ymin) / ys), INT(c / n * 15)
NEXT y
NEXT x
xrd = (xmax - xmin) / 3
yrd = (ymax - ymin) / 3
PRINT xmin, xmax, ymin, ymax
LINE ((xrd) / xs, 0)-((xrd) / xs, 480), 4
LINE ((xrd * 2) / xs, 0)-((xrd * 2) / xs, 480), 5
LINE (0, (yrd) / ys)-(640, (yrd) / ys), 4
LINE (0, (yrd * 2) / ys)-(640, (yrd * 2) / ys), 15
xmint = xmin
ymint = ymin
INPUT q
IF q = 7 THEN
xmin = xmint
ymin = ymint
xmax = xrd + xmint
ymax = yrd + ymint
END IF
IF q = 8 THEN
xmin = xrd + xmint
ymin = ymint
xmax = xrd * 2 + xmint
ymax = yrd + ymint
END IF
IF q = 9 THEN
xmin = xrd * 2 + xmint
ymin = ymint
xmax = xmax
ymax = yrd + ymint
END IF
IF q = 4 THEN
xmin = xmint
ymin = yrd + ymint
xmax = xrd + xmint
ymax = yrd * 2 + ymint
END IF
IF q = 5 THEN
xmin = xrd + xmint
ymin = yrd + ymint
xmax = xrd * 2 + xmint
ymax = yrd * 2 + ymint
END IF
IF q = 6 THEN
xmin = xrd * 2 + xmint
ymin = yrd + ymint
xmax = xmax
ymax = yrd * 2 + ymint
END IF
IF q = 1 THEN
xmin = xmint
ymin = yrd * 2 + ymint
xmax = xrd + xmint
ymax = ymax
END IF
IF q = 2 THEN
xmin = xrd + xmint
ymin = yrd * 2 + ymint
xmax = xrd * 2 + xmint
ymax = ymax
END IF
IF q = 3 THEN
xmin = xrd * 2 + xmint
ymin = yrd * 2 + ymint
xmax = xmax
ymax = ymax
END IF
CLS
LOOP

