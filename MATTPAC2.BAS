DECLARE SUB editor (l$(), spot$, pellet$)
SCREEN 12
RANDOMIZE TIMER
DIM pac$(4)
DIM a(10)
DIM b(10)
DIM d(10)
DIM s(10)
DIM px(10)
DIM py(10)
DIM dr$(10)
DIM health(2)
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
exitgame = 0
DO UNTIL exitgame = 1
z = 0
DO UNTIL z = 1
 CLS
 LOCATE 9, 33: PRINT "PacMen"
 LOCATE 10, 33: PRINT "by matt donahoe"
 LOCATE 15, 35: PRINT "1 Player"
 LOCATE 18, 35: PRINT "2 Players"
 LOCATE 21, 35: PRINT "Level Editor"
 LOCATE 24, 35: PRINT "Exit"
 LET m = 15
 k$ = ""
 PSET (268, (16 * m) - 8), 0: DRAW "a0c4" + pellet$
 FOR i = 1 TO 100000
 NEXT i
 DO UNTIL k$ = CHR$(13)
  LET k$ = INKEY$
  IF k$ = CHR$(0) + "P" THEN
   PSET (268, (16 * m) - 8), 0: DRAW "c0" + pac$(2)
   IF m < 24 THEN LET m = m + 3
   PSET (268, (16 * m) - 8), 0: DRAW "c14" + pac$(2)
  END IF
  IF k$ = CHR$(0) + "H" THEN
   PSET (268, (16 * m) - 8), 0: DRAW "c0" + pac$(2)
   IF m > 15 THEN LET m = m - 3
   PSET (268, (16 * m) - 8), 0: DRAW "c14" + pac$(2)
  END IF
 LOOP
 FOR x = 268 TO 640
  PSET (x, (16 * m) - 8), 0: DRAW "c14" + pac$(2)
  FOR i = 1 TO 100
  NEXT i
  PSET (x, (16 * m) - 8), 0: DRAW "c0" + pac$(2)
 NEXT x
 IF m = 15 THEN LET plrs = 1: LET z = 1
 IF m = 18 THEN LET plrs = 2: LET z = 1
 IF m = 21 THEN CALL editor(l$(), spot$, pellet$)
 IF m = 24 THEN LET z = 1: LET exitgame = 1
LOOP
DRAW "a0"
IF exitgame = 0 THEN
again$ = ""
DO UNTIL again$ = "n"
 again$ = ""
 z = 0
 FOR i = 1 TO plrs
  health(i) = 3
  score(i) = 0
 NEXT i

 DO UNTIL game = 1
  CLS
  levelscore = 0
  DRAW "a0"
  OPEN "pacman.dat" FOR INPUT AS #1
  INPUT #1, current, highscore
  CLOSE #1
  level = INT(RND * current) + 1
  level$ = MID$(STR$(level), 2, LEN(STR$(level)) - 1) + ".map"
  OPEN level$ FOR INPUT AS #1
  INPUT #1, ghosts
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
  time = 0
  team = plrs
  px(ghosts + 1) = 20
  py(ghosts + 1) = 20
  px(ghosts + 2) = 500
  py(ghosts + 2) = 20
  chew = 1
  s(ghosts + 1) = 10
  s(ghosts + 2) = 10
  FOR g = 1 TO ghosts
   d(g) = g
   s(g) = 5
   px(g) = 260
   py(g) = 230
  NEXT g
  z = 0
  time = 0
  LOCATE 25, 69: PRINT "HIGHSCORE:"
  LOCATE 26, 70: PRINT highscore
  LOCATE 1, 70: PRINT "LEVEL #"; level
  LOCATE 2, 70: PRINT "SCORES:"
  LOCATE 6, 70: PRINT "LIVES:"
  FOR p = 1 TO plrs
   IF health(p) > 0 THEN
    LOCATE 2, 3: PRINT p
    FOR i = 1 TO health(p)
     PSET (520 + 20 * i, 200 + 20 * p), 0: DRAW "c" + STR$(p) + pac$(2)
     PAINT (519 + 20 * i, 200 + 20 * p), p, p
    NEXT i
   END IF
  NEXT p
  DO UNTIL z = 1
   LET k$ = INKEY$
   IF health(1) > 0 THEN
    IF k$ = CHR$(0) + "K" THEN LET d(ghosts + 1) = 1
    IF k$ = CHR$(0) + "M" THEN LET d(ghosts + 1) = 2
    IF k$ = CHR$(0) + "H" THEN LET d(ghosts + 1) = 3
    IF k$ = CHR$(0) + "P" THEN LET d(ghosts + 1) = 4
   END IF
   IF health(2) > 0 THEN
    IF k$ = "a" THEN LET d(ghosts + 2) = 1
    IF k$ = "d" THEN LET d(ghosts + 2) = 2
    IF k$ = "w" THEN LET d(ghosts + 2) = 3
    IF k$ = "s" THEN LET d(ghosts + 2) = 4
   END IF
   FOR p = 1 TO ghosts
    IF time < 100 THEN time = time + 1
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

   FOR p = ghosts + 1 TO ghosts + plrs

    IF health(p - ghosts) > 0 THEN
     x = px(p)
     y = py(p)

     IF INT((x + 10) / 30) = ((x + 10) / 30) AND INT((y + 10) / 30) = ((y + 10) / 30) THEN
      IF d(p) = 1 AND POINT(x - 15, y) <> bgc THEN LET a(p) = -s(p): LET b(p) = 0: LET dr$(p) = "a2"
      IF d(p) = 2 AND POINT(x + 15, y) <> bgc THEN LET a(p) = s(p): LET b(p) = 0: LET dr$(p) = "a0"
      IF d(p) = 3 AND POINT(x, y - 15) <> bgc THEN LET b(p) = -s(p): LET a(p) = 0: LET dr$(p) = "a1"
      IF d(p) = 4 AND POINT(x, y + 15) <> bgc THEN LET b(p) = s(p): LET a(p) = 0: LET dr$(p) = "a3"
      IF a(p) = -s(p) AND POINT(x - 15, y) = bgc THEN LET a(p) = 0: LET b(p) = 0
      IF a(p) = s(p) AND POINT(x + 15, y) = bgc THEN LET a(p) = 0: LET b(p) = 0
      IF b(p) = -s(p) AND POINT(x, y - 15) = bgc THEN LET b(p) = 0: LET a(p) = 0
      IF b(p) = s(p) AND POINT(x, y + 15) = bgc THEN LET b(p) = 0: LET a(p) = 0
     END IF

     x = x + a(p): y = y + b(p)
     IF y < 10 THEN LET y = 450
     IF y > 450 THEN LET y = 10
     IF x < 10 THEN LET x = 510
     IF x > 510 THEN LET x = 10
     PSET (x, y), 0: DRAW "c" + STR$(p - ghosts) + dr$(p) + pac$(chew)
     PAINT (x, y), p - ghosts, p - ghosts
    px(p) = x
    py(p) = y
    END IF
   NEXT p
   FOR p = 1 TO ghosts
    IF d(p) = 1 THEN LET a(p) = -s(p): LET b(p) = 0: LET dr$(p) = "a2"
    IF d(p) = 2 THEN LET a(p) = s(p): LET b(p) = 0: LET dr$(p) = "a0"
    IF d(p) = 3 THEN LET b(p) = -s(p): LET a(p) = 0: LET dr$(p) = "a1"
    IF d(p) = 4 THEN LET b(p) = s(p): LET a(p) = 0: LET dr$(p) = "a3"
    px(p) = px(p) + a(p): py(p) = py(p) + b(p)
    IF py(p) < 10 THEN LET py(p) = 450
    IF py(p) > 450 THEN LET py(p) = 10
    IF px(p) < 10 THEN LET px(p) = 510
    IF px(p) > 510 THEN LET px(p) = 10
    PSET (px(p), py(p)), 0: DRAW "c7" + dr$(p) + pac$(chew)
    PAINT (px(p), py(p)), 7, 7
   NEXT p
   FOR i = 1 TO 17
    FOR j = 1 TO 15
     d = tempdot(i, j)
     x = (i * 30) - 10
     y = (j * 30) - 10
     IF d > 2 AND POINT(x + 4, y) = 0 AND POINT(x - 4, y) = 0 AND POINT(x, y + 4) = 0 AND POINT(x, y - 4) = 0 THEN
      PSET (x - 4, y - 4), 0: DRAW "c15" + "a0" + pellet$
      d = d - 2
     END IF
     FOR p = 1 TO ghosts + plrs
      IF d > 0 AND d < 3 THEN
       IF p <= ghosts AND x = px(p) AND y = py(p) THEN
	d = d + 2
       END IF
       IF p > ghosts AND px(p) = x AND py(p) = y THEN
	LET score(p - ghosts) = score(p - ghosts) + d * d * 10
	IF score(p - ghosts) > highscore THEN LET highscore = score(p - ghosts)
	LOCATE 26, 70: PRINT highscore
	LOCATE 2 + (p - ghosts), 70: PRINT score(p - ghosts)
	LET d = 0
	LET levelscore = levelscore - 1
	SOUND 300, .2
       END IF
       END IF
      NEXT p
     tempdot(i, j) = d
    NEXT j
   NEXT i
   'FOR hold = 1 TO ((15 - ghosts) * 20000)
   'NEXT hold
   FOR p = ghosts + 1 TO ghosts + plrs
    h = health(p - ghosts)
    IF h >= 0 THEN
     IF POINT(px(p), py(p)) > team THEN
      PSET (520 + 20 * h, 200 + 20 * (p - ghosts)), 0: DRAW clr$
      PSET (519 + 20 * h, 200 + 20 * (p - ghosts)), 0: DRAW "c0" + pac$(2)
      h = h - 1
      px(p) = 20
      py(p) = 440
     END IF
     PSET (px(p), py(p)), 0: DRAW clr$
     health(p - ghosts) = h
    END IF
   NEXT p
   FOR p = 1 TO ghosts
    PSET (px(p), py(p)), 0: DRAW clr$
   NEXT p
   chew = chew + 1
   IF chew > 4 THEN LET chew = 1
   IF levelscore = 0 THEN LET z = 1
   IF health(1) < 1 AND health(2) < 1 THEN z = 1: game = 1
  LOOP
 LOOP
 game = 0
 OPEN "pacman.dat" FOR OUTPUT AS #1
 WRITE #1, current, highscore
 CLOSE #1
 DO UNTIL again$ = "y" OR again$ = "n"
  INPUT "Again"; again$
 LOOP
LOOP
END IF
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
INPUT #1, ghosts
PRINT ghosts; "Ghosts"
DO UNTIL ghost > 0 AND ghost < 9
INPUT "New #"; ghost
LOOP
ghosts = ghost
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
 DO UNTIL ghosts > 0 AND ghosts < 9
  INPUT ghosts
 LOOP
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
WRITE #1, ghosts
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
END SUB

SUB help
END SUB

