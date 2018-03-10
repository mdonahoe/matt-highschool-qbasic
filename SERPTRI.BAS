SCREEN 12
RANDOMIZE TIMER
DIM px(6)
DIM py(6)
DATA 0,.5,1     ,0,0,0
DATA 0,1,0      ,0,0,0
n = 3
FOR i = 1 TO 6
READ px(i)
NEXT i
FOR i = 1 TO 6
READ py(i)
NEXT i
q = .5
x = .1
y = .7
DO
PSET (x * 600, (1 - y) * 400)
z = INT(RND * n + 1)
x = (px(z) - x) * q + x
y = (py(z) - y) * q + y
'PLAY "L" + STR$(INT(x * 40 + 1))
'PLAY "N" + STR$(INT(y * 80))
COLOR z
LOOP


