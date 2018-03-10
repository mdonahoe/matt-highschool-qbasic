DIM a(10000)
quit = 0
DO UNTIL quit = 1
RANDOMIZE TIMER
SCREEN 12
CLS
x = INT(RND * 2)
c = INT(RND * 15) + 1
FOR i = 1 TO (INT(RND * 30) + 1)
CIRCLE (320, 240), i, c
NEXT i
GET (320 - i, 240 - i)-(320 + i, 240 + i), a(1)
LET s = 2 * i
LET xm = 639 - s
LET ym = 479 - s
LET cx = 320 - i
LET cy = 240 - i
a = INT(RND * 12) - 6
b = INT(RND * 12) - 6
LET n = 0
CLS
DO WHILE n = 0
IF x = 1 THEN PUT (cx, cy), a(1), PSET
FOR i = 1 TO 1000
NEXT i
PUT (cx, cy), a(1), XOR
LET cx = cx + a
LET cy = cy + b
IF cx >= xm THEN LET cx = xm: LET a = INT(RND * -6)
IF cy >= ym THEN LET cy = ym: LET b = INT(RND * -6)
IF cx <= 0 THEN LET cx = 0: LET a = INT(RND * 6) + 1
IF cy <= 0 THEN LET cy = 0: LET b = INT(RND * 6) + 1
LET K$ = INKEY$
IF K$ = CHR$(13) THEN LET n = 1
IF K$ = "E" THEN LET quit = 1: LET n = 1
LOOP
LOOP

