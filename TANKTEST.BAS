DECLARE SUB ground (tx!(), ty!(), p!)
DECLARE SUB fire (f!, pi!, bullet$, tang$(), turret$, tank$, tx!(), ty!(), angle!(), p!)
CLS
SCREEN 12
pi = 3.1415926535897#
bullet$ = "bl6u2r4f2g2l4u2"
tank$ = "ta0bu4l3d2r8f3g3l10h3e3r8u2l3bd4"
turret$ = "r10ul10d"
bit$ = "u2l2r2d2"
RANDOMIZE TIMER



DIM tx(8)
DIM ty(8)
DIM power(8)
DIM angle(8)
DIM health(8)
DIM tang$(8)
DIM name$(8)

DO UNTIL quit$ = "n"
quit$ = ""

plrs = 0
DO UNTIL plrs > 1 AND plrs < 9
INPUT "How many players"; plrs
LOOP


PRINT "Names:"
FOR p = 1 TO plrs
PRINT "Player"; p;
INPUT name$(p)
tx(p) = (640 / (plrs + 1)) * p
ty(p) = 0
power(p) = 0
angle(p) = 0
health(p) = 100
NEXT p

CLS
a = INT(RND * 5) + 1
b = INT(RND * 5) + 1
c = INT(RND * 5) + 1
d = INT(RND * 10) + 1

FOR x = 0 TO 640
y = 10 * a * SIN(x / 100 * b) + (2 * c * COS(x / d)) + 300
LINE (x, 400)-(x, y), 6
NEXT x

LET quit = 0

DO WHILE quit$ = ""

LINE (51, 435)-(500, 475), 15, BF

LET turn = turn + 1
IF turn > plrs THEN LET turn = 1
LET p = turn

IF health(p) > 0 AND POINT(tx(p), ty(p) + 5) <> 0 THEN
LET shot = 0
LET time = 50

DO UNTIL shot = 1
LET time = time - .1
IF time <= 0 THEN
 LET angle(p) = INT(RND * 180)
 LET power(p) = INT(RND * 500)
 LET time = 0
END IF


PSET (tx(p), ty(p)), 0: DRAW tang$(p) + turret$ + tank$

IF time > 0 THEN
IF POINT(tx(p), ty(p) + 5) <> 0 THEN
LET k$ = INKEY$
IF k$ = CHR$(0) + "P" THEN LET angle(p) = angle(p) - 3: SOUND 37, .1
IF k$ = CHR$(0) + "H" THEN LET angle(p) = angle(p) + 3: SOUND 37, .1
IF k$ = CHR$(0) + "K" THEN LET tx(p) = tx(p) - 1: SOUND 400, .1
IF k$ = CHR$(0) + "M" THEN LET tx(p) = tx(p) + 1: SOUND 400, .1
IF k$ = "0" THEN LET f = 0
IF k$ = "1" THEN LET f = 1
IF k$ = "2" THEN LET f = 2
END IF
CALL ground(tx(), ty(), p)
END IF
IF angle(p) >= 180 THEN LET angle(p) = 179
IF angle(p) < 1 THEN LET angle(p) = 1
LET tang$(p) = "ta" + STR$(angle(p))
IF ty(p) > 400 THEN LET health(p) = 0
LOCATE 27, 5: PRINT name$(p); ": "; "TIME"; INT(time); "angle"; angle(p); "health"; health(p)
PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$

IF time <= 0 OR k$ = CHR$(13) THEN CALL fire(f, pi, bullet$, tang$(), turret$, tank$, tx(), ty(), angle(), p): shot = 1

FOR hold = 1 TO 10000
NEXT hold
LOOP

END IF

FOR p = 1 TO plrs
 IF POINT(tx(p), ty(p)) = 0 THEN LET health(p) = health(p) - 10
 IF health(p) > 0 THEN PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$
 IF health(p) <= 0 THEN PSET (tx(p), ty(p)), 0: DRAW tang$(p) + turret$ + tank$
NEXT p

FOR p = 1 TO plrs
IF health(p) > 0 AND POINT(tx(p), ty(p) + 5) = 0 THEN LET g(p) = 1
NEXT p
DO UNTIL g(1) = 0 AND g(2) = 0 AND g(3) = 0 AND g(4) = 0 AND g(5) = 0 AND g(6) = 0 AND g(7) = 0 AND g(8) = 0
FOR p = 1 TO plrs
IF health(p) > 0 AND g(p) = 1 THEN
PSET (tx(p), ty(p)), 0: DRAW tang$(p) + turret$ + tank$
CALL ground(tx(), ty(), p)
PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$
END IF
IF POINT(tx(p), ty(p) + 5) <> 0 THEN LET g(p) = 0
NEXT p
LOOP

win = 0
FOR p = 1 TO plrs
IF health(p) > 0 THEN LET win = win + p
NEXT p
FOR p = 1 TO plrs
IF health(p) > 0 THEN
IF win = p THEN
CLS
PRINT "Player "; p; " wins!     Play again?  (y/n)"
DO UNTIL quit$ = "y" OR quit$ = "n"
INPUT quit$
LOOP
END IF
END IF
NEXT p

LOOP

LOOP

SUB fire (f, pi, bullet$, tang$(), turret$, tank$, tx(), ty(), angle(), p)
pow = 50
DO UNTIL k$ = CHR$(13) OR pow = 500
k$ = INKEY$
LET pow = pow + 1
LINE (pow, 435)-(pow, 475), 4
FOR i = 1 TO 500
NEXT i
LOOP
LET c = 1
LET d = 0
LET ang = angle(p)
IF angle(p) = 90 THEN LET ang = 89
IF angle(p) > 90 THEN LET ang = 180 - angle(p): LET c = -1: LET d = 180
LET ang = (ang * pi) / 180
LET pow = INT(pow * .7)
LET h1 = COS(ang) * pow
LET h = tx(p) + (h1 * c)
LET k1 = SIN(ang) * pow
LET s = h1 / k1
IF s > 2 THEN LET s = 2
LET k = ty(p) - k1
LET a = (h1 * h1) / k1
oldx = tx(p): oldy = ty(p)
z = 0
x = tx(p)
time = 0
DO UNTIL z = 1
k$ = INKEY$
time = time + 1
x = x + (s * c)
y = (1 / a) * ((x - h) * (x - h)) + k
FOR j = 1 TO 15
IF f = 1 AND time > 10 AND POINT(x, y) = j OR x > 640 OR x < 0 OR y > 480 THEN LET z = 1
NEXT j
IF f = 0 AND k$ = CHR$(13) AND POINT(x, y) = 0 AND POINT(x, y + 2) <> 0 THEN LET z = 1
IF f = 2 AND k$ = CHR$(13) THEN LET z = 1
LET ta = ATN((oldy - y) / (oldx - x))
LET ta = (INT((ta / pi) * 180)) * -1 + d
LET sang$ = "ta" + STR$(ta)
IF y < 400 AND y > 0 THEN
PSET (x, y), p: DRAW sang$ + bullet$
SOUND 2500 - y * 5, .2
PSET (x, y), 0: DRAW sang$ + bullet$
LET oldx = x: LET oldy = y
END IF
PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$
LOOP
IF y < 400 AND x > 0 AND x < 640 THEN
clr = 0
IF f = 0 THEN bsize = 200
IF f = 1 THEN bsize = 50
IF f = 2 THEN bsize = 100
d = .5
IF f <> 2 THEN
FOR i = 1 TO bsize STEP d
IF i < (bsize - 20) THEN CIRCLE (x, y), i, 4
SOUND bsize + INT(i), .05
IF i > 20 THEN clr = clr + d: CIRCLE (x, y), clr, 0
NEXT i
CIRCLE (x, y), clr + d, 4
PAINT (x, y), 4, 4
CIRCLE (x, y), clr, 0
PAINT (x, y), 0, 0
CIRCLE (x, y), clr + d, 0
END IF
IF f = 2 THEN
FOR i = 1 TO bsize STEP d
IF i < (bsize - 20) THEN LINE (x - (2 - (i / 50)), y - i)-(x + (2 - (i / 50)), y - i), 4: LINE (x - (2 - (i / 50)), y + i)-(x + (2 - (i / 50)), y + i), 4
SOUND bsize + INT(i), .05
IF i > 20 THEN clr = clr + d: LINE (x - (2 - (clr / 50)), y - clr)-(x + (2 - (clr / 50)), y - clr), 0: LINE (x - (2 - (clr / 50)), y + clr)-(x + (2 - (clr / 50)), y + clr), 0
NEXT i
END IF

END IF

END SUB

SUB ground (tx(), ty(), p)
IF POINT(tx(p), ty(p) + 5) = 0 THEN LET ty(p) = ty(p) + 1
IF POINT(tx(p) - 9, ty(p) - 1) <> 0 AND POINT(tx(p) - 9, ty(p) - 1) <> p THEN LET tx(p) = tx(p) + 1
IF POINT(tx(p) + 9, ty(p) + 1) <> 0 AND POINT(tx(p) + 9, ty(p) + 1) <> p THEN LET tx(p) = tx(p) - 1
END SUB

