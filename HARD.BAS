DECLARE SUB drawing ()
DECLARE SUB hold ()
SCREEN 12
'CALL drawing
CLS
num = 400
thing$ = "111"
DO
PSET (500, 350), 15
angle = 0
seg$ = "r" + STR$(INT(num) + 1)
FOR i = 1 TO LEN(thing$)
'CALL hold
k$ = MID$(thing$, i, 1)
IF k$ = "1" THEN
angle = angle + 120
IF angle >= 360 THEN LET angle = 0
DRAW "ta" + STR$(angle) + seg$
END IF
IF k$ = "0" THEN
angle = angle - 60
IF angle <= -360 THEN LET angle = 0
DRAW "ta" + STR$(angle) + seg$
END IF
NEXT i
SLEEP 10
temp$ = ""
FOR i = 1 TO LEN(thing$)
temp$ = temp$ + MID$(thing$, i, 1) + "010"
NEXT i
thing$ = temp$
num = num / 3
LOOP

SUB drawing
CLS
thing$ = ""
angle = 0
num = 300
PSET (500, 350), 15
seg$ = "r" + STR$(num)
DO UNTIL z = 1
k$ = INKEY$
IF k$ = "q" THEN
PRINT thing$
END IF
IF k$ = "u" THEN
thing$ = thing$ + "u"
angle = angle - 60
IF angle <= -360 THEN LET angle = 0
DRAW "ta" + STR$(angle) + seg$
num = num + 1
END IF
IF k$ = "d" THEN
thing$ = thing$ + "d"
angle = angle + 120
IF angle >= 360 THEN LET angle = 0
DRAW "ta" + STR$(angle) + seg$
num = num + 1
END IF
LOOP
END SUB

SUB hold
FOR i = 1 TO 1
NEXT i
END SUB

