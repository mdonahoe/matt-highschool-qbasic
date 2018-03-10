SCREEN 12
RANDOMIZE TIMER
n = 3
DIM px(n)
DIM py(n)
DATA 0,.5,1
DATA 0,1,0
FOR i = 1 TO n
READ px(i)
NEXT i
FOR i = 1 TO n
READ py(i)
NEXT i
x = 0
y = 0
a = 2
FOR i = 1 TO 10000
NEXT i

DO
'FOR i = 1 TO 1000
'NEXT i
PSET (x * .1 + 320, (1 - y) * .1 + 240), z
z = INT(RND * n + 1)
x = (px(z) - x) * a + x
y = (py(z) - y) * a + y
COLOR z
LOOP

