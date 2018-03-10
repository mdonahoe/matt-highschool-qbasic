
SCREEN 12
DIM yold(200)
c = 240
b = 1
x = 1
bit$ = "urd2l2u2r2"
plr$ = "c4"
clr$ = "c0"
DO

FOR i = 1 TO 199
SWAP yold(i), yold(i + 1)
NEXT i
x = x + (.1 * b)
IF j$ = "a" THEN j$ = ""
k$ = INKEY$
IF k$ <> "" THEN j$ = k$
IF j$ = "a" THEN b = -b: c = c + 2 * y
y = (x * x) * b
yold(200) = y + c
FOR i = 200 TO 1 STEP -1
PSET (i, yold(i)), 0: DRAW plr$ + bit$
NEXT i
FOR i = 1 TO 1000: NEXT i
FOR i = 200 TO 1 STEP -1
PSET (i, yold(i)), 0: DRAW clr$ + bit$
NEXT i
LOOP

