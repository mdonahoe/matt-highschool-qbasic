CLS
SCREEN 12
pi = 3.1415926535897#
bullet$ = "bl6u2r4f2g2l4u2"
tank$ = "ta0bu4l3d2r8f3g3l10h3e3r8u2l3bd4"
turret$ = "r10ul10d"
bit$ = "u2l2r2d2"
RANDOMIZE TIMER
maxp = 14
DIM bid(maxp)
DIM turn(maxp)
DIM tx(maxp)
DIM ty(maxp)
DIM power(maxp)
DIM angle(maxp)
DIM health(maxp)
DIM tang$(maxp)
DIM title$(maxp)
DIM score(maxp)
DIM g(maxp)
DIM powmax(maxp)
DIM weapons(maxp, maxp)
DIM weapon$(maxp)
DIM x(maxp)
DIM y(maxp)
DIM grav(maxp)
DIM c$(maxp)
DIM high(10)
DIM high$(10)
tanktitle1$ = "r30d10l10d20l10u20l10u10br34  r30d30l10u20l10d20l10u30br34  r10f10u10r10d30l10u10h10d20l10u30br34  r10d10e10r10g15f15l10h10d10l10u30"
tanktitle2$ = "bm-102,34r10m+5,15e10f10m+5,-15r10m-10,30l5h10g10l5m-10,-30br54  r10m+10,30l7m-5,-20l6m-5,20l7m+10,-30br14  r24f6d6g6l5f12l10h7d7l4m-10,-30br40  r24d6l20d6r15f6d6g6l25h6r31u6l20h6u6e6"
DATA Normal--imp,Missile-imp,Digger--non,Dirtier-imp,TheWall-non,Bomber--imp,TripleX-imp,Bomber--non,EMP-----non,Nuke----imp,Shield-----,Antimissle, Elevator--,Armor-----
FOR i = 1 TO 14
 READ weapon$(i)
NEXT i
print "press enter"
do until k$=chr$(13)
k$=inkey$
loop
print "Loading"
for i=1 to 100
print ".";
next i
print ""
DO UNTIL quit$ = "okay"
 z = 0
 DO UNTIL z = 1
  CLS
  for i=1 to 8
  PSET (300-(i*15), 244-(30*i)), 0: DRAW "s"+str$(i)+"c4" + tanktitle1$+tanktitle2$
  for j=1 to 1000000
  next j
  pset (300-(i*15),244-(30*i)),0:draw "c0"+tanktitle1$+tanktitle2$
  next i
  pset (180,4),0:draw "c4"+tanktitle1$+tanktitle2$
  PSET (100, 400), 0: DRAW "s32c2ta45" + turret$ + tank$
  PSET (540, 400), 0: DRAW "c1ta135" + turret$ + tank$
  DRAW "s6"
  LOCATE 10, 33: PRINT "by matt donahoe"
  LOCATE 15, 35: PRINT "Play Game"
  LOCATE 18, 35: PRINT "High Scores"
  LOCATE 21, 35: PRINT "Help"
  LOCATE 24, 35: PRINT "Exit"
  LET m = 15
  k$ = ""
  PSET (268, (16 * m) - 8), 0: DRAW "c4" + bullet$
  FOR i = 1 TO 100000
  NEXT i
  DO UNTIL k$ = CHR$(13)
   LET k$ = INKEY$
   IF k$ = CHR$(0) + "P" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + bullet$
    IF m < 24 THEN LET m = m + 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + bullet$
   END IF
   IF k$ = CHR$(0) + "H" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + bullet$
    IF m > 15 THEN LET m = m - 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + bullet$
   END IF
  LOOP
  FOR x = 268 TO 640
  PSET (x, (16 * m) - 8), 0: DRAW "c4" + bullet$
  FOR i = 1 TO 10000
  NEXT i
  PSET (x, (16 * m) - 8), 0: DRAW "c0" + bullet$
  NEXT x
  IF m = 15 THEN z = 1
  IF m = 18 THEN CALL highscore(high(), high$())
  IF m = 21 THEN CALL help
  IF m = 24 THEN END
 LOOP
 DRAW "s4"
 CLS
 plrs = 0
 DO UNTIL plrs > 1 AND plrs < (maxp + 1)
  INPUT "How many players?   (2-13) ", plrs
 LOOP
 snd$ = ""
 DO UNTIL snd$ = "y" OR snd$ = "n"
  INPUT "Sound?         (y/n) ", snd$
 LOOP
 bouncy$ = ""
 DO UNTIL bouncy$ = "y" OR bouncy$ = "n"
  INPUT "Bouncy walls?  (y/n) ", bouncy$
 LOOP
 clr$ = "c0"
 PRINT "Names:"
 FOR p = 1 TO plrs
  title$(p) = ""
  DO UNTIL LEN(title$(p)) > 0 AND LEN(title$(p)) < 10
   PRINT "Player"; p;
   INPUT title$(p)
  LOOP
  score(p) = 0
  c$(p) = "c" + STR$(p)
 NEXT p
 points = -1
 DO UNTIL points >= 0 AND points < 1000
  INPUT "starting points?    (0-999) ", points
 LOOP
 FOR p = 1 TO plrs
  score(p) = points
 NEXT p
 game$ = ""
 DO UNTIL game$ = "n"
 game$ = ""
 CALL weaponselect(turn(), bid(), plrs, title$(), weapons(), weapon$(), score())
 CLS
 CALL terrain
 FOR p = 1 TO plrs
  LET shots = 0
  tx(p) = (640 / (plrs + 1)) * p
  ty(p) = 0
  power(p) = 0
  angle(p) = 0
  health(p) = 20
  powmax(p) = 590
 NEXT p
 winner = 0
 LET turn = 2
 six = 6
 g = 639
 DO WHILE winner = 0
  LINE (50, 455)-(590, 475), 15, BF
  LET turn = turn - 1
  IF turn < 1 THEN LET turn = plrs
  LET p = turn(turn)
  LET weapons(p, 1) = 9: LET weapons(p, 10) = 9
  IF health(p) > 0 AND POINT(tx(p) - 1, ty(p) + 5) <> 0 AND POINT(tx(p) + 1, ty(p) + 5) <> 0 THEN
   LET shots = shots + 1
   LET shot = 0
   LET time = 50
   Shield = 0
   anti = 0
   LOCATE 27, 1: PRINT "Press t to continue, press q to quit"
   DO UNTIL k$ = "t"
    LET k$ = INKEY$
    IF k$ = "q" THEN winner = 1: k$ = "t"
   LOOP
 IF winner = 0 THEN
   LET f = 1
   DO UNTIL shot = 1
    LET time = time - .01
    IF time <= 0 THEN
     LET angle(p) = INT(RND * 180)
     LET power(p) = INT(RND * 500)
     LET time = 0
     LET f = 1
    END IF
    PSET (tx(p), ty(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
    k$ = ""
    IF time > 0 THEN
     IF POINT(tx(p) - 1, ty(p) + 5) <> 0 AND POINT(tx(p) + 1, ty(p) + 5) <> 0 THEN
      LET k$ = INKEY$
      IF k$ = CHR$(0) + "P" THEN LET angle(p) = angle(p) - 3: IF snd$ = "y" THEN SOUND 37, .1
      IF k$ = CHR$(0) + "H" THEN LET angle(p) = angle(p) + 3: IF snd$ = "y" THEN SOUND 37, .1
      IF k$ = CHR$(0) + "K" THEN LET tx(p) = tx(p) - 1: IF snd$ = "y" THEN SOUND 400, .1
      IF k$ = CHR$(0) + "M" THEN LET tx(p) = tx(p) + 1: IF snd$ = "y" THEN SOUND 400, .1
      IF k$ = "1" THEN LET f = 1
      IF k$ = "2" AND weapons(p, 2) > 0 THEN LET f = 2
      IF k$ = "3" AND weapons(p, 3) > 0 THEN LET f = 3
      IF k$ = "4" AND weapons(p, 4) > 0 THEN LET f = 4
      IF k$ = "5" AND weapons(p, 5) > 0 THEN LET f = 5
      IF k$ = "6" AND weapons(p, 6) > 0 THEN LET f = 6
      IF k$ = "7" AND weapons(p, 7) > 0 THEN LET f = 7
      IF k$ = "8" AND weapons(p, 8) > 0 THEN LET f = 8
      IF k$ = "9" AND weapons(p, 9) > 0 THEN LET f = 9
      IF k$ = "0" THEN LET f = 10
      IF k$ = "s" AND weapons(p, 11) > 0 THEN LET f = 11
      IF k$ = "a" AND weapons(p, 12) > 0 THEN LET f = 12
      IF k$ = "d" AND weapons(p, 13) > 0 THEN LET f = 13
      IF k$ = "f" AND weapons(p, 14) > 0 THEN LET f = 14
     END IF
     g(p) = 1
     DO UNTIL g(p) = 0
     PSET (tx(p), ty(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
     CALL ground(tx(), ty(), p, g())
     if g(p)=1 then PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
     FOR i = 1 TO 1000
     NEXT i
     LOOP
    END IF
    IF angle(p) >= 177 THEN LET angle(p) = 176
    IF angle(p) < 4 THEN LET angle(p) = 4
    LET tang$(p) = "ta" + STR$(angle(p))
    IF ty(p) > 400 THEN LET health(p) = 0: LET shot = 1
    LOCATE 27, 1: PRINT title$(p); ": "; "TIME"; INT(time), "angle"; angle(p), "health"; health(p), weapon$(f); weapons(p, f): LOCATE 28, 1: PRINT "press p to pass", "Nuclear Attack 1 in"; six
    PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
    FOR hold = 1 TO 100000
    NEXT hold
    IF time <= 0 OR k$ = CHR$(13) THEN shot = 1: weapons(p, f) = weapons(p, f) - 1
    IF k$ = "p" THEN shot = 1: f = 15
   LOOP
   LET health(p) = health(p) - 1
   IF f > 10 AND f < 14 THEN CALL defense(f, tx(), ty(), p, clr$, c$(), tang$(), tank$, turret$)
   IF f = 14 THEN LET health(p) = health(p) + 10
   'fire
   IF f < 11 THEN
    bnum = 0
    drops = 0
    bomb$ = "r3u3l3d3"
    pow = 49
    c = 1
    k$ = ""
    DO UNTIL k$ = CHR$(13) OR pow = 50 AND c = -1
     k$ = INKEY$
     LET pow = pow + c
     IF pow = powmax(p) THEN LET c = -1
     LINE (pow, 455)-(pow, 475), (2 * (1 + c)) + (7.5 * (1 - c))
     FOR i = 1 TO 10000
     NEXT i
    LOOP
    LET c = 1
    LET d = 0
    LET ang = angle(p)
    IF angle(p) = 90 THEN LET ang = 89
    IF angle(p) > 90 THEN LET ang = 180 - angle(p): LET c = -1: LET d = 180
    LET ang = (ang * pi) / 180
    LET pow = INT(pow * .7)
    LET h1 = COS(ang) * pow
    LET h = tx(p) + (h1 * c)
    LET k1 = SIN(ang) * pow
    LET s = h1 / k1
    IF s > 2 THEN LET s = 2
    LET k = ty(p) - k1
    LET a = (h1 * h1) / k1
    oldx = tx(p): oldy = ty(p)
    z = 0
    xa = tx(p)
    x = 1
    time = 0
    bounce = 0
    DO UNTIL z = 1
     k$ = INKEY$
     time = time + 1
     xa = xa + (s * c)
     IF bouncy$ = "y" AND xa > 639 THEN LET bounce = xa - 640: d = 180
     IF bouncy$ = "y" AND xa < 1 THEN LET bounce = xa: d = 0
     y = (1 / a) * ((xa - h) * (xa - h)) + k
     x = xa - (2 * bounce)
     IF bouncy$ = "y" THEN
      DO UNTIL x > 0 AND x < 640
       IF x > 640 THEN LET x = x - (2 * (x - 640)): d = 180
       IF x < 0 THEN LET x = x - (2 * x): d = 0
      LOOP
      IF y > 400 THEN LET z = 1
     END IF
     IF bouncy$ = "n" AND x > 640 OR bouncy$ = "n" AND x < 0 OR y > 400 THEN LET z = 1
     FOR j = 1 TO 14
       IF j <> p THEN
	IF POINT(x, y) = j THEN
	IF f = 1 THEN z = 1
	IF f = 2 THEN z = 1
	IF f = 4 THEN z = 1
	IF f = 6 THEN z = 1
	IF f = 7 AND expls = 2 THEN z = 1: expls = 0
	IF f = 7 AND expls < 2 THEN expls = expls + 1: CALL explosion(snd$, six, f, x, y)
	IF f = 10 THEN z = 1
       END IF
      END IF
     NEXT j
     IF k$ = CHR$(13) THEN
     IF f = 3 THEN LET z = 1
     IF f = 9 THEN LET z = 1
     IF f = 5 THEN LET z = 1

     IF f = 6 AND drops < 3 OR f = 8 AND drops < 3 THEN
      drops = drops + 1
      LOCATE 1, 1: PRINT drops
      x(drops) = x + (7 * ((d / 90) - 1))
      y(drops) = y + 3
      grav(drops) = 2
     END IF
     END IF
     LET ta = ATN((oldy - y) / (oldx - x))
     LET ta = (INT((ta / pi) * 180)) * -1 + d
     LET sang$ = "ta" + STR$(ta)
     IF y < 400 AND y > 0 THEN
      PSET (x, y), 0: DRAW c$(p) + sang$ + bullet$
      IF f = 6 OR f = 8 THEN
       FOR i = 1 TO drops
	IF grav(i) = 2 THEN
	 y(i) = y(i) + grav(i)
	 PSET (x(i), y(i)), 0: DRAW c$(p) + "ta0" + bomb$
	END IF
       NEXT i
       FOR i = 1 TO drops
	IF POINT(x(i), y(i) + 1) <> 0 AND POINT(x(i), y(i) + 1) <> p AND POINT(x(i), y(i) + 1) <> 15 AND y(i) > 1 THEN
	 grav(i) = 0
	 SWAP x, x(i)
	 SWAP y, y(i)
	 CALL explosion(snd$, six, f, x, y)
	 SWAP x, x(i)
	 SWAP y, y(i)
	END IF
       NEXT i
      END IF
      IF snd$ = "y" THEN SOUND 2500 - y * 5, .2
      FOR hold = 1 TO 100000
      NEXT hold
      IF f = 6 OR f = 8 THEN
       FOR i = 1 TO drops
	IF grav(i) = 2 THEN PSET (x(i), y(i)), 0: DRAW clr$ + "ta0" + bomb$
	IF grav(i) = 0 THEN PSET (x(i), y(i)), 0: DRAW clr$ + "ta0" + bomb$: LET grav(i) = -1
       NEXT i
      END IF
      IF bounce = 0 AND POINT(x + (c * 2), y) <> p OR bounce <> 0 THEN PSET (x, y), 0: DRAW clr$ + sang$ + bullet$
      LET oldx = x: LET oldy = y
     END IF
     PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
    LOOP
    IF y < 400 AND x > 0 AND x < 640 THEN
     clr = 0
     LET t = p
    CALL explosion(snd$, six, f, x, y)
    END IF
   END IF
   LOCATE 27, 1: PRINT "                                                                               "
   LOCATE 28, 1: PRINT "                                                                               "
   LOCATE 27, 1: PRINT "WAIT!"
   CALL gfix
  END IF
  END IF
  FOR p = 1 TO plrs
   IF health(p) > 0 AND ty(p) > 0 THEN
    IF POINT(tx(p), ty(p)) = 0 THEN LET health(p) = health(p) - 10: IF t <> p THEN score(t) = score(t) + 10
    IF POINT(tx(p) + 7, ty(p)) = 0 THEN LET health(p) = health(p) - 5: IF t <> p THEN score(t) = score(t) + 5
    IF POINT(tx(p) - 7, ty(p)) = 0 THEN LET health(p) = health(p) - 5: IF t <> p THEN score(t) = score(t) + 5
    IF POINT(tx(p), ty(p)) = 15 THEN LET powmax(p) = powmax(p) - 100: IF t <> p THEN score(t) = score(t) + 4
    IF POINT(tx(p) + 7, ty(p)) = 15 THEN LET powmax(p) = powmax(p) - 50: IF t <> p THEN score(t) = score(t) + 2
    IF POINT(tx(p) - 7, ty(p)) = 15 THEN LET powmax(p) = powmax(p) - 50: IF t <> p THEN score(t) = score(t) + 2
    PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
   END IF
   IF health(p) <= 0 THEN PSET (tx(p), ty(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
  NEXT p
  FOR p = 1 TO plrs
   IF health(p) > 0 AND POINT(tx(p) + 1, ty(p) + 5) = 0 OR health(p) > 0 AND POINT(tx(p) - 1, ty(p) + 5) = 0 THEN LET g(p) = 1
  NEXT p
  DO UNTIL k$ = "q" OR g(1) = 0 AND g(2) = 0 AND g(3) = 0 AND g(4) = 0 AND g(5) = 0 AND g(6) = 0 AND g(7) = 0 AND g(8) = 0 AND g(9) = 0 AND g(10) = 0 AND g(11) = 0 AND g(12) = 0 AND g(13) = 0
   k$ = INKEY$
   FOR p = 1 TO plrs
    k$ = INKEY$
    IF health(p) > 0 AND g(p) = 1 THEN
     PSET (tx(p), ty(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
     CALL ground(tx(), ty(), p, g())
     IF shots > 0 AND ty(p) > 400 THEN LET health(p) = 0: IF t <> p THEN score(t) = score(t) + 20
     PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
    END IF
    IF health(p) <= 0 OR POINT(tx(p) - 1, ty(p) + 5) <> 0 AND POINT(tx(p) + 1, ty(p) + 5) <> 0 THEN LET g(p) = 0
   NEXT p
  LOOP
  win = 0
  FOR p = 1 TO plrs
   IF health(p) > 0 THEN LET win = win + p:score(p)=score(p)+1
  NEXT p
  IF win = 0 THEN
   CLS
   PRINT "No one wins!"
   LET winner = 1
  END IF

  FOR p = 1 TO plrs
   IF health(p) > 0 THEN
    IF win = p THEN
     score(p) = score(p) + (10 * plrs)
     CLS
     PRINT "Player "; p; " wins!"
     LET winner = 1
    END IF
   END IF
  NEXT p
 LOOP
 k$ = ""
 DO UNTIL k$ = CHR$(13)
 k$ = INKEY$
 LOOP
  CLS
  PRINT "score so far:"
  FOR p = 1 TO plrs
   PRINT title$(p); "="; score(p)
  NEXT p
   PRINT "Next Round?   (y/n)"
   DO UNTIL game$ = "n" OR game$ = "y"
   INPUT game$
   LOOP
   IF game$ = "n" THEN
   OPEN "tankwars.dat" FOR INPUT AS #1
   FOR i = 1 TO 10
    INPUT #1, high(i)
    INPUT #1, high$(i)
   NEXT i
   CLOSE #1
   FOR p = 1 TO plrs
   IF score(p) > high(10) THEN LET high(10) = score(p): LET high$(10) = title$(p)
   FOR j = 10 TO 2 STEP -1
     IF high(j) > high(j - 1) THEN SWAP high(j), high(j - 1): SWAP high$(j), high$(j - 1)
   NEXT j
   NEXT p
   OPEN "tankwars.dat" FOR OUTPUT AS #1
   FOR i = 1 TO 10
    WRITE #1, high(i), high$(i)
   NEXT i
   CLOSE #1
  END IF
  LOOP
LOOP

SUB defense (f, x(), y(), p, clr$, c$(), tang$(), tank$, turret$)
IF f = 11 THEN
FOR i = 1 TO 3
CIRCLE (x(p), y(p)), 30 + i, p
NEXT i
END IF

IF f = 12 THEN
FOR i = 1 TO 75
CIRCLE (x(p), y(p)), i, p
NEXT i
END IF

IF f = 13 THEN
DO UNTIL y(p) = 15

LINE (x(p) - 5, y(p) + 5)-(x(p) + 5, y(p) + 5), 14
PSET (x(p), y(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
y(p) = y(p) - 1
PSET (x(p), y(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
FOR i = 1 TO 10000
NEXT i
LOOP
END IF
END SUB

SUB enviro

END SUB

SUB explosion (snd$, six, f, x, y)
IF f = 1 OR f = 6 OR f = 7 OR f = 8 THEN bsize = 40
IF f = 9 THEN bsize = 150
IF f = 10 THEN bsize = 200
IF f = 2 OR f = 4 THEN bsize = 50
IF f = 3 THEN bsize = 100
d = .5
IF f = 10 AND six <> 0 THEN roulette = INT(RND * six) + 1 ELSE roulette = 0
IF f = 10 AND roulette <> 1 AND six > 0 THEN LET six = six - 1
IF f = 1 OR f = 5 OR f = 6 OR f = 7 OR f = 8 OR f = 2 OR f = 10 AND roulette = 1 THEN
IF roulette = 1 THEN LET six = 0
FOR i = 1 TO bsize STEP d
IF i < (bsize - 20) THEN CIRCLE (x, y), i, 4
IF snd$ = "y" THEN SOUND bsize + INT(i), .1
IF i > 20 THEN clr = clr + d: CIRCLE (x, y), clr, 0
NEXT i

IF x - clr > 0 AND x + clr < 640 AND y + clr < 480 AND y - clr > 0 THEN
CIRCLE (x, y), clr + d, 4
PAINT (x, y), 4, 4
CIRCLE (x, y), clr, 0
PAINT (x, y), 0, 0
CIRCLE (x, y), clr + d, 0
END IF

END IF

IF f = 3 THEN
FOR i = 1 TO bsize STEP d
IF i < (bsize - 20) THEN LINE (x - (4 - (i / 25)), y - i)-(x + (4 - (i / 25)), y - i), 4: LINE (x - (4 - (i / 25)), y + i)-(x + (4 - (i / 25)), y + i), 4
IF snd$ = "y" THEN SOUND bsize + INT(i), .05
IF i > 20 THEN clr = clr + d: LINE (x - (4 - (clr / 25)), y - clr)-(x + (4 - (clr / 25)), y - clr), 0: LINE (x - (4 - (clr / 25)), y + clr)-(x + (4 - (clr / 25)), y + clr), 0
NEXT i
END IF

IF f = 4 THEN
FOR i = 1 TO bsize
CIRCLE (x, y), i, 14
NEXT i
END IF
IF f = 9 THEN
FOR i = 1 TO bsize
CIRCLE (x, y), i, 15
NEXT i
END IF

IF f = 5 THEN
LINE (x - 2, 0)-(x + 2, 400), 14, BF
END IF
END SUB

SUB gfix
FOR g = 1 TO 639
LOCATE 27, 10: PRINT (640 - g)
FOR i = 0 TO 400
IF POINT(g, i) = 14 THEN h = h + 1: PSET (g, i), 0
NEXT i
IF h > 0 THEN LINE (g, 400)-(g, 401 - h), 14
h = 0
NEXT g
END SUB

SUB ground (tx(), ty(), p, g())
IF POINT(tx(p) - 1, ty(p) + 5) = 0 OR POINT(tx(p) + 1, ty(p) + 5) = 0 THEN LET ty(p) = ty(p) + 1
IF POINT(tx(p) - 9, ty(p) + 1) <> 0 AND POINT(tx(p) - 9, ty(p) + 1) <> p AND POINT(tx(p) - 9, ty(p) + 1) <> 15 THEN LET tx(p) = tx(p) + 1
IF POINT(tx(p) + 9, ty(p) + 1) <> 0 AND POINT(tx(p) + 9, ty(p) + 1) <> p AND POINT(tx(p) + 9, ty(p) + 1) <> 15 THEN LET tx(p) = tx(p) - 1
IF POINT(tx(p) - 1, ty(p) + 5) <> 0 AND POINT(tx(p) + 1, ty(p) + 5) <> 0 THEN LET g(p) = 0
END SUB

SUB help
CLS
PRINT "Important Information"
OPEN "tankhelp.dat" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, text$
PRINT "* "; text$
PRINT ""
LOOP
CLOSE #1
PRINT "Press Enter to Exit"
k$ = ""
DO UNTIL k$ = CHR$(13)
k$ = INKEY$
LOOP
END SUB

SUB highscore (high(), high$())
CLS
LOCATE 1, 30: PRINT "TANK WARS HIGH SCORES"
OPEN "tankwars.dat" FOR INPUT AS #1
FOR i = 1 TO 10
INPUT #1, high(i), high$(i)
NEXT i
FOR i = 1 TO 10
LOCATE i + 2, 30: PRINT i; ": "; high(i); "  "; high$(i)
NEXT i
CLOSE #1
k$ = ""
DO UNTIL k$ = CHR$(13)
k$ = INKEY$
LOOP
END SUB

SUB terrain
gx1 = 0
DO UNTIL gx1 > 640
a = INT(RND * 5) + 1
b = INT(RND * 5) + 1
c = INT(RND * 5) + 1
d = INT(RND * 10) + 1
e = INT(RND * 350) + 1
f = INT(RND * 320) + gx1
FOR x = gx1 TO f
y = 10 * a * SIN(x / 100 * b) + (2 * c * COS(x / d)) + e
IF y < 20 THEN y = 20
IF x <= 640 THEN LINE (x, 400)-(x, y), 14
NEXT x
gx1 = x
LOOP
END SUB

SUB weaponselect (turn(), bid(), plrs, title$(), weapons(), weapon$(), score())
CLS
LOCATE 2, 30: PRINT "Arsenal"
LOCATE 3, 15: PRINT "press the weapon code to receive ammo"
LOCATE 5, 10: PRINT "# code - Item": LOCATE 5, 50: PRINT "Cost"
LOCATE 6, 15: PRINT "1 - Normal Shell - impact": LOCATE 6, 52: PRINT "0"
LOCATE 7, 15: PRINT "2 - Missile - impact": LOCATE 7, 52: PRINT "2"
LOCATE 8, 15: PRINT "3 - Digger - non-impact": LOCATE 8, 52: PRINT "4"
LOCATE 9, 15: PRINT "4 - Dirtier - impact": LOCATE 9, 52: PRINT "8"
LOCATE 10, 15: PRINT "5 - The Wall - non-impact": LOCATE 10, 52: PRINT "15"
LOCATE 11, 15: PRINT "6 - Bomber - impact": LOCATE 11, 52: PRINT "20"
LOCATE 12, 15: PRINT "7 - Triple Xplosion - impact": LOCATE 12, 52: PRINT "30"
LOCATE 13, 15: PRINT "8 - Bomber - non-impact": LOCATE 13, 52: PRINT "40"
LOCATE 14, 15: PRINT "9 - EMP - non-impact": LOCATE 14, 52: PRINT "50"
LOCATE 15, 15: PRINT "0 - Nuclear Strike Attempt - impact": LOCATE 15, 52: PRINT "0"
LOCATE 17, 15: PRINT "a - Anti-Missle Defense": LOCATE 17, 52: PRINT "50"
LOCATE 16, 15: PRINT "s - Shield": LOCATE 16, 52: PRINT "20"
LOCATE 18, 15: PRINT "d - Elevator": LOCATE 18, 52: PRINT "20"
LOCATE 19, 15: PRINT "f - +10 Armor": LOCATE 19, 52: PRINT "60"

FOR p = 1 TO plrs
let scorehold=score(p)
let score(p)=int(score(p)/2)
FOR i = 1 TO 14
LOCATE i + 5, 10: PRINT " "
NEXT i
k$ = ""
DO UNTIL k$ = CHR$(13)
LOCATE 24, 30: PRINT "Player"; p
LOCATE 25, 20: PRINT title$(p); ": funds remaining ="; score(p)
FOR i = 1 TO 14
IF weapons(p, i) > 0 THEN LOCATE i + 5, 9: PRINT weapons(p, i)
NEXT i
k$ = INKEY$
IF k$ = "2" AND score(p) >= 2 AND weapons(p, 2) < 9 THEN LET weapons(p, 2) = weapons(p, 2) + 1: LET score(p) = score(p) - 2
IF k$ = "3" AND score(p) >= 4 AND weapons(p, 3) < 9 THEN LET weapons(p, 3) = weapons(p, 3) + 1: LET score(p) = score(p) - 4
IF k$ = "4" AND score(p) >= 8 AND weapons(p, 4) < 9 THEN LET weapons(p, 4) = weapons(p, 4) + 1: LET score(p) = score(p) - 8
IF k$ = "5" AND score(p) >= 15 AND weapons(p, 5) < 9 THEN LET weapons(p, 5) = weapons(p, 5) + 1: LET score(p) = score(p) - 15
IF k$ = "6" AND score(p) >= 20 AND weapons(p, 6) < 9 THEN LET weapons(p, 6) = weapons(p, 6) + 1: LET score(p) = score(p) - 20
IF k$ = "7" AND score(p) >= 30 AND weapons(p, 7) < 9 THEN LET weapons(p, 7) = weapons(p, 7) + 1: LET score(p) = score(p) - 30
IF k$ = "8" AND score(p) >= 40 AND weapons(p, 8) < 9 THEN LET weapons(p, 8) = weapons(p, 8) + 1: LET score(p) = score(p) - 40
IF k$ = "9" AND score(p) >= 50 AND weapons(p, 9) < 9 THEN LET weapons(p, 9) = weapons(p, 9) + 1: LET score(p) = score(p) - 50
IF k$ = "s" AND score(p) >= 20 AND weapons(p, 11) < 9 THEN LET weapons(p, 11) = weapons(p, 11) + 1: LET score(p) = score(p) - 20
IF k$ = "a" AND score(p) >= 50 AND weapons(p, 12) < 9 THEN LET weapons(p, 12) = weapons(p, 12) + 1: LET score(p) = score(p) - 50
IF k$ = "d" AND score(p) >= 20 AND weapons(p, 13) < 9 THEN LET weapons(p, 13) = weapons(p, 13) + 1: LET score(p) = score(p) - 20
IF k$ = "f" AND score(p) >= 60 AND weapons(p, 14) < 9 THEN LET weapons(p, 14) = weapons(p, 14) + 1: LET score(p) = score(p) - 60
LOOP
bid(p) = -1
k$ = "q"
DO UNTIL bid(p) >= 0
k$ = INKEY$
bids = 1000000
LOCATE 27, 1: PRINT "Player"; p; "bid for turn order (0-9)"
IF k$ = "0" THEN LET bids = 0
IF k$ = "1" THEN LET bids = 1
IF k$ = "2" THEN LET bids = 2
IF k$ = "3" THEN LET bids = 3
IF k$ = "4" THEN LET bids = 4
IF k$ = "5" THEN LET bids = 5
IF k$ = "6" THEN LET bids = 6
IF k$ = "7" THEN LET bids = 7
IF k$ = "8" THEN LET bids = 8
IF k$ = "9" THEN LET bids = 9
IF score(p) >= bids THEN LET score(p) = score(p) - bids: LET bid(p) = bids
LOOP
LOCATE 27, 1: PRINT "                                                "
let score(p)=scorehold-((scorehold/2)-score(p))
NEXT p
FOR i = 1 TO plrs
LET turn(i) = i
NEXT i
FOR i = 1 TO plrs - 1
FOR j = i + 1 TO plrs
IF bid(i) > bid(j) THEN SWAP bid(i), bid(j): SWAP turn(i), turn(j)
IF bid(i) = bid(j) THEN
IF INT(RND * 2) = 1 THEN SWAP bid(i), bid(j): SWAP turn(i), turn(j)
END IF
NEXT j
NEXT i
END SUB

