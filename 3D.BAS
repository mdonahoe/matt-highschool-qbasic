DECLARE SUB maker ()
DECLARE SUB rotater (x!, y!, rx!, ry!, angle!)
DECLARE SUB translate ()
DECLARE SUB converter ()
DECLARE SUB printer (x!)
DECLARE SUB threetwo ()
SCREEN 12
TYPE pt
x AS SINGLE
y AS SINGLE
z AS SINGLE
END TYPE
'objects 3D points
DIM SHARED vert(0 TO 10, 0 TO 1) AS pt
'2d version of vert
DIM SHARED pert(0 TO 10, 0 TO 1) AS pt

'velocity of object
DIM SHARED v AS pt
v.x = 0
v.y = 0
v.z = 0

'current angular orientation of the box
DIM SHARED o AS pt
o.x = 0
o.y = 0
o.z = 0

'angular velocity of box
DIM SHARED a AS pt
a.x = 0
a.y = 1
a.z = 0

'another pt
DIM SHARED d AS pt
d.x = 0
d.y = 0
d.z = 0

'angular velocity around pt d
DIM SHARED da AS pt
da.x = 0
da.y = 0
da.z = 0

'viewpoint location
DIM SHARED vw AS pt
vw.x = 0
vw.y = 0
vw.z = 0

'focus level?
DIM SHARED zdepth
zdepth = 1000


DIM SHARED lowest
lowest = 1


'creates the box in 3d space
DIM SHARED bas AS pt

DIM SHARED n(0 TO 1)
CALL maker

bas.x = 0
bas.y = 0
bas.z = 70
DO UNTIL k$ = "g"
'CALL translate

'rotating vertices around center pt of object
FOR g = 0 TO 1
FOR i = 0 TO n(g) - 1
CALL rotater(vert(i, g).x, vert(i, g).y, bas.x, bas.y, a.z)
CALL rotater(vert(i, g).z, vert(i, g).y, bas.z, bas.y, a.x)
CALL rotater(vert(i, g).x, vert(i, g).z, bas.x, bas.z, a.y)
NEXT i
NEXT g


'IF o.x > 359 THEN o.x = 0
'IF o.x < 0 THEN o.x = 359
'IF o.y > 359 THEN o.y = 0
'IF o.y < 0 THEN o.y = 359
'IF o.z > 359 THEN o.z = 0
'IF o.z < 0 THEN o.z = 359

'clear old image
CALL printer(0)

'convert 3d to 2d
CALL threetwo

'print new box
CALL printer(1)

FOR hold = 1 TO 2000
NEXT hold

LOOP

SUB buttons
END SUB

SUB converter
END SUB

SUB maker
bas.z = 100
bas.y = 0
bas.x = 0
b = 2
INPUT "H", h
g = 0
FOR g = 0 TO b - 1
INPUT "N", n(g)
INPUT "R", r
FOR i = 0 TO 359 STEP (360 / n(g))
vert(i / 360 * n(g), g).x = bas.x + r
vert(i / 360 * n(g), g).y = bas.y + g * h
vert(i / 360 * n(g), g).z = bas.z
CALL rotater(vert(i / 360 * n(g), g).x, vert(i / 360 * n(g), g).z, bas.x, bas.z, i)
NEXT i
NEXT g
bas.y = h / 2 * (b - 1)
END SUB

SUB printer (x)
CONST ecks = 320
CONST why = 240
FOR g = 0 TO 0
k = n(g + 1) / n(g)
FOR i = 0 TO n(g) - 2
LINE (pert(i, g).x + ecks, -pert(i, g).y + why)-(pert(i + 1, g).x + ecks, -pert(i + 1, g).y + why), x * 14
LINE (pert(i, g).x + ecks, -pert(i, g).y + why)-(pert(INT(i * k), g + 1).x + ecks, -pert(INT(i * k), g + 1).y + why), x * 2
NEXT i
LINE (pert(n(g) - 1, g).x + ecks, -pert(n(g) - 1, g).y + why)-(pert(0, g).x + ecks, -pert(0, g).y + why), x * 14
LINE (pert(n(g) - 1, g).x + ecks, -pert(n(g) - 1, g).y + why)-(pert(INT((n(g) - 1) * k), g + 1).x + ecks, -pert(INT((n(g) - 1) * k), g + 1).y + why), x * 2
NEXT g
g = 1
FOR i = 0 TO n(g) - 2
LINE (pert(i, g).x + ecks, -pert(i, g).y + why)-(pert(i + 1, g).x + ecks, -pert(i + 1, g).y + why), x * 14
NEXT i
LINE (pert(n(g) - 1, g).x + ecks, -pert(n(g) - 1, g).y + why)-(pert(0, g).x + ecks, -pert(0, g).y + why), x * 14
END SUB

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

SUB stats
END SUB

SUB threetwo
FOR g = 0 TO 1
FOR i = 0 TO n(g) - 1
pert(i, g).x = (vert(i, g).x - vw.x) * zdepth / (vert(i, g).z - vw.z)
pert(i, g).y = (vert(i, g).y - vw.y) * zdepth / (vert(i, g).z - vw.z)
NEXT i
NEXT g
END SUB

SUB translate
END SUB

