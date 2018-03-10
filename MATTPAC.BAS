DECLARE SUB editor (l$(), spot$, pellet$)
DECLARE SUB help ()
SCREEN 12
RANDOMIZE TIMER
DIM pac$(4)
DIM oldx(7)
DIM oldy(7)
DIM a(6)
DIM b(6)
DIM d(6)
DIM s(6)
DIM health(6)
DIM space(17, 15)
DIM tempdot(17, 15)
bgc = 4
l$(4) = "bm+15,-14g2d25f2u28"
l$(1) = "bm-15,-15f2r26e2l30"
l$(2) = "bm-15,-14f2d25g2u28"
l$(3) = "bm-15,15e2r26f2l30"
spot$ = "bm-4,-4r8d8l8u8"
pellet$ = "bm+1,1r6d6l6u5r5d5l5u4r4d4l4u3r3d3l3u2r2d2l2urdl"
pac$(1) = "bu9l9d18r18u1h8e8u1l9"
pac$(2) = "bu9l9d18r18u3m-8,-6m+8,-6u3l9"
pac$(3) = "bu9l9d18r18u6m-8,-3m+8,-3u6l9"
pac$(4) = "bu9l9d18r18u9l8r8u9l9"
clr$ = "c0bu9r9l18d18r18u17l17d16r17u15l16d14r16u13l16d12r16u11l16d10r16u9l16d8r16u7l16d6r16u5l16d4r16u3l16d2r16u1l16"
 z = 0
 DO UNTIL z = 1
  CLS
  LOCATE 9, 33: PRINT "PacMan"
  LOCATE 10, 33: PRINT "by matt donahoe"
  LOCATE 15, 35: PRINT "Play Game"
  LOCATE 18, 35: PRINT "Level Editor"
  LOCATE 21, 35: PRINT "Help"
  LOCATE 24, 35: PRINT "Exit"
  LET m = 15
  k$ = ""
  PSET (268, (16 * m) - 8), 0: DRAW "c4" + pellet$
  FOR i = 1 TO 100000
  NEXT i
  DO UNTIL k$ = CHR$(13)
   LET k$ = INKEY$
   IF k$ = CHR$(0) + "P" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + pellet$
    IF m < 24 THEN LET m = m + 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + pellet$
   END IF
   IF k$ = CHR$(0) + "H" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + pellet$
    IF m > 15 THEN LET m = m - 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + pellet$
   END IF
  LOOP
  FOR x = 268 TO 640
  PSET (x, (16 * m) - 8), 0: DRAW "c4" + pellet$
  FOR i = 1 TO 100
  NEXT i
  PSET (x, (16 * m) - 8), 0: DRAW "c0" + pellet$
  NEXT x
  IF m = 15 THEN z = 1
  IF m = 18 THEN CALL editor(l$(), spot$, pellet$)
  IF m = 21 THEN CALL help
  IF m = 24 THEN END
 LOOP

DO UNTIL k$ = CHR$(13)
k$ = INKEY$
LOOP
DO UNTIL again$ = "n"
again$ = ""
z = 0
FOR i = 1 TO 6
health(i) = 3
NEXT i


DO UNTIL game = 1
CLS
levelscore = 0
OPEN "pacman.dat" FOR INPUT AS #1
INPUT #1, current
CLOSE #1
level = INT(RND * current) + 1
level$ = MID$(STR$(level), 2, LEN(STR$(level)) - 1) + ".map"
OPEN level$ FOR INPUT AS #1
FOR i = 1 TO 17
FOR j = 1 TO 15
INPUT #1, space(i, j), d
q = space(i, j)
tempdot(i, j) = 0
IF q >= 8 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(4): LET q = q - 8
IF q >= 4 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(3): LET q = q - 4
IF q >= 2 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(2): LET q = q - 2
IF q >= 1 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(1): LET q = q - 1
IF d = 1 THEN PSET ((i * 30) - 14, (j * 30) - 14), 0: DRAW "c15" + pellet$: levelscore = levelscore + 1
tempdot(i, j) = d
NEXT j
NEXT i
CLOSE #1
px(1) = 20
py(1) = 20
px(2) = 500
py(2) = 20
plrs = 2
chew = 1
s(1) = 10
s(2) = 10
FOR g = 3 TO 6
d(g) = g - 2
s(g) = 5
px(g) = 260
py(g) = 230
NEXT g
z = 0
time = 0
LOCATE 1, 70: PRINT "SCORES:"
FOR p = 1 TO plrs
 IF health(p) > 0 THEN
  FOR i = 1 TO health(p)
   CIRCLE (510 + 20 * i, 200 + 20 * p), 10, p
   PAINT (510 + 20 * i, 200 + 20 * p), p, p
  NEXT i
 END IF
NEXT p
DO UNTIL z = 1
 LET k$ = INKEY$
 IF health(1) > 0 THEN
  IF k$ = CHR$(0) + "K" THEN LET d(1) = 1
  IF k$ = CHR$(0) + "M" THEN LET d(1) = 2
  IF k$ = CHR$(0) + "H" THEN LET d(1) = 3
  IF k$ = CHR$(0) + "P" THEN LET d(1) = 4
 END IF
 IF health(2) > 0 THEN
  IF k$ = "a" THEN LET d(2) = 1
  IF k$ = "d" THEN LET d(2) = 2
  IF k$ = "w" THEN LET d(2) = 3
  IF k$ = "s" THEN LET d(2) = 4
 END IF
 FOR p = 3 TO 6
  time = time + 1
  IF time > 100 THEN time = 61
  IF time > 10 * p THEN
  x = (px(p) + 10) / 30
  y = (py(p) + 10) / 30
  IF INT(x) = x AND INT(y) = y THEN
   d = d(p)
   IF space(x, y) = 0 THEN LET d = INT(RND * 4) + 1
   IF space(x, y) = 3 THEN d = d - 1
   IF space(x, y) = 5 THEN d = d
   IF space(x, y) = 6 OR space(x, y) = 9 THEN d = d + 2
   IF space(x, y) = 7 THEN d = 2
   IF space(x, y) = 11 THEN d = 4
   IF space(x, y) = 12 THEN d = d + 1
   IF space(x, y) = 13 THEN d = 1
   IF space(x, y) = 14 THEN d = 3
   IF space(x, y) = 1 THEN
    done = 1
    DO UNTIL done <> 1
     d = INT(RND * 4) + 1
     IF d <> 3 THEN done = 0
    LOOP
   END IF
  
   IF space(x, y) = 2 THEN
    done = 1
    DO UNTIL done <> 1
     d = INT(RND * 4) + 1
     IF d <> 1 THEN done = 0
    LOOP
   END IF
  
   IF space(x, y) = 4 THEN
    done = 1
    DO UNTIL done <> 1
     d = INT(RND * 4) + 1
     IF d <> 4 THEN done = 0
    LOOP
   END IF
  
   IF space(x, y) = 8 THEN
    done = 1
    DO UNTIL done <> 1
     d = INT(RND * 4) + 1
     IF d <> 2 THEN done = 0
    LOOP
   END IF
 
  IF d < 1 THEN d = d + 4
  IF d > 4 THEN d = d - 4
  d(p) = d
  END IF
  END IF
 NEXT p

 FOR p = 1 TO 6
  IF health(p) > 0 THEN
   IF INT((px(p) + 10) / 30) = ((px(p) + 10) / 30) AND INT((py(p) + 10) / 30) = ((py(p) + 10) / 30) THEN
    IF d(p) = 1 AND POINT(px(p) - 15, py(p)) <> bgc THEN LET a(p) = -s(p): LET b(p) = 0: LET dir$(p) = "a2"
    IF d(p) = 2 AND POINT(px(p) + 15, py(p)) <> bgc THEN LET a(p) = s(p): LET b(p) = 0: LET dir$(p) = "a0"
    IF d(p) = 3 AND POINT(px(p), py(p) - 15) <> bgc THEN LET b(p) = -s(p): LET a(p) = 0: LET dir$(p) = "a1"
    IF d(p) = 4 AND POINT(px(p), py(p) + 15) <> bgc THEN LET b(p) = s(p): LET a(p) = 0: LET dir$(p) = "a3"
    IF a(p) = -s(p) AND POINT(px(p) - 15, py(p)) = bgc THEN LET a(p) = 0: LET b(p) = 0
    IF a(p) = s(p) AND POINT(px(p) + 15, py(p)) = bgc THEN LET a(p) = 0: LET b(p) = 0
    IF b(p) = -s(p) AND POINT(px(p), py(p) - 15) = bgc THEN LET b(p) = 0: LET a(p) = 0
    IF b(p) = s(p) AND POINT(px(p), py(p) + 15) = bgc THEN LET b(p) = 0: LET a(p) = 0
   END IF

  LOCATE 2 + p, 70: PRINT SCORE(p)
  px(p) = px(p) + a(p): py(p) = py(p) + b(p)
  IF py(p) < 10 THEN LET py(p) = 450
  IF py(p) > 450 THEN LET py(p) = 10
  IF px(p) < 10 THEN LET px(p) = 510
  IF px(p) > 510 THEN LET px(p) = 10
  PSET (px(p), py(p)), 0: DRAW "c" + STR$(p) + dir$(p) + pac$(chew)
  PAINT (px(p), py(p)), p, p
  IF p > 2 THEN
  PSET (px(p), py(p)), 0: DRAW "c10" + dir$(p) + pac$(chew)
  PAINT (px(p), py(p)), 10, 10
  END IF
  END IF
  NEXT p
  
  FOR i = 1 TO 17
   FOR j = 1 TO 15
     x = (i * 30) - 10
     y = (j * 30) - 10
    IF tempdot(i, j) = 2 AND POINT(x + 5, y) = 0 AND POINT(x - 5, y) = 0 AND POINT(x, y + 5) = 0 AND POINT(x, y - 5) = 0 THEN
           PSET (x - 4, y - 4), 0: DRAW "c15" + "a0" + pellet$
     tempdot(i, j) = 1
     END IF
     FOR p = 1 TO 6
     IF tempdot(i, j) > 0 THEN
     IF p > 2 AND x = px(p) AND y = py(p) THEN
     tempdot(i, j) = 2
     END IF
     IF p < 3 AND px(p) = x AND py(p) = y THEN
      LET SCORE(p) = SCORE(p) + 1
      LET tempdot(i, j) = 0
      LET levelscore = levelscore - 1
      SOUND 300, .2
    END IF
    IF tempdot(i, j) = 0 THEN
    FOR hold = 1 TO 100
    NEXT hold
    END IF
    END IF
    NEXT p
    NEXT j
  NEXT i
trails$ = "n"
  FOR p = 1 TO plrs
  IF POINT(px(p), py(p)) > plrs THEN
  i = health(p)
  IF health(p) >= 0 THEN
  PSET (510 + 20 * i, 200 + 20 * p), 0: DRAW clr$
  PSET (510 + 20 * i, 200 + 20 * p), 0: DRAW "c0" + pac$(2)
  health(p) = health(p) - 1
  px(p) = 20
  py(p) = 440
  END IF
  END IF
  NEXT p
  FOR p = 1 TO 6
   IF health(p) > 0 THEN
    PSET (px(p), py(p)), 0: DRAW clr$
   END IF
  NEXT p
 chew = chew + 1
 IF chew > 4 THEN LET chew = 1
 IF levelscore = 0 THEN LET z = 1
 
IF health(1) < 1 AND health(2) < 1 THEN z = 1: game = 1
LOOP
LOOP
game = 0
DO UNTIL again$ = "y" OR again$ = "n"
 INPUT "Again"; again$
LOOP
LOOP

SUB editor (l$(), spot$, pellet$)
CLS
PRINT "Level Editor"
PRINT "1 - Create New"
PRINT "2 - Edit Existing"
q1$ = "0"
DO UNTIL q1$ = "1" OR q1$ = "2"
INPUT q1$
LOOP
OPEN "pacman.dat" FOR INPUT AS #1
INPUT #1, current
CLOSE #1
IF q1$ = "1" THEN
LET level = current + 1
OPEN "pacman.dat" FOR OUTPUT AS #1
WRITE #1, level
CLOSE #1
level$ = MID$(STR$(level), 2, LEN(STR$(level)) - 1) + ".map"
CLS
END IF

IF q1$ = "2" THEN
level = 0
DO UNTIL level > 0 AND level <= current
INPUT "level #"; level
LOOP
CLS
level$ = MID$(STR$(level), 2, LEN(STR$(level)) - 1) + ".map"
OPEN level$ FOR INPUT AS #1
FOR i = 1 TO 17
FOR j = 1 TO 15
INPUT #1, q, d
IF q >= 8 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(4): LET q = q - 8
IF q >= 4 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(3): LET q = q - 4
IF q >= 2 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(2): LET q = q - 2
IF q >= 1 THEN PSET ((i * 30) - 10, (j * 30) - 10), 0: DRAW "c4" + l$(1): LET q = q - 1
IF d = 1 THEN PSET ((i * 30) - 14, (j * 30) - 14), 0: DRAW "c15" + pellet$
NEXT j
NEXT i
CLOSE #1
END IF


IF q1$ = "1" THEN
 FOR x = 1 TO 17
  FOR y = 1 TO 15
   FOR i = 1 TO 4
    PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(i)
   NEXT i
  NEXT y
 NEXT x
END IF
x = 1: y = 1: c = -1
LOCATE 2, 70: PRINT "q - quit"
LOCATE 3, 70: PRINT "c - draw"
 DO UNTIL k$ = "q"
  k$ = INKEY$
  IF k$ = "c" THEN c = c * -1
  PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c2" + spot$ + pellet$

  FOR i = 1 TO 1000
  NEXT i
  PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + spot$ + "c" + STR$((INT(ABS(c) + c) / 2) * 15) + pellet$

  IF k$ = CHR$(0) + "H" THEN
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(1)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(1)
   LET y = y - 1
   IF y < 1 THEN LET y = 15
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(3)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(3)
  END IF

  IF k$ = CHR$(0) + "P" THEN
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(3)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(3)
   LET y = y + 1
   IF y > 15 THEN LET y = 1
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(1)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(1)
  END IF

  IF k$ = CHR$(0) + "K" THEN
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(2)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(2)
   LET x = x - 1
   IF x < 1 THEN LET x = 17
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(4)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(4)
  END IF
  IF k$ = "v" THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c2" + spot$ + "c1" + pellet$
  IF k$ = CHR$(0) + "M" THEN
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(4)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(4)
   LET x = x + 1
   IF x > 17 THEN LET x = 1
   IF c = -1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c4" + l$(2)
   IF c = 1 THEN PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c0" + l$(2)
  END IF
  LOOP
OPEN level$ FOR OUTPUT AS #1
 FOR i = 1 TO 17
  FOR j = 1 TO 15
   x = (i * 30) - 10
   y = (j * 30) - 10
   q = 0: d = 0
   IF POINT(x, y - 15) = 4 THEN LET q = q + 1
   IF POINT(x - 15, y) = 4 THEN LET q = q + 2
   IF POINT(x, y + 15) = 4 THEN LET q = q + 4
   IF POINT(x + 15, y) = 4 THEN LET q = q + 8
   IF POINT(x - 1, y - 1) = 15 THEN LET d = 1
   WRITE #1, q, d
  NEXT j
 NEXT i
 CLOSE #1
PRINT level$
SLEEP 3
END SUB

SUB help
END SUB

