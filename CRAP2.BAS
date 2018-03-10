SCREEN 12
TYPE mass
x AS DOUBLE
y AS DOUBLE
vx AS DOUBLE
vy AS DOUBLE
fx AS DOUBLE
fy AS DOUBLE
END TYPE
DIM SHARED m(2) AS mass
DIM SHARED x AS DOUBLE
DIM SHARED y AS DOUBLE
DIM SHARED fy AS DOUBLE
DIM SHARED fx AS DOUBLE
DIM SHARED t AS DOUBLE
DIM SHARED c AS DOUBLE
radius = 280
m(1).x = 100
m(1).y = 100
m(2).x = m(1).x + radius
m(2).y = m(1).y


m(2).vy = 1
m(1).vx = 0
m(2).vx = 0
m(1).vy = 1
DO
FOR i = 1 TO 1000
NEXT i
t = 0
v = 0
q = 0
FOR i = 1 TO 2
IF m(i).y + 3 >= 400 THEN
        y = m(i).y - m(3 - i).y
        x = m(i).x - m(3 - i).x
        m(i).vy = -ABS(m(i).vy * .9)' + m(3 - i).vy * (m(i).y - m(3 - i).y) / chord))
        m(3 - i).vy = m(3 - i).vy + m(i).vy * -y * -y / r / r
        m(3 - 1).vx = m(3 - i).vx + m(i).vy * -y * -x / r / r
        m(i).fy = 0
        ELSE m(i).fy = .005
END IF
y = m(3 - i).y - m(i).y
x = m(3 - i).x - m(i).x
r = SQR(x * x + y * y)
v = v + (m(i).vx * y - m(i).vy * x) / r
q = q - (m(i).vx * x + m(i).vy * y) / r
NEXT i
LOCATE 1, 1'
SLEEP 10
'LINE (m(1).x, m(1).y)-(m(2).x, m(2).y), 0
FOR i = 1 TO 2
y = m(3 - i).y - m(i).y
x = m(3 - i).x - m(i).x
'v = SQR(m(i).vx * m(i).vx + vy * vy)
angle = v / r / 2
sin2 = SIN(angle)
cos2 = COS(angle)
addy = -y * cos2 - x * sin2 + y
addx = -x * cos2 + y * sin2 + x
m(i).fx = addx - (v * -x / r)
m(i).fy = m(i).fy + addy - (v * -y / r)
m(i).vy = m(i).vy + m(i).fy
m(i).vx = m(i).vx + m(i).fx
CIRCLE (m(i).x, m(i).y), 4, 0
PRINT m(i).vy
NEXT i
FOR i = 1 TO 2
m(i).x = m(i).x + m(i).vx
m(i).y = m(i).y + m(i).vy
PRINT m(i).y
CIRCLE (m(i).x, m(i).y), 4, i
NEXT i
LINE (m(1).x, m(1).y)-(m(2).x, m(2).y), 14
LINE (0, 400)-(640, 400), 14
LOOP

