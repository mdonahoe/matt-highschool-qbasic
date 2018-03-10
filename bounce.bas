DECLARE SUB printer2 ()
DECLARE SUB hold (n!)

DECLARE FUNCTION reflecto! (x!, vx1!, vy1!, chc!)
DECLARE SUB physics3 (x!, vx!, y!, vy!)
DECLARE SUB physics2 ()
DECLARE SUB terrain ()
DECLARE SUB rotater (x!, y!, rx!, ry!, angle!)
SCREEN 12
TYPE ball
x AS SINGLE
y AS SINGLE
oldx AS SINGLE
oldy AS SINGLE
vx AS SINGLE
vy AS SINGLE
va AS SINGLE
a AS SINGLE
r AS SINGLE
END TYPE
DIM SHARED bombs(10) AS ball
DIM SHARED cg AS ball
DIM SHARED ground(640, 2)
CONST max = 2
CONST pi = 3.141592653587#
CONST sand = 3
CONST dirt = 2
CALL terrain
cg.x = 320
cg.y = 30
cg.oldx = cg.x
cg.oldy = cg.y
cg.va = 0' .1
cg.vx = 0
cg.vy = 0
bombs(1).r = 10
bombs(2).r = 10
bombs(2).y = cg.y
bombs(1).a = 0
bombs(2).a = 180
'CALL maker(2, 10)
DO
CALL physics2
CALL physics3(cg.x, cg.vx, cg.y, cg.vy)
CALL printer2
CALL hold(1)
LOOP

SUB hold (n)
FOR j = 1 TO 10 * n
FOR i = 1 TO 1000
NEXT i
NEXT j
END SUB

SUB maker (n, r)
FOR i = 0 TO 359 STEP (360 / n)
        bombs(i / 360 * n).x = cg.x + r
        bombs(i / 360 * n).y = cg.y
        CALL rotater(bombs(i / 360 * n).x, bombs(i / 360 * n).y, cg.x, cg.y, i)
NEXT i
END SUB

SUB physics2
FOR i = 1 TO max
        bombs(i).oldx = bombs(i).x
        bombs(i).oldy = bombs(i).y
        bombs(i).x = cg.x + bombs(i).r * COS((cg.a + bombs(i).a) * pi / 180)
        bombs(i).y = cg.y + bombs(i).r * SIN((cg.a + bombs(i).a) * pi / 180)
        IF bombs(i).y + 5 >= ground(INT(bombs(i).x), 1) THEN
                dx = ABS(cg.x - bombs(i).x)
                dy = ABS(cg.y - bombs(i).y)
                r = bombs(i).r
                v = -cg.va / 180 * pi * r
                bombs(i).vx = (v * dy / r + cg.vx) * .6
                bombs(i).vy = (v * dx / r + cg.vy) * .6
                'PRINT bombs(i).vy
                'SLEEP 10
                cg.y = cg.y + ground(INT(bombs(i).x), 1) - bombs(i).y - 5
                vx = reflecto(bombs(i).x, bombs(i).vx, bombs(i).vy, 1)
                vy = reflecto(bombs(i).x, bombs(i).vx, bombs(i).vy, 2)
                'PRINT vy
                'SLEEP 10
                cg.vy = cg.vy + (dy * dy * vy + dy * dx * vx) / (r * r)
                cg.vx = cg.vx + (dx * dx * vx + dx * dy * vy) / (r * r)
                cg.va = cg.va - 180 * (dx * vy + dy * vx) / (pi * r * r)
                'PRINT cg.vy, cg.vx, cg.va
                'PRINT cg.vx, 33
        END IF
NEXT i
END SUB

SUB physics3 (x, vx, y, vy)
        gravity = .005
        x = x + vx
        vy = vy + gravity
        y = y + vy
        IF x <= 50 THEN
                x = 1
                vx = ABS(vx) * .6
        END IF
        IF x >= 619 THEN
                x = 639
                vx = ABS(vx) * -.6
        END IF
        cg.a = cg.a + cg.va
        IF cg.a > 360 THEN cg.a = cg.a - 360
        IF cg.a < 0 THEN cg.a = cg.a + 360
END SUB

SUB printer2
FOR i = 1 TO max - 1
CIRCLE (bombs(i).oldx, bombs(i).oldy), 2, 0
LINE (bombs(i).oldx, bombs(i).oldy)-(bombs(i + 1).oldx, bombs(i + 1).oldy), 0
NEXT i
CIRCLE (bombs(i).oldx, bombs(i).oldy), 2, 0
LINE (bombs(i).oldx, bombs(i).oldy)-(bombs(1).oldx, bombs(1).oldy), 0
'SLEEP 10
FOR i = 1 TO max - 1
CIRCLE (bombs(i).x, bombs(i).y), 2, 15
LINE (bombs(i).x, bombs(i).y)-(bombs(i + 1).x, bombs(i + 1).y), 15
NEXT i
CIRCLE (bombs(i).x, bombs(i).y), 2, 15
LINE (bombs(i).x, bombs(i).y)-(bombs(1).x, bombs(1).y), 15

END SUB

FUNCTION reflecto (x, vx1, vy1, chc)
slope = ground(x, 2)
xA = vx1 * 10
yA = -vy1 * 10
rA = SQR(xA * xA + yA * yA)
IF rA > 0 THEN
cosA = xA / rA
sinA = yA / rA
xB = slope
yB = 1
rB = SQR(xB * xB + yB * yB)
cosB = xB / rB
sinB = yB / rB
sinR = 2 * sinB * cosB * cosA - sinA * cosB * cosB + sinB * sinB * sinA
cosR = 2 * cosB * sinB * sinA - cosA * sinB * sinB + cosB * cosB * cosA
'PLAY "T32L64MBN" + STR$(INT(cosR * 42 + 42))
xR = cosR * rA / 10
yR = sinR * rA / 10
vx2 = -xR
vy2 = yR
END IF
IF chc = 1 THEN reflecto = vx2
IF chc = 2 THEN reflecto = vy2
END FUNCTION

SUB rotater (x, y, rx, ry, angle)
CONST pi = 3.14159265359#
CONST ango = pi / 180
dify = y - ry
difx = x - rx
sin2 = SIN(angle * ango)
cos2 = COS(angle * ango)
addy = dify * cos2 + difx * sin2
addx = difx * cos2 - dify * sin2
y = ry + addy
x = rx + addx
END SUB

SUB terrain
a = 10 * INT(RND * 5 + 1)
b = .01 * INT(RND * 5 + 1)
c = 2 * INT(RND * 5 + 1)
d = 1 / INT(RND * 25 + 10)
gv = RND - .5
e = -gv * 400 + 240
'e = -(gv + ABS(gv)) * gv * 400 + 440
'LOCATE 3, 1: PRINT a, b, c, d, e, gv
FOR x = 1 TO 640
ground(x, 1) = 200'e + gv * x + gv * gv * gv * (x - 320) * (x - 320) / 100 + a * SIN(x * b) + c * COS(x * d)
ground(x, 2) = 0'gv + gv * gv * gv * (2 * x - 640) / 100 + a * b * COS(x * b) - c * d * SIN(x * d)
NEXT x
FOR x = 1 TO 640
y = ground(x, 1)
'LINE (x, y - 1)-(x, y - 31), sand
LINE (x, y - 1)-(x, 480), dirt
NEXT x
END SUB

