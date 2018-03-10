SCREEN 12
radius = 80
cx = 320
cy = 240
x = cx + radius
y = cy
vy = .005
vx = 0
pi = 3.14159265359#
time = 1000
LINE (cx, cy)-(x, y), 15
CIRCLE (x, y), SQR(vx * vx + vy * vy), 14
LINE (x, y)-(x + vx, y + vy), 1
CIRCLE (cx, cy), radius, 4
jx = x
jy = y
FOR t = 1 TO time
'SLEEP 1
dx = cx - x
dy = cy - y
r = SQR(dy * dy + dx * dx)
v = SQR(vx * vx + vy * vy)
v = (vx * dy - vy * dx) / r
LOCATE 1, 1
PRINT v, r
angle = v / r
sin2 = SIN(angle)
cos2 = COS(angle)
addy = -dy * cos2 - dx * sin2 + dy
addx = -dx * cos2 + dy * sin2 + dx
ax = addx - vx
ay = addy - vy + .005 * ABS(dx) / r - .005 * ABS(vy) / r
vx = vx + ax
vy = vy + ay
LINE (cx, cy)-(x, y), 0
LINE (cx, cy)-(jx, jy), 0
CIRCLE (x, y), SQR(vx * vx + vy * vy), 0
LINE (x, y)-(x + vx, y + vy), 0
x = x + vx
y = y + vy
LINE (cx, cy)-(x, y), 13
LINE (cx, cy)-(jx, jy), 15
CIRCLE (x, y), SQR(vx * vx + vy * vy), 14
LINE (x, y)-(x + vx, y + vy), 1
CIRCLE (cx, cy), radius, 4
NEXT t

'
SUB rotater (x, y, rx, ry, angle)
CONST pi = 3.14159265359#
dify = y - ry
difx = x - rx
sin2 = SIN(angle)
cos2 = COS(angle)
addy = dify * cos2 + difx * sin2 - dify
addx = difx * cos2 - dify * sin2 - difx
y = y + addy
x = x + addx
END SUB

