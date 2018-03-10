DECLARE SUB buttons ()
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
TYPE object
l AS INTEGER
w AS INTEGER
h AS INTEGER
cord AS pt
END TYPE

'vertices of box in 3d space
DIM SHARED vert(1 TO 8) AS pt

'2d version of vert
DIM SHARED pert(1 TO 8) AS pt

'velocity of box
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
a.y = 0
a.z = 0

'another pt
DIM SHARED d AS pt
d.x = 0
d.y = 0
d.z = 100

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

DIM SHARED box AS object
box.l = 10
box.w = 10
box.h = 10
box.cord.x = 10
box.cord.y = 0
box.cord.z = 130

DIM SHARED lowest
lowest = 1

'creates the box in 3d space
CALL converter

DO UNTIL k$ = "g"
CALL translate
CALL buttons
'rotating vertices around center pt of box
FOR i = 1 TO 8
CALL rotater(vert(i).x, vert(i).y, box.cord.x, box.cord.y, a.z)
CALL rotater(vert(i).z, vert(i).y, box.cord.z, box.cord.y, a.x)
CALL rotater(vert(i).x, vert(i).z, box.cord.x, box.cord.z, a.y)
NEXT i
o.x = o.x + a.x + da.x
o.y = o.y + a.y + da.y
o.z = o.z + a.z + da.z
IF o.x > 359 THEN o.x = 0
IF o.x < 0 THEN o.x = 359
IF o.y > 359 THEN o.y = 0
IF o.y < 0 THEN o.y = 359
IF o.z > 359 THEN o.z = 0
IF o.z < 0 THEN o.z = 359
'rotating box around other pt
FOR i = 1 TO 8
CALL rotater(vert(i).x, vert(i).y, d.x, d.y, da.z)
CALL rotater(vert(i).z, vert(i).y, d.z, d.y, da.x)
CALL rotater(vert(i).x, vert(i).z, d.x, d.z, da.y)
NEXT i
CALL rotater(box.cord.x, box.cord.y, d.x, d.y, da.z)
CALL rotater(box.cord.z, box.cord.y, d.z, d.y, da.x)
CALL rotater(box.cord.x, box.cord.z, d.x, d.z, da.y)

'clear old image
CALL printer(0)

'convert 3d to 2d
CALL threetwo

'print new box
CALL printer(15)

FOR hold = 1 TO 1000
NEXT hold

LOOP

SUB buttons
k$ = INKEY$
FOR i = 1 TO 8
IF i <> lowest AND vert(i).y < vert(lowest).y THEN
lowest = i
da.z = 0
da.x = 0
'LOCATE 1, 1: PRINT lowest
END IF
NEXT i
d.x = vert(lowest).x
d.y = vert(lowest).y
d.z = vert(lowest).z
IF k$ = "a" AND da.x = 0 THEN da.z = 3
IF k$ = "d" AND da.x = 0 THEN da.z = -3
IF k$ = "w" AND da.z = 0 THEN da.x = 3
IF k$ = "s" AND da.z = 0 THEN da.x = -3
END SUB

SUB converter
FOR i = 1 TO 2
FOR j = 1 TO 2
FOR k = 1 TO 2
w = (i - 1) * 4 + (j - 1) * 2 + k
vert(w).x = box.cord.x + (box.l / 2) * (3 - 2 * k)
vert(w).y = box.cord.y + (box.h / 2) * (3 - 2 * j)
vert(w).z = box.cord.z + (box.w / 2) * (3 - 2 * i)
NEXT k
NEXT j
NEXT i
FOR i = 1 TO 8
CALL rotater(vert(i).x, vert(i).y, box.cord.x, box.cord.y, o.z)
CALL rotater(vert(i).z, vert(i).y, box.cord.z, box.cord.y, o.x)
CALL rotater(vert(i).x, vert(i).z, box.cord.x, box.cord.z, o.y)
NEXT i
END SUB

SUB printer (x)
CONST ecks = 320
CONST why = 240
FOR i = 1 TO 4
LINE (pert(i).x + ecks, -pert(i).y + why)-(pert(i + 4).x + ecks, -pert(i + 4).y + why), x
NEXT i
FOR i = 1 TO 7 STEP 2
LINE (pert(i).x + ecks, -pert(i).y + why)-(pert(i + 1).x + ecks, -pert(i + 1).y + why), x
NEXT i
FOR i = 1 TO 2
LINE (pert(i).x + ecks, -pert(i).y + why)-(pert(i + 2).x + ecks, -pert(i + 2).y + why), x
NEXT i
FOR i = 5 TO 6
LINE (pert(i).x + ecks, -pert(i).y + why)-(pert(i + 2).x + ecks, -pert(i + 2).y + why), x
NEXT i
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
i = 1
LOCATE 1, 1: PRINT vert(i).x, vert(i).y, vert(i).z
END SUB

SUB threetwo
FOR i = 1 TO 8
pert(i).x = (vert(i).x - vw.x) * zdepth / (vert(i).z - vw.z)
pert(i).y = (vert(i).y - vw.y) * zdepth / (vert(i).z - vw.z)
NEXT i
END SUB

SUB translate
FOR i = 1 TO 8
vert(i).x = vert(i).x + v.x
vert(i).y = vert(i).y + v.y
vert(i).z = vert(i).z + v.z
NEXT i
box.cord.x = box.cord.x + v.x
box.cord.y = box.cord.y + v.y
box.cord.z = box.cord.z + v.z
END SUB

