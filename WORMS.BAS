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
 c(i) = 100
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
land = 199
FOR i = 1 TO 320
PSET (i, 2), 15
PSET (i, 199), 15
NEXT i
LINE (319, 199)-(319, 199 - (INT((200 - land) / 2))), 15
LINE (319, 2)-(319, 2 + INT((200 - land) / 2)), 15
DO
land = land - .1
LINE (319, 199)-(319, 199 - (INT((200 - land) / 2))), 15
LINE (319, 2)-(319, 2 + INT((200 - land) / 2)), 15
FOR i = 1 TO plrs
IF h(i) = 1 THEN
x(i) = x(i) + (.1 * b(i))
k$ = INKEY$
IF k$ <> "" THEN j$ = k$
IF j$ = p$(i) THEN b(i) = -b(i): c(i) = 2 * yold(i) - c(i): j$ = ""
y(i) = (x(i) * x(i)) * b(i)
IF POINT(150, c(i) + y(i)) = 15 OR y(i) + c(i) > 199 OR y(i) + c(i) < 0 THEN h(i) = 0
END IF
NEXT i
GET (3, 2)-(319, 199), a
CLS
PUT (2, 2), a
FOR i = 1 TO plrs
count = count + h(i)
IF h(i) = 1 THEN
LINE (149, yold(i))-(150, c(i) + y(i)), i:
yold(i) = y(i) + c(i)
END IF
NEXT i
IF count <> 0 THEN count = 0 ELSE EXIT DO
LOOP

