SCREEN 12
a$ = "111"
num = 243
x = 400
y = 350
DO
 seg$ = "r" + STR$(num)
 PRINT a$
 SLEEP 10
 CLS
 PSET (x, y), 15
 FOR i = 1 TO LEN(a$)
  k$ = MID$(a$, i, 1)
  IF k$ = "1" THEN
   LET angle = angle + 120
   IF angle >= 360 THEN LET angle = 0
   DRAW "ta" + STR$(angle) + seg$
  END IF
  IF k$ = "0" THEN
   LET angle = angle - 60
   IF angle <= -360 THEN LET angle = 0
   DRAW "ta" + STR$(angle) + seg$
  END IF
 NEXT i
 SLEEP 10
 ta$ = ""
 FOR i = 1 TO LEN(a$)
  ta$ = ta$ + MID$(a$, i, 1) + "010"
  NEXT i
 a$ = ta$
 num = num / 3
LOOP

