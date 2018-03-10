SCREEN 12
TYPE object
x AS SINGLE
y AS SINGLE
oldx AS SINGLE
oldy AS SINGLE
tx AS SINGLE
ty AS SINGLE
vx AS SINGLE
vy AS SINGLE
inair AS INTEGER
END TYPE
plane$ = "bd2l4u4r8d4l4"
maxnum = 100
DIM SHARED bomb(1 TO maxnum) AS object
RANDOMIZE TIMER
y = 480 - INT(RND * 300) + 20
FOR i = 0 TO 640
LINE (i, 480)-(i, y), 14
NEXT i
a = INT(RND * 30)
grav = -.005
FOR i = 1 TO a
planex = 0: planey = 20
FOR j = 1 TO 640 STEP .01
PSET (planex, planey), 0: DRAW "c0" + plane$
planex = planex + .01
PSET (planex, planey), 0: DRAW "c15" + plane$
b = INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2)
IF b = 1 AND INT(i) = i THEN
        bombnum = bombnum + 1
        IF bombnum > maxnm THEN bombnum = 1
        bomb(bombnum).x = planex
        bomb(bombnum).y = planey
        bomb(bombnum).vx = .01
        bomb(bombnum).ty = 1
        bomb(bombnum).inair = 1
END IF
FOR k = 1 TO bombnum
IF bomb(k).inair = 1 THEN
PSET (bomb(k).x, bomb(k).y), 0
bomb(k).ty = bomb(k).ty + .05
bomb(k).x = bomb(k).x - 1 + bomb(k).vx
bomb(k).vy = bomb(k).vy + grav * bomb(k).ty
bomb(k).y = bomb(k).y + bomb(k).vy
IF POINT(bomb(k).x, bomb(k).y) = 14 THEN
    FOR r = 1 TO 30
    CIRCLE (bomb(k).x, bomb(k).y), r, 0
    NEXT r
    bomb(k).inair = 0
END IF
PSET (bomb(k).x, bomb(k).y), 15
END IF
NEXT k
NEXT j
NEXT i

