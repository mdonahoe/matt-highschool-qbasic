DECLARE SUB obs (gorch!)
SCREEN 7
DIM a(10000)
DO UNTIL plrs > 0
INPUT "# of players"; plrs
LOOP
plrs = INT(plrs)
DIM h(plrs)
DIM c(plrs)
DIM b(plrs)
DIM x(plrs)
DIM y(plrs)
DIM yold(plrs)
DIM p$(plrs)
DIM j$(plrs)
DIM score(plrs)
FOR i = 1 TO plrs
 h(i) = 1
 c(i) = INT((190 / (plrs + 1)) * i)
 b(i) = -1 ^ i
 x(i) = 1
 yold(i) = c(i)
NEXT i
FOR i = 1 TO plrs
PRINT "player"; i
DO UNTIL p$(i) <> "" AND LEN(p$) < 2
INPUT "control key"; p$(i)
LOOP
NEXT i
DO
score = 0
FOR i = 1 TO plrs
 h(i) = 1
 c(i) = INT((190 / (plrs + 1)) * i)
 b(i) = -1 ^ i
 x(i) = 1
 yold(i) = c(i)
NEXT i
CLS
FOR i = 1 TO 320
PSET (i, 2), 15
PSET (i, 194), 15
NEXT i
z = 0
gorch = 100
ready$ = ""
DO UNTIL k$ = CHR$(13)
k$ = INKEY$
LOOP
DO UNTIL z = 1
gorch = gorch - .001
CALL obs(INT(gorch))
FOR i = 1 TO plrs
IF h(i) = 1 THEN
x(i) = x(i) + (.1 * b(i))
k$ = INKEY$
IF k$ <> "" THEN j$ = k$
IF j$ = p$(i) THEN b(i) = -b(i): c(i) = 2 * yold(i) - c(i) + x(i): j$ = ""
y(i) = (x(i) * x(i) * 5) * b(i)
END IF
NEXT i
GET (3, 2)-(319, 194), a
CLS
PUT (2, 2), a
FOR i = 1 TO plrs
IF POINT(150, c(i) + y(i)) = 15 OR POINT(149, c(i) + y(i)) = 15 OR c(i) + y(i) > 193 OR c(i) + y(i) < 2 THEN h(i) = 0
count = count + h(i)
IF h(i) = 1 THEN
IF POINT(150, c(i) + y(i)) = 14 OR POINT(149, c(i) + y(i)) = 14 THEN score(i) = score(i) + 100
score(i) = score(i) + ABS(x(i))
COLOR i: LOCATE i, 1: PRINT INT(score(i))
LINE (149, yold(i))-(150, c(i) + y(i)), i:
yold(i) = y(i) + c(i)
END IF
NEXT i
IF count > 0 THEN count = 0 ELSE z = 1
LOOP
LOOP

SUB obs (gorch)
LINE (319, 2)-(319, 194), 15
FOR i = 0 TO 18
a = INT(RND * gorch)
storp = 14 * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2)' INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2) * INT(RND * 2)
IF a <> 0 THEN LINE (319, i * 10 + 3)-(319, (i + 1) * 10 + 3), storp
NEXT i
END SUB

