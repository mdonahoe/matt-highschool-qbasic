DECLARE SUB terrain (bout!)
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


max = 18
DIM tx(max)
DIM ty(max)
DIM power(max)
DIM angle(max)
DIM health(max)
DIM tang$(max)
DIM name$(max)
DIM score(max)
DIM g(max)
DO UNTIL quit$ = "n"
quit$ = ""

plrs = 0
DO UNTIL plrs > 1 AND plrs < (max + 1)
INPUT "How many players"; plrs
LOOP


PRINT "Names:"
FOR p = 1 TO plrs
PRINT "Player"; p;
INPUT name$(p)
score(p) = 0
NEXT p

game$ = ""
DO UNTIL game$ = "n"
game$ = ""
quit$ = ""
CLS
bout = INT(RND * 15) + 1
CALL terrain(bout)
FOR p = 1 TO plrs
LET shots = 0
tx(p) = (640 / (plrs + 1)) * p
ty(p) = 0
power(p) = 0
angle(p) = 0
health(p) = 20
NEXT p


LET quit = 0
LET turn = INT(RND * plrs)
DO WHILE quit$ = ""

LINE (51, 435)-(500, 475), 15, BF

LET turn = turn + 1
IF turn > plrs THEN LET turn = 1
LET p = turn

IF health(p) > 0 AND POINT(tx(p), ty(p) + 5) <> 0 THEN
LET shots = shots + 1
LET shot = 0
LET time = 50

DO UNTIL k$ = "t"
LET k$ = INKEY$
LOOP
LET f = 1
DO UNTIL shot = 1
LET time = time - .1
IF time <= 0 THEN
 LET angle(p) = INT(RND * 180)
 LET power(p) = INT(RND * 500)
 LET time = 0
END IF


PSET (tx(p), ty(p)), 0: DRAW tang$(p) + turret$ + tank$

k$ = ""
IF time > 0 THEN
IF POINT(tx(p), ty(p) + 5) <> 0 THEN
LET k$ = INKEY$
IF k$ = CHR$(0) + "P" THEN LET angle(p) = angle(p) - 3: SOUND 37, .1
IF k$ = CHR$(0) + "H" THEN LET angle(p) = angle(p) + 3: SOUND 37, .1
IF k$ = CHR$(0) + "K" THEN LET tx(p) = tx(p) - 1: SOUND 400, .1
IF k$ = CHR$(0) + "M" THEN LET tx(p) = tx(p) + 1: SOUND 400, .1
IF k$ = "1" THEN LET f = 1
IF k$ = "2" THEN LET f = 2
IF k$ = "3" THEN LET f = 3
END IF
CALL ground(tx(), ty(), p)
END IF
IF angle(p) >= 180 THEN LET angle(p) = 179
IF angle(p) < 1 THEN LET angle(p) = 1
LET tang$(p) = "ta" + STR$(angle(p))
IF ty(p) > 400 THEN LET health(p) = 0: LET shot = 1
LOCATE 27, 5: PRINT name$(p); ": "; "TIME"; INT(time); "angle"; angle(p); "health"; health(p)
PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$

IF time <= 0 OR k$ = CHR$(13) THEN CALL fire(f, pi, bullet$, tang$(), turret$, tank$, tx(), ty(), angle(), p): shot = 1

FOR hold = 1 TO 10000
NEXT hold
LOOP

END IF
LET t = p
LOCATE 2, 1: PRINT t
FOR p = 1 TO plrs
 IF health(p) > 0 AND ty(p) > 0 THEN
 IF POINT(tx(p), ty(p)) = 0 THEN LET health(p) = health(p) - 10: score(t) = score(t) + 10
 IF POINT(tx(p) + 7, ty(p)) = 0 THEN LET health(p) = health(p) - 5: score(t) = score(t) + 5
 IF POINT(tx(p) - 7, ty(p)) = 0 THEN LET health(p) = health(p) - 5: score(t) = score(t) + 5
 PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$
 END IF
 IF health(p) <= 0 THEN PSET (tx(p), ty(p)), 0: DRAW tang$(p) + turret$ + tank$
NEXT p

FOR p = 1 TO plrs
IF health(p) > 0 AND POINT(tx(p), ty(p) + 5) = 0 THEN LET g(p) = 1
NEXT p
DO UNTIL k$ = "q" OR g(1) = 0 AND g(2) = 0 AND g(3) = 0 AND g(4) = 0 AND g(5) = 0 AND g(6) = 0 AND g(7) = 0 AND g(8) = 0 AND g(9) = 0 AND g(10) = 0 AND g(11) = 0 AND g(12) = 0 AND g(13) = 0 AND g(14) = 0 AND g(15) = 0 AND g(16) = 0 AND g(17) = 0 AND g(18) = 0
k$ = INKEY$
FOR p = 1 TO plrs
LOCATE 1, 1: PRINT p
IF health(p) > 0 AND g(p) = 1 THEN
PSET (tx(p), ty(p)), 0: DRAW tang$(p) + turret$ + tank$
CALL ground(tx(), ty(), p)
IF shots > 0 AND ty(p) > 400 THEN LET health(p) = 0: score(t) = score(t) + 20
PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$
END IF
IF health(p) <= 0 OR POINT(tx(p), ty(p) + 5) <> 0 THEN LET g(p) = 0
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
PRINT "Player "; p; " wins!     Continue?  (y/n)"
DO UNTIL quit$ = "y" OR quit$ = "n"
INPUT quit$
LOOP
END IF
END IF
NEXT p
IF quit$ = "n" THEN game$ = "n"
LOOP
CLS
PRINT "score so far:"
FOR p = 1 TO plrs
PRINT name$(p); "="; score(p)
NEXT p
PRINT "Next Round?    (y/n)"
DO UNTIL game$ = "y" OR game$ = "n"
INPUT game$
LOOP

LOOP

LOOP

END

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
LET xpower = COS(ang) * pow
LET ypower = SIN(ang) * pow
oldx = tx(p): oldy = ty(p)
z = 0
x = tx(p) + c: y = ty(p) - 1
time = 0
DO UNTIL z = 1
k$ = INKEY$
time = time + .01
xshift = (xpower / 1000) * c
yshift = (ypower / 1000)
gravity = 2 / (480 - y)
x = x + xshift
y = y + gravity - yshift

FOR j = 1 TO 15
IF f <> 2 AND time > 10 AND POINT(x, y) = j OR x > 640 OR x < 0 OR y > 400 THEN LET z = 1
NEXT j
IF f = 2 AND k$ = CHR$(13) THEN LET z = 1
LET ta = ATN((oldy - y) / (oldx - x))
LET ta = (INT((ta / pi) * 180)) * -1 + d
LET sang$ = "ta" + STR$(ta)
IF y < 400 AND y > 0 THEN

PSET (x, y), p: DRAW sang$ + bullet$
IF snd$ = "y" AND INT(x) = x AND INT(y) = y THEN
SOUND 2500 - y * 5, .2
END IF
PSET (x, y), 0: DRAW sang$ + bullet$
LET oldx = x: LET oldy = y: xpower = xpower - ABS(xshift): ypower = ypower - yshift
END IF
PSET (tx(p), ty(p)), p: DRAW tang$(p) + turret$ + tank$
LOOP
IF y < 400 AND x > 0 AND x < 640 THEN
clr = 0
IF f = 3 THEN bsize = 200
IF f = 1 THEN bsize = 50
IF f = 2 THEN bsize = 100
d = .5
IF f = 1 OR f = 3 AND INT(RND * 6) + 1 = 1 THEN
FOR i = 1 TO bsize STEP d
IF i < (bsize - 20) THEN CIRCLE (x, y), i, 4
SOUND bsize + INT(i), .1
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
IF i < (bsize - 20) THEN LINE (x - (4 - (i / 25)), y - i)-(x + (4 - (i / 25)), y - i), 4: LINE (x - (4 - (i / 25)), y + i)-(x + (4 - (i / 25)), y + i), 4
SOUND bsize + INT(i), .05
IF i > 20 THEN clr = clr + d: LINE (x - (4 - (clr / 25)), y - clr)-(x + (4 - (clr / 25)), y - clr), 0: LINE (x - (4 - (clr / 25)), y + clr)-(x + (4 - (clr / 25)), y + clr), 0
NEXT i
END IF

END IF

END SUB

SUB ground (tx(), ty(), p)
IF POINT(tx(p), ty(p) + 5) = 0 THEN LET ty(p) = ty(p) + 1
IF POINT(tx(p) - 9, ty(p) - 1) <> 0 AND POINT(tx(p) - 9, ty(p) - 1) <> p THEN LET tx(p) = tx(p) + 1
IF POINT(tx(p) + 9, ty(p) + 1) <> 0 AND POINT(tx(p) + 9, ty(p) + 1) <> p THEN LET tx(p) = tx(p) - 1
END SUB

SUB terrain (bout)
gx1 = 0
DO UNTIL gx1 > 640
a = INT(RND * 5) + 1
b = INT(RND * 5) + 1
c = INT(RND * 5) + 1
d = INT(RND * 10) + 1
e = INT(RND * 350) + 1
f = INT(RND * 320) + gx1
FOR x = gx1 TO f
y = 10 * a * SIN(x / 100 * b) + (2 * c * COS(x / d)) + e
IF y < 20 THEN y = 20
IF x <= 640 THEN LINE (x, 400)-(x, y), (bout)
NEXT x
gx1 = x
LOOP
END SUB

