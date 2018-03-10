RANDOMIZE TIMER
SCREEN 0
CLS
DIM a(10, 2)
DIM b(10, 2)
DIM a$(3)
a$(1) = CHR$(219)
a$(2) = " "
a$(3) = CHR$(157)
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
FOR j = 1 TO 2
FOR i = 1 TO 10
READ a(i, j)
NEXT i
NEXT j
time = 1
DO
time = time * -1
up = 0: down = 0
IF time = -1 THEN
blockpos = INT(RND * 2)
IF blockpos = 0 THEN down = -1 ELSE up = -1
END IF
FOR i = 1 TO 9
FOR j = 1 TO 2
b(i, j) = a(i + 1, j)
NEXT j
NEXT i
b(10, 1) = up: b(10, 2) = down
FOR i = 1 TO 10
FOR j = 1 TO 2
a(i, j) = b(i, j)
LOCATE j, i: PRINT a$(a(i, j) + 2)
NEXT j
NEXT i
FOR i = 1 TO 10000
NEXT i
LOOP

