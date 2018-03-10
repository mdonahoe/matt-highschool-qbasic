SCREEN 12
ta$ = ""
sa$ = ""
leg = 3
DO
sa$ = ""
angle = 0
PSET (400, 100), 15
DRAW "ta0u" + STR$(leg)
FOR i = 1 TO LEN(ta$)
IF MID$(ta$, i, 1) = "R" THEN
angle = angle + 90
IF angle = 360 THEN angle = 0
sa$ = "L" + sa$
END IF
IF MID$(ta$, i, 1) = "L" THEN
angle = angle - 90
IF angle < 0 THEN angle = 270
sa$ = "R" + sa$
END IF
DRAW "ta" + STR$(angle) + "u" + STR$(leg)
NEXT i
SLEEP 10
CLS
ta$ = ta$ + "R" + sa$
'PRINT ta$
LOOP

