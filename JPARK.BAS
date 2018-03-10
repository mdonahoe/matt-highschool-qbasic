SCREEN 12
ta$ = "1"
na$ = ""
leg = 1000
DO
angle = 0
PSET (320, 800), 15
DRAW "u" + STR$(INT(leg))
na$ = ""
FOR i = 1 TO LEN(ta$)
IF MID$(ta$, i, 1) = "1" THEN
na$ = "0" + na$
angle = angle + 90
IF angle > 360 THEN angle = 0
END IF
IF MID$(ta$, i, 1) = "0" THEN
na$ = "1" + na$
angle = angle - 90
IF angle < 0 THEN angle = 360
END IF
DRAW "ta" + STR$(angle) + "u" + STR$(INT(leg))
NEXT i
ta$ = ta$ + "0" + na$
leg = 1
SLEEP 10
CLS
LOOP

