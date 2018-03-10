RANDOMIZE TIMER
SCREEN 12
bomb$ = "u10l10d10r10"
LET planetx = 320
LET planety = 479
FOR i = 1 TO 10
LINE (0, planety - i)-(640, planety - i), 6
NEXT i
LET px = 640
LET py = 200
PSET (px, py), 4: DRAW bomb$
DO UNTIL power > 50 AND power < 1000
INPUT power
LOOP
DO UNTIL angle > 0 AND angle < 180
INPUT angle
LOOP

LET dir = 1
IF angle > 90 THEN LET angle = 180 - angle: LET dir = -1
IF angle = 90 THEN LET angle = 89
DO UNTIL k$ <> ""
k$ = INKEY$
LOOP
DO UNTIL POINT(px, py + 1) <> 0
IF POINT(px, py + 1) = 0 THEN
LET gravity = 10 / (planety - py)
LET travelx = (powerx / 1000) * dir
LET travely = powery / 1000
LET py = py + gravity + powery
LET px = px + travel
END IF
PSET (px, py), 4: DRAW bomb$
FOR i = 1 TO 100
NEXT i
PSET (px, py), 0: DRAW bomb$
LOOP
PSET (px, py), 4
DO UNTIL g = 1
LOOP

