SCREEN 12
a = 10
b = 10
ax = 0
ay = 200
bx = 640
by = 200
cx = 1
cy = 1
dx = -1
dy = 1
r = a + b
g = 0
SLEEP 10
DO
e = a * (cx * cx + cy * cy) + b * (dx * dx + dy * dy)
LOCATE 1, 1: PRINT e
CIRCLE (ax, ay), a, 0
CIRCLE (bx, by), b, 0
cy = cy + g
ax = ax + cx
ay = ay + cy
dy = dy + g
bx = bx + dx
by = by + dy
IF ax > 640 - a THEN ax = 640 - a: cx = cx * -1
IF ax < a THEN ax = a: cx = cx * -1
IF ay > 480 - a THEN ay = 480 - a: cy = cy * -1
IF ay < a THEN ay = a: cy = cy * -1
IF bx > 640 - b THEN bx = 640 - b: dx = dx * -1
IF bx < b THEN bx = b: dx = dx * -1
IF by > 480 - b THEN by = 480 - b: dy = dy * -1
IF by < b THEN by = b: dy = dy * -1
CIRCLE (ax, ay), a, 1
CIRCLE (bx, by), b, 2
qx = bx - ax
qy = by - ay
rr = qx * qx + qy * qy
IF rr <= r * r THEN
ax = bx - qx / SQR(rr) * r
ay = by - qy / SQR(rr) * r
qx = bx - ax
qy = by - ay
c = (cx * qx + cy * qy) / r
e = (cx * qy + cy * qx) / r
d = (dx * qx + dy * qy) / r
f = (dx * qy + dy * qx) / r
x = (2 * b * d + c * (a - b)) / r
y = (2 * a * c - d * (a - b)) / r
cx = (x * qx + e * qy) / r
cy = (x * qy + e * qx) / r
dx = (y * qx + f * qy) / r
dy = (y * qy + f * qx) / r
END IF
LOOP

