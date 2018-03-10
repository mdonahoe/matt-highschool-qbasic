DECLARE SUB obs ()
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
FOR i = 1 TO plrs
 h(i) = 1
 c(i) = int((190/(plrs+1)) * i )
 b(i) = -1 ^ i
 x(i) = 1
 yold(i) = c(i)
NEXT i
FOR i = 1 TO plrs
PRINT "player"; b(i)
DO UNTIL p$(i) <> "" AND LEN(p$) < 2
INPUT "control key"; p$(i)
LOOP
NEXT i
CLS
FOR i = 1 TO 320
PSET (i, 2), 15
PSET (i, 194), 15
NEXT i
DO until z=1
CALL obs
FOR i = 1 TO plrs
IF h(i) = 1 THEN
x(i) = x(i) + (.1 * b(i))
k$ = INKEY$
IF k$ <> "" THEN j$ = k$
IF j$ = p$(i) THEN b(i) = -b(i): c(i) = 2 * yold(i) - c(i): j$ = ""
y(i) = (x(i) * x(i) * 5) * b(i)
END IF
NEXT i
GET (3, 2)-(319, 194), a
CLS
PUT (2, 2), a
FOR i = 1 TO plrs
IF POINT(150, c(i) + y(i)) = 15 OR POINT(149, c(i) + y(i)) = 15 or c(i)+y(i)>193 or c(i)+y(i)<2 THEN h(i) = 0
count = count + h(i)
IF h(i) = 1 THEN
LINE (149, yold(i))-(150, c(i) + y(i)), i:
yold(i) = y(i) + c(i)
END IF
NEXT i
IF count > 0 THEN count = 0 ELSE z=1
LOOP

SUB obs
LINE (319, 2)-(319, 194), 15
FOR i = 0 TO 18
a = INT(RND * 100)
IF a <> 0 THEN LINE (319, i * 10 + 3)-(319, (i + 1) * 10 + 3), 0
NEXT i
END SUB

