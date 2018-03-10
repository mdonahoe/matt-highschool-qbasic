SCREEN 12
TYPE mass
m AS DOUBLE
x AS DOUBLE
y AS DOUBLE
vx AS DOUBLE
vy AS DOUBLE
ax AS DOUBLE
ay AS DOUBLE
fx AS DOUBLE
fy AS DOUBLE
END TYPE
DIM ball AS mass
ball.m = 4
ball.x = 320
ball.y = 130
ball.fx = 0
ball.ax = 0
ball.vx = 1
ball.vy = 0
g = .014
DIM c AS mass
c.m = 100
c.x = 320
c.y = 240
CIRCLE (c.x, c.y), c.m, 4
DO
LOCATE 1, 1: PRINT ball.vx

dy = -ball.y + c.y
dx = -ball.x + c.x
rr = dx * dx + dy * dy
ball.ay = g * c.m / rr * dy
ball.ax = g * c.m / rr * dx
ball.vx = ball.vx + ball.ax
ball.vy = ball.vy + ball.ay
CIRCLE (ball.x, ball.y), ball.m, 0
ball.x = ball.x + ball.vx
ball.y = ball.y + ball.vy
CIRCLE (ball.x, ball.y), ball.m, 15
LOOP


