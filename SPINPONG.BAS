DECLARE SUB balls (ball$, x!, a!, y!, b!, c!)
SCREEN 12
RANDOMIZE TIMER
paddle$ = "r32l64dr64dl64dr64"
ball$ = "bu5l5d10r10u10l5"
x = 320: y = 240: a = 1: b = 1
INPUT plrs
DIM k(plrs)
DIM c(plrs)
DIM p$(plrs)
FOR i = 1 TO plrs
INPUT "control key"; p$(i)
c(i) = 1
NEXT i
CLS
DO UNTIL z = 1
k$ = INKEY$
FOR i = 1 TO plrs
IF k$ = p$(i) THEN c(i) = -c(i): k$ = ""
k(i) = k(i) + (c(i) / 2)
IF k(i) = 180 OR k(i) = -180 THEN LET k(i) = 0
PSET (320, 240), 0: DRAW "c" + STR$(i) + "ta" + STR$(INT(k(i))) + "bd" + STR$(240 - 10 * i) + paddle$
PSET (320, 240), 0: DRAW "c" + STR$(i) + "ta" + STR$(INT(k(i) - 180)) + "bd" + STR$(240 - 10 * i) + paddle$
NEXT i
CALL balls(ball$, x, a, y, b, 1)
FOR j = 1 TO 100 - 10 * plrs
NEXT j
FOR i = 1 TO plrs
PSET (320, 240), 0: DRAW "c0" + "ta" + STR$(INT(k(i))) + "bd" + STR$(240 - 10 * i) + paddle$
PSET (320, 240), 0: DRAW "c0" + "ta" + STR$(INT(k(i) - 180)) + "bd" + STR$(240 - 10 * i) + paddle$
NEXT i
CALL balls(ball$, x, a, y, b, 0)
LOOP

SUB balls (ball$, x, a, y, b, c)
x = x + a * c
y = y + b * c
IF y > 480 THEN LET y = 480: LET b = -b
IF y < 0 THEN LET y = 0: LET b = -b
IF x > 640 THEN LET x = 640: LET a = -a
IF x < 0 THEN LET x = 0: LET a = -a
IF POINT(x, y) > 0 THEN b = INT(RND * 3 - 1): a = INT(RND * 3 - 1)
PSET (x, y), 0: DRAW "c" + STR$(c * 4) + ball$
END SUB

