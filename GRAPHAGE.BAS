DECLARE SUB funct (a!())
DECLARE SUB agraph (cx, cy, xmin!, xmax!, ymin!, ymax!, xtick!, xtickscale!, xscale!, ytick!, ytickscale!, yscale!, graph!)
DECLARE SUB polar ()
DIM a(5)
DO
k$ = ""
SCREEN 12
CLS
LOCATE 8, 20: PRINT "Function Form"
LOCATE 12, 20: PRINT "Polar Coordinate Form"
LOCATE 16, 20: PRINT "Exit"
LET m = 8
LET graph = 3
LOCATE m, 18: PRINT "*"
FOR i = 1 TO 10000
NEXT i
DO UNTIL k$ = CHR$(13)
LET k$ = INKEY$
IF k$ = CHR$(0) + "P" THEN
 LOCATE m, 18: PRINT CHR$(0)
 IF m < 16 THEN LET m = m + 4
END IF
IF k$ = CHR$(0) + "H" THEN
 LOCATE m, 18: PRINT CHR$(0)
 IF m > 8 THEN LET m = m - 4
END IF
LOCATE m, 18: PRINT "*"
LOOP
IF m = 8 THEN CALL funct(a())
IF m = 12 THEN CALL polar
IF m = 16 THEN END
LOOP

SUB agraph (cx, cy, xmin, xmax, ymin, ymax, xtick, xtickscale, xscale, ytick, ytickscale, yscale, graph)
SCREEN 12
LET graph = 0
PRINT ""
PRINT "1:Reset graph to standard setting"
PRINT "2:Change graph setting"
DO UNTIL graph > 0 AND graph < 3
 INPUT graph
LOOP
IF graph = 2 THEN
flag = -9999
xmin = flag: xmax = flag: ymin = flag: ymax = flag: xtick = flag: ytick = flag
DO UNTIL xmin <= 0 AND xmin <> flag
 INPUT "X minimum=", xmin
LOOP
DO UNTIL xmax >= 0 AND xmax <> flag
 INPUT "X maximum=", xmax
LOOP
DO UNTIL ymin <= 0 AND ymin <> flag
 INPUT "Y minimum=", ymin
LOOP
DO UNTIL ymax >= 0 AND ymax <> flag
 INPUT "Y maximum=", ymax
LOOP
DO UNTIL xtick > 0
 INPUT "Value of tick marks on X axis=", xtick
LOOP
DO UNTIL ytick > 0
 INPUT "Value of tick marks on Y axis=", ytick
LOOP
END IF
IF graph = 1 THEN
xmin = -10
xmax = 10
ymin = -10
ymax = 10
xtick = 1
ytick = 1
END IF

xax = ABS(xmin) + xmax
xscale = 640 / xax
cx = ABS(xmin) * xscale
xtickscale = 640 / (xax / xtick)

yax = ABS(ymin) + ymax
yscale = 480 / yax
cy = ABS(ymax) * yscale
ytickscale = 480 / (yax / ytick)

CLS
LINE (0, 0)-(0, 479)
LINE (0, 0)-(639, 0)
LINE (0, 479)-(639, 479)
LINE (639, 0)-(639, 479)

LINE (0, cy)-(639, cy)
LINE (cx, 0)-(cx, 479)

FOR i = 1 TO xax / xtick
LINE (cx + (i * xtickscale), cy + 3)-(cx + (i * xtickscale), cy - 3)
LINE (cx - (i * xtickscale), cy + 3)-(cx - (i * xtickscale), cy - 3)
NEXT i

FOR i = 1 TO yax / ytick
LINE (cx + 3, cy + (i * ytickscale))-(cx - 3, cy + (i * ytickscale))
LINE (cx + 3, cy - (i * ytickscale))-(cx - 3, cy - (i * ytickscale))
NEXT i

END SUB

SUB funct (a())
FOR i = 1 TO 5
LET a(i) = 0
NEXT i

SCREEN 12
DO
CLS
LET deg = 0
LOCATE 8, 20: PRINT "Function Grapher"
DO UNTIL INKEY$ = CHR$(13)
LOOP

DO UNTIL deg > 0 AND deg < 5
 PRINT "Select degree   (1-4)"
 INPUT deg
LOOP
LET a = 65
FOR i = deg TO 1 STEP -1
 PRINT CHR$(a); "X";
 IF i > 1 THEN PRINT " ^"; i;
 PRINT "+";
 LET a = a + 1
NEXT i
PRINT CHR$(a)
PRINT ""
PRINT "Input values for coefficients"
LET a = 65
FOR i = deg + 1 TO 2 STEP -1
 PRINT CHR$(a);
 INPUT a(i)
 LET a = a + 1
NEXT i
PRINT CHR$(a);
INPUT a(i)
LET graph = 1
CALL agraph(cx, cy, xmin, xmax, ymin, ymax, xtick, xtickscale, xscale, ytick, ytickscale, yscale, graph)
'COLOR 6
C = .001
FOR x = xmin TO xmax STEP C
 y = (a(5) * (x ^ 4)) + (a(4) * (x ^ 3)) + (a(3) * (x ^ 2)) + (a(2) * (x)) + (a(1))
 x1 = cx + (xscale * x)
 y1 = cy - (yscale * y)
 IF y <= ymax AND y >= ymin THEN PSET (x1, y1)
 NEXT x
'COLOR 15
k$ = ""
PRINT "Continue? (y/n)"
DO UNTIL k$ = "n" OR k$ = "y"
 k$ = INKEY$
LOOP
CLS
IF k$ = "n" THEN EXIT DO
LOOP
m = 0
END SUB

SUB polar
SCREEN 12
CLS
PRINT "Select format"
PRINT "1: r = a*sin(b"; CHR$(233); ")"
PRINT "2: r = a + b*sin"; CHR$(233)
PRINT "3: r = "; CHR$(233); " + a"
PRINT "4: r = a*cos(b"; CHR$(233); ")"
PRINT "5: r = a + b*cos"; CHR$(233)
CHC = 0
DO UNTIL CHC > 0 AND CHC < 6
INPUT CHC
LOOP
INPUT "a", a
INPUT "b", b
LET C = 6.28
CALL agraph(cx, cy, xmin, xmax, ymin, ymax, xtick, xtickscale, xscale, ytick, ytickscale, yscale, graph)
IF CHC = 3 THEN LET C = C * (xmax / 5)
FOR i = -C TO C STEP .001
IF CHC = 1 THEN LET r = a * SIN(b * i)
IF CHC = 2 THEN LET r = a + (b * SIN(i))
IF CHC = 3 THEN LET r = i + a
IF CHC = 4 THEN LET r = a * (COS(b * i))
IF CHC = 5 THEN LET r = a + (b * COS(i))
x = r * COS(i)
y = r * SIN(i)
x1 = cx + (xscale * x)
y1 = cy - (yscale * y)
IF y <= ymax AND y >= ymin THEN PSET (x1, y1)
NEXT i
PRINT "Done"
DO UNTIL INKEY$ = CHR$(13)
LOOP
END SUB

