SCREEN 12
DIM cx1(300)
DIM cy1(300)
DIM cx2(300)
DIM cy2(300)
DIM obx(30)
DIM oby(30)
RANDOMIZE TIMER
DO UNTIL again$ = "n"
LET again$ = ""
PLAY "L16"
CLS
DO UNTIL INKEY$ = CHR$(13)
LOCATE (12), (35): COLOR 7: PRINT "Double Snake"
LOOP
FOR i = 1 TO 300
 LET cx1(i) = 2: LET cy1(i) = 2
 LET cx2(i) = 79: LET cy2(i) = 25
NEXT i
LET dlevel = 0
DO UNTIL dlevel > 0 AND dlevel < 11 AND dlevel = INT(dlevel)
 INPUT "difficulty level 1-10"; dlevel
LOOP
LET speed = 0
DO UNTIL speed > 0 AND speed < 11 AND speed = INT(speed)
 INPUT "speed level (1-10)"; speed
LOOP
FOR i = 1 TO 3 * dlevel
  LET radx = INT((RND * 78) + 1) + 1
  LET rady = INT((RND * 24) + 1) + 1
  LET rad = 0
  IF radx = 2 AND rady = 2 OR radx = 79 AND rady = 25 OR radx = 40 AND rady = 15 THEN LET rad = 1
  IF rad = 0 THEN LET obx(i) = radx: LET oby(i) = rady
NEXT i

CLS
LINE (7, 10)-(632, 10)
LINE (7, 400)-(632, 400)
LINE (7, 10)-(7, 400)
LINE (632, 10)-(632, 400)
LOCATE (27), (1): PRINT "Player 1="
LOCATE (27), (60): PRINT "Player 2="
LET a = 0
LET b = 0
LET c = 0
LET d = 0
LET e = 0
LET z = 0
LET s1 = 0
LET s2 = 0
LET x1 = 2: LET y1 = 2
LET x2 = 79: LET y2 = 25
LET p1 = 59: LET p2 = 59
LET pl1 = 0: LET pl2 = 0
LET xp = 40
LET yp = 15
DO UNTIL z = 1
 LOCATE (27), (10): COLOR 1: PRINT s1
 LOCATE (27), (70): COLOR 14: PRINT s2
 IF pl1 = 1 THEN LOCATE (28), (1): COLOR 1: PRINT "DEAD"
 IF pl2 = 1 THEN LOCATE (28), (60): COLOR 14: PRINT "DEAD"
 LET c = c + 1: IF c > 1000 THEN LET c = 51

 LET k$ = INKEY$

 IF pl1 <> 1 THEN
  IF k$ = "a" AND a <> 1 THEN LET a = -1: LET b = 0
  IF k$ = "s" AND a <> -1 THEN LET a = 1: LET b = 0
  IF k$ = "w" AND b <> 1 THEN LET b = -1: LET a = 0
  IF k$ = "z" AND b <> -1 THEN LET b = 1: LET a = 0
 END IF

 IF pl2 <> 1 THEN
  IF k$ = "l" AND d <> 1 THEN LET d = -1: LET e = 0
  IF k$ = ";" AND d <> -1 THEN LET d = 1: LET e = 0
  IF k$ = "p" AND e <> 1 THEN LET e = -1: LET d = 0
  IF k$ = "." AND e <> -1 THEN LET e = 1: LET d = 0
 END IF
 IF pl1 = 1 AND pl2 = 1 THEN LET z = 1

 IF x1 = 80 OR x1 = 1 OR y1 = 1 OR y1 = 26 THEN LET pl1 = 1
 IF x2 = 80 OR x2 = 1 OR y2 = 1 OR y2 = 26 THEN LET pl2 = 1

 LOCATE (yp), (xp): COLOR 2: PRINT "$"
 FOR i = 1 TO 3 * dlevel
  LOCATE (oby(i)), (obx(i)): COLOR 7: PRINT "X"
 NEXT i
 IF c / 10 = INT(c / 10) THEN
  IF pl1 = 0 THEN LET x1 = x1 + a: LET y1 = y1 + b
  IF pl2 = 0 THEN LET x2 = x2 + d: LET y2 = y2 + e
  IF p1 <> 59 THEN
   FOR i = p1 * 5 TO 299
    IF y1 = cy1(i) AND x1 = cx1(i) THEN LET pl1 = 1
   NEXT i
   FOR i = 1 TO 30
    IF y1 = oby(i) AND x1 = obx(i) THEN LET pl1 = 1
   NEXT i
  END IF
  IF p2 <> 59 THEN
   FOR i = p2 * 5 TO 299
    IF y2 = cy2(i) AND x2 = cx2(i) THEN LET pl2 = 1
   NEXT i
   FOR i = 1 TO 3 * dlevel
    IF y2 = oby(i) AND x2 = obx(i) THEN LET pl2 = 1
   NEXT i
  END IF
  IF pl1 = 0 THEN
   LET cx1(300) = x1: LET cy1(300) = y1
   FOR i = p1 * 5 TO 300
    SWAP cx1(i), cx1(300): SWAP cy1(i), cy1(300)
   NEXT i
  END IF
  IF pl2 = 0 THEN
   LET cx2(300) = x2: LET cy2(300) = y2
   FOR i = p2 * 5 TO 300
    SWAP cx2(i), cx2(300): SWAP cy2(i), cy2(300)
   NEXT i
  END IF
 END IF

 IF pl1 = 0 THEN LOCATE (y1), (x1): COLOR 1: PRINT "@"
 IF pl2 = 0 THEN LOCATE (y2), (x2): COLOR 14: PRINT "*"

 IF y1 = yp AND x1 = xp THEN
  LET s1 = s1 + (dlevel * speed)
  LET p1 = p1 - 1
  IF p1 = 0 THEN
   LOCATE (12), (40): COLOR 1: PRINT "Player 1 WINS!"
   PLAY "abcdecdecde"
   LET z = 1
  END IF
  PLAY "A"
  LET radx = INT((RND * 78) + 1) + 1
  LET rady = INT((RND * 24) + 1) + 1
  LET rad = 0
  FOR i = p1 * 5 TO 300
    IF radx = cx1(i) AND rady = cy1(i) THEN LET rad = 1
  NEXT i
  IF rad = 0 THEN
   FOR i = p2 * 5 TO 300
    IF radx = cx2(i) AND rady = cy2(i) THEN LET rad = 1
   NEXT i
  END IF
  IF rad = 0 THEN
   FOR i = 1 TO 3 * dlevel
    IF radx = obx(i) AND rady = oby(i) THEN LET rad = 1
   NEXT i
  END IF
  IF rad = 0 THEN LET xp = radx: LET yp = rady
 END IF
 IF y2 = yp AND x2 = xp THEN
  LET s2 = s2 + (dlevel * speed)
  LET p2 = p2 - 1
  IF p2 = 0 THEN
   LOCATE (12), (40): COLOR 14: PRINT "Player 2 WINS!"
   PLAY "abcdecdecde"
   LET z = 1
  END IF

  PLAY "B"
  LET radx = INT((RND * 78) + 1) + 1
  LET rady = INT((RND * 24) + 1) + 1
  LET rad = 0
  FOR i = p1 * 5 TO 300
    IF radx = cx1(i) AND rady = cy1(i) THEN LET rad = 1
  NEXT i
  IF rad = 0 THEN
   FOR i = p2 * 5 TO 300
    IF radx = cx2(i) AND rady = cy2(i) THEN LET rad = 1
   NEXT i
  END IF
  IF rad = 0 THEN
   FOR i = 1 TO 3 * dlevel
    IF radx = obx(i) AND rady = oby(i) THEN LET rad = 1
   NEXT i
  END IF
  IF rad = 0 THEN LET xp = radx: LET yp = rady
 END IF
 IF c > 50 THEN
  IF a <> 0 OR b <> 0 THEN
   LOCATE (cy1(300)), (cx1(300)): PRINT " "
  END IF
  IF d <> 0 OR e <> 0 THEN
   LOCATE (cy2(300)), (cx2(300)): PRINT " "
  END IF
 END IF
 IF pl1 = 0 THEN
  FOR i = p2 * 5 TO 299
   IF x1 = cx2(i) AND y1 = cy2(i) THEN LET pl1 = 1
  NEXT i
 END IF
 IF pl2 = 0 THEN
  FOR i = p1 * 5 TO 299
   IF x2 = cx1(i) AND y2 = cy1(i) THEN LET pl2 = 1
  NEXT i
 END IF
 FOR i = 1 TO 1 + (-1000 *(speed-10)*(speed - 10)*(speed-10))
 NEXT i
LOOP
PLAY "G"
PLAY "L8"
PLAY "F"
PLAY "L4"
PLAY "E"
PLAY "L2"
PLAY "D"

DO UNTIL INKEY$ = CHR$(13)
FOR q = 1 TO 10
LOCATE (28), (35): COLOR q: PRINT "GAME OVER"
FOR j = 1 TO 1000
NEXT j
NEXT q
LOOP
CLS
LOCATE (12), (35): PRINT "Play Again (y/n)?"
DO UNTIL again$ = "y" OR again$ = "n"
INPUT again$
LOOP
LOOP
END

