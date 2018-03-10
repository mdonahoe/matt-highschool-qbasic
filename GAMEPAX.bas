DECLARE SUB hold (l!)
DECLARE SUB highscore (high!(), high$())
DECLARE SUB help ()
DECLARE SUB weaponselect (turn!(), bid!(), plrs!, title$(), weapons!(), weapon$(), score!())
DECLARE SUB terrain (customt$, mapchc!)
DECLARE SUB ground (tx!(), ty!(), p!, g!())
DECLARE SUB defense (f!, x!(), y!(), p!, clr$, c$(), tang$(), tank$, turret$)
DECLARE SUB explosion (snd$, six!, f!, x!, y!)
DECLARE SUB gfix ()
DECLARE SUB editor (l$(), spot$, pellet$)
DECLARE SUB obs ()
maxp = 14
DIM pac$(4)
DIM pic(10000)
DIM a(maxp)
DIM b(maxp)
DIM c(maxp)
DIM d(maxp)
DIM h(maxp)
DIM j$(maxp)
DIM p$(maxp)
DIM s(maxp)
DIM px(maxp)
DIM py(maxp)
DIM space(17, 15)
DIM tempdot(17, 15)
DIM dr$(10)
DIM bid(maxp)
DIM turn(maxp)
DIM yold(maxp)
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
DATA Normal--imp,Missile-imp,Digger--non,Dirtier-imp,TheWall-non,Bomber--imp,TripleX-imp,Bomber--non,EMP-----non,Nuke----imp,Shield-----,Antimissle, Elevator--,Armor-----
FOR i = 1 TO 14
 READ weapon$(i)
NEXT i
CLS
SCREEN 12
RANDOMIZE TIMER
arrow$ = "h6d3l6d6r6d3e6"
DO
 z = 0
 DO UNTIL z > 0
  CLS
  LOCATE 10, 33: PRINT "by matt donahoe"
  LOCATE 15, 35: PRINT "Tank Wars"
  LOCATE 18, 35: PRINT "Pacman"
  LOCATE 21, 35: PRINT "Worm Tunnel"
  LOCATE 24, 35: PRINT "Exit"
  LET m = 15
  k$ = ""
  PSET (268, (16 * m) - 8), 0: DRAW "c4" + arrow$
  CALL hold(10)
  DO UNTIL k$ = CHR$(13)
   LET k$ = INKEY$
   IF k$ = CHR$(0) + "P" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + arrow$
    IF m < 24 THEN LET m = m + 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + arrow$
   END IF
   IF k$ = CHR$(0) + "H" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + arrow$
    IF m > 15 THEN LET m = m - 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + arrow$
   END IF
  LOOP
  FOR x = 268 TO 640
   PSET (x, (16 * m) - 8), 0: DRAW "c4" + arrow$
   CALL hold(10)
   PSET (x, (16 * m) - 8), 0: DRAW "c0" + arrow$
  NEXT x
  IF m = 15 THEN z = 1
  IF m = 18 THEN z = 2
  IF m = 21 THEN z = 3
  IF m = 24 THEN END
 LOOP
 IF z = 1 THEN
  pi = 3.1415926535897#
  bullet$ = "bl6u2r4f2g2l4u2"
  tank$ = "ta0bu4l3d2r8f3g3l10h3e3r8u2l3bd4"
  turret$ = "r10ul10d"
  bit$ = "u2l2r2d2"
  tanktitle1$ = "r30d10l10d20l10u20l10u10br34  r30d30l10u20l10d20l10u30br34  r10f10u10r10d30l10u10h10d20l10u30br34  r10d10e10r10g15f15l10h10d10l10u30"
  tanktitle2$ = "bm-102,34r10m+5,15e10f10m+5,-15r10m-10,30l5h10g10l5m-10,-30br54  r10m+10,30l7m-5,-20l6m-5,20l7m+10,-30br14  r24f6d6g6l5f12l10h7d7l4m-10,-30br40  r24d6l20d6r15f6d6g6l25h6r31u6l20h6u6e6"
  PRINT "press enter"
  DO UNTIL k$ = CHR$(13)
   k$ = INKEY$
  LOOP
  exitgame = 0
  DO UNTIL exitgame = 1
   z = 0
   DO UNTIL z = 1
    CLS
    FOR i = 1 TO 8
     PSET (300 - (i * 15), 244 - (30 * i)), 0: DRAW "s" + STR$(i) + "c4" + tanktitle1$ + tanktitle2$
     CALL hold(1000)
     PSET (300 - (i * 15), 244 - (30 * i)), 0: DRAW "c0" + tanktitle1$ + tanktitle2$
    NEXT i
    PSET (180, 4), 0: DRAW "c4" + tanktitle1$ + tanktitle2$
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
    CALL hold(100)
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
     CALL hold(10)
     PSET (x, (16 * m) - 8), 0: DRAW "c0" + bullet$
    NEXT x
    IF m = 15 THEN z = 1
    IF m = 18 THEN CALL highscore(high(), high$())
    IF m = 21 THEN CALL help
    IF m = 24 THEN z = 1: exitgame = 1
   LOOP
   IF exitgame = 0 THEN
    DRAW "s4"
    CLS
    plrs = 0
    DO UNTIL plrs > 1 AND plrs < (maxp + 1)
     INPUT "How many players?   (2-13) ", plrs
    LOOP
    gravity$ = ""
    DO UNTIL gravity$ = "y" OR gravity$ = "n"
     INPUT "Gravity?       (y/n) ", gravity$
    LOOP
    snd$ = ""
    DO UNTIL snd$ = "y" OR snd$ = "n"
     INPUT "Sound?         (y/n) ", snd$
    LOOP
    bouncy$ = ""
    DO UNTIL bouncy$ = "y" OR bouncy$ = "n"
     INPUT "Bouncy walls?  (y/n) ", bouncy$
    LOOP
    timeron$ = ""
    DO UNTIL timeron$ = "y" OR timeron$ = "n"
     INPUT "Time?          (y/n) ", timeron$
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
    points = 200
    FOR p = 1 TO plrs
     score(p) = points
     FOR i = 1 TO 10
     weapons(p, i) = 0
     NEXT i
    NEXT p
    game$ = ""
    DO UNTIL game$ = "n"
     game$ = ""
     CALL weaponselect(turn(), bid(), plrs, title$(), weapons(), weapon$(), score())
     CLS
    customt$ = ""
    DO UNTIL customt$ = "y" OR customt$ = "n"
     INPUT "Custom Terrain?(y/n) ", customt$
    LOOP
	mapchc = -1
	IF customt$ = "y" THEN
	OPEN "tankmap.tnk" FOR INPUT AS #1
	INPUT #1, current
	CLOSE #1
	DO UNTIL mapchc > -1 AND mapchc <= current
	PRINT "Input number from 1 to "; current; " or press 0 to create a new map"
	INPUT mapchc
	LOOP
	END IF
CLS
CALL terrain(customt$, mapchc)
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
       k$ = ""
       DO UNTIL k$ <> ""
	k$ = INKEY$
	IF timeron$ = "y" THEN LET time = time - .01
	IF time <= 0 THEN
	 LET angle(p) = INT(RND * 180)
	 LET power(p) = INT(RND * 500)
	 LET time = 0
	 LET f = 1
	 LET k$ = " "
	END IF
       LOCATE 27, 1: PRINT title$(p); ": "; "TIME"; INT(time), "angle"; angle(p), "health"; health(p), weapon$(f); weapons(p, f): LOCATE 28, 1: PRINT "press p to pass", "Nuclear Attack 1 in"; six
       LOOP
      PSET (tx(p), ty(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
      IF time > 0 THEN
       IF POINT(tx(p) - 1, ty(p) + 5) <> 0 AND POINT(tx(p) + 1, ty(p) + 5) <> 0 THEN
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
	IF k$ = "p" THEN LET customt$ = "w": mapchc = 0: CALL terrain(customt$, mapchc)
       END IF
       g(p) = 1
       DO UNTIL g(p) = 0
	PSET (tx(p), ty(p)), 0: DRAW clr$ + tang$(p) + turret$ + tank$
	CALL ground(tx(), ty(), p, g())
	IF g(p) = 1 THEN PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
	CALL hold(1)
       LOOP
      END IF
      IF angle(p) >= 177 THEN LET angle(p) = 176
      IF angle(p) < 4 THEN LET angle(p) = 4
      LET tang$(p) = "ta" + STR$(angle(p))
      IF ty(p) > 400 THEN LET health(p) = 0: LET shot = 1
      PSET (tx(p), ty(p)), 0: DRAW c$(p) + tang$(p) + turret$ + tank$
      CALL hold(100)
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
      pow = 50
      c = 1
      k$ = ""
      DO UNTIL k$ = CHR$(13)
       k$ = INKEY$
       LET pow = pow + c
       IF pow = powmax(p) OR pow = 50 THEN LET c = c * -1
       LINE (pow, 455)-(pow, 475), (2 * (1 + c)) + (7.5 * (1 - c))
       CALL hold(20)
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
	 CALL hold(100)
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
      IF gravity$ = "y" THEN
       LOCATE 27, 1: PRINT "                                                                               "
       LOCATE 28, 1: PRINT "                                                                               "
       LOCATE 27, 1: PRINT "WAIT!"
       CALL gfix
      END IF
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
      IF health(p) > 0 THEN LET win = win + p: score(p) = score(p) + 1
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
END IF
LOOP

END IF
IF z = 2 THEN

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
 PSET (258, (16 * m) - 8), 0: DRAW "c14" + pac$(2)
 CALL hold(100)
 DO UNTIL k$ = CHR$(13)
  LET k$ = INKEY$
  IF k$ = CHR$(0) + "P" THEN
   PSET (258, (16 * m) - 8), 0: DRAW "c0" + pac$(2)
   IF m < 24 THEN LET m = m + 3
   PSET (258, (16 * m) - 8), 0: DRAW "c14" + pac$(2)
  END IF
  IF k$ = CHR$(0) + "H" THEN
   PSET (258, (16 * m) - 8), 0: DRAW "c0" + pac$(2)
   IF m > 15 THEN LET m = m - 3
   PSET (258, (16 * m) - 8), 0: DRAW "c14" + pac$(2)
  END IF
 LOOP
 chew = 1
 FOR x = 258 TO 640
  PSET (x, (16 * m) - 8), 0: DRAW "c14" + pac$(INT(chew))

  CALL hold(30)
  PSET (x, (16 * m) - 8), 0: DRAW clr$ + "c0" + pac$(INT(chew))
  chew = chew + .1
  IF chew >= 5 THEN LET chew = 1
 NEXT x
 IF m = 15 THEN LET plrs = 1: LET z = 1
 IF m = 18 THEN LET plrs = 2: LET z = 1
 IF m = 21 THEN CALL editor(l$(), spot$, pellet$)
 IF m = 24 THEN LET z = 1: LET exitgame = 1
LOOP
IF exitgame = 0 THEN
again$ = ""
DO UNTIL again$ = "n"
 z = 0
 again$ = "n"
 FOR i = 1 TO plrs
  health(i) = 3
  score(i) = 0
 NEXT i
 DO UNTIL game = 1
  PSET (1, 1), 0: DRAW "a0s4"
  CLS
  levelscore = 0
  OPEN "pacman.dat" FOR INPUT AS #1
  INPUT #1, current
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
  team = plrs
  time = 0
  px(ghosts + 1) = 20
  py(ghosts + 1) = 20
  px(ghosts + 2) = 500
  py(ghosts + 2) = 20
  chew = 1
  s(ghosts + 1) = 5
  s(ghosts + 2) = 5
  FOR g = 1 TO ghosts
   d(g) = 1' ABS(g - 4) + (4 * INT(4 / (ABS(g - 4) + 4)))
   s(g) = 5
   px(g) = 260
   py(g) = 230
  NEXT g
  z = 0
  time = 0
  LOCATE 1, 70: PRINT "LEVEL #"; level
  LOCATE 2, 70: PRINT "SCORES:"
  LOCATE 6, 70: PRINT "LIVES:"
  FOR p = 1 TO plrs
   IF health(p) > 0 THEN
    FOR i = 1 TO health(p)
     PSET (520 + 20 * i, 200 + 20 * p), 0: DRAW "c" + STR$(p) + pac$(2)
     PAINT (519 + 20 * i, 200 + 20 * p), p, p
    NEXT i
   END IF
  NEXT p
  DO UNTIL z = 1
   CALL hold(1)
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
   IF k$ = "n" THEN z = 1
   IF k$ = "k" THEN z = 1: game = 1
   FOR p = 1 TO ghosts
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
 DO UNTIL again$ = "y" OR again$ = "n"
  INPUT "Again"; again$
 LOOP
LOOP
END IF
LOOP
END IF
 IF z = 3 THEN
 exitmulti = 0
 DO UNTIL exitmulti = 1
  SCREEN 12
  CLS
  plrs = 0
  DO UNTIL plrs > 0 AND plrs < 14
   INPUT "# of players"; plrs
  LOOP
  plrs = INT(plrs)
  FOR i = 1 TO plrs
   h(i) = 1
   c(i) = INT((190 / (plrs + 1)) * i) + 140
   b(i) = -1 ^ i
   x(i) = 1
   yold(i) = c(i)
  NEXT i
  FOR i = 1 TO plrs
   PRINT "player"; i
   p$(i) = ""
   DO UNTIL p$(i) <> "" AND LEN(p$) < 2
    INPUT "control key"; p$(i)
   LOOP
  NEXT i
  'SCREEN 7
  CLS
  LINE (160, 140)-(479, 140)
  LINE (160, 334)-(479, 334)
  exitworm = 0
  DO UNTIL exitworm = 1
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
   GET (163, 140)-(479, 344), pic
   CLS 'Delete this line to make serpinski triangles
   PUT (162, 140), pic
   FOR i = 1 TO plrs
   IF POINT(150, c(i) + y(i)) = 15 OR POINT(309, c(i) + y(i)) = 15 OR c(i) + y(i) > 333 OR c(i) + y(i) < 141 THEN h(i) = 0
    count = count + h(i) 'delete this line too
    IF h(i) = 1 THEN
     LINE (309, yold(i))-(310, c(i) + y(i)), i:
     yold(i) = y(i) + c(i)
    END IF
   NEXT i
   IF count > 0 THEN count = 0 ELSE exitworm = 1
  LOOP
 continue$ = ""
 SCREEN 12
 DO UNTIL continue$ = "y" OR continue$ = "n"
  INPUT "Continue?    (y/n)", continue$
 LOOP
 IF continue$ = "n" THEN exitmulti = 1
LOOP
END IF
SCREEN 12
LOOP 'final loop

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
CALL hold(10)
LOOP
END IF
END SUB

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
DO UNTIL ghosts1 > 0 AND ghosts1 < 9
 INPUT "# ghosts?", ghosts1
LOOP
ghosts = ghosts1
CLS
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
OPEN "new.map" FOR INPUT AS #1
INPUT #1, ghosts
DO UNTIL ghosts1 > 0 AND ghosts1 < 9
 INPUT "# ghosts?", ghosts1
LOOP
ghosts = ghosts1
CLS
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
x = 1: y = 1: c = -1
LOCATE 2, 70: PRINT "q - quit"
LOCATE 3, 70: PRINT "c - draw"
 DO UNTIL k$ = "q"
  k$ = INKEY$
  IF k$ = "c" THEN c = c * -1
  PSET ((x * 30) - 10, (y * 30) - 10), 0: DRAW "c2" + spot$ + pellet$

  CALL hold(1)
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
CALL hold(100)
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

SUB hold (l)
FOR i = 1 TO 10 * l  '10 for basic 5000 for firstbasic
NEXT i
END SUB

SUB obs
LINE (479, 140)-(479, 334), 15
FOR i = 0 TO 18
a = INT(RND * 100)
IF a <> 0 THEN LINE (479, i * 10 + 141)-(479, (i + 1) * 10 + 143), 0
NEXT i
END SUB

SUB terrain (customt$, mapchc)
IF customt$ = "n" THEN
 gx1 = 0
 DO UNTIL gx1 > 640
  a = INT(RND * 5) + 1
  b = INT(RND * 5) + 1
  c = INT(RND * 5) + 1
  d = INT(RND * 10) + 1
  E = INT(RND * 350) + 1
  f = INT(RND * 320) + gx1
  FOR x = gx1 TO f
   y = 10 * a * SIN(x / 100 * b) + (2 * c * COS(x / d)) + E
   IF y < 20 THEN y = 20
   IF x <= 640 THEN LINE (x, 400)-(x, y), 14
  NEXT x
  gx1 = x
 LOOP
END IF
IF customt$ = "y" AND mapchc = 0 THEN
 LINE (0, 20)-(640, 400), 14, BF
 x = 0: y = 20
 k$ = ""
 clr = 7
 size = 1
 DO UNTIL k$ = "q"
  k$ = INKEY$
  IF k$ = "a" AND x > 0 THEN x = x - 1
  IF k$ = "d" AND x + size < 640 THEN x = x + 1
  IF k$ = "w" AND y - size > 20 THEN y = y - 1
  IF k$ = "s" AND y < 400 THEN y = y + 1
  IF k$ = "c" THEN clr = clr * -1
  IF k$ = "b" AND size < 640 THEN size = size + 1
  IF k$ = "v" AND size > 1 THEN size = size - 1
  PSET (x, y), 0: DRAW "c" + STR$(clr + 7) + "u" + STR$(size) + "r" + STR$(size) + "d" + STR$(size) + "l" + STR$(size)
 LOOP
 customt$ = "w"
END IF
 IF customt$ = "w" THEN
 OPEN "tankmap.tnk" FOR INPUT AS #1
  INPUT #1, current
 CLOSE #1
current = current + 1
level$ = MID$(STR$(current), 2, LEN(STR$(current)) - 1) + ".tnk"
 OPEN level$ FOR OUTPUT AS #1
  FOR i = 0 TO 640
   FOR j = 20 TO 400
    WRITE #1, INT(POINT(i, j) / 14)
   NEXT j
  LOCATE 27, 2: PRINT "SAVING "; 640 - i; "         "
  NEXT i
 CLOSE #1
 OPEN "tankmap.tnk" FOR OUTPUT AS #1
  WRITE #1, current
 CLOSE #1
 customt$ = "y": mapchc = current
END IF
IF customt$ = "y" THEN
 level$ = MID$(STR$(mapchc), 2, LEN(STR$(mapchc)) - 1) + ".tnk"
 OPEN level$ FOR INPUT AS #1
  FOR i = 0 TO 640
   FOR j = 20 TO 400
    INPUT #1, x
    IF x = 1 THEN PSET (i, j), (14 * x)
   NEXT j
   LOCATE 27, 2: PRINT "LOADING "; 640 - i; "        "
  NEXT i
 CLOSE #1
END IF
PSET (1, 1), 0: DRAW "s4"
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
LET scorehold = score(p)
LET score(p) = INT(score(p) / 2)
FOR i = 1 TO 14
LOCATE i + 5, 10: PRINT " "
NEXT i
k$ = ""
time = 100.2
CALL hold(1)
DO UNTIL k$ = CHR$(13)
time = time - .02
LOCATE 24, 24: PRINT "TIME: "; INT(time); "  Player"; p
DO UNTIL ok$ = "t"
 LOCATE 25, 20: PRINT "press t                               "
 ok$ = INKEY$
LOOP
LOCATE 25, 20: PRINT title$(p); ": funds remaining ="; score(p)
FOR i = 1 TO 14
IF weapons(p, i) > 0 THEN LOCATE i + 5, 9: PRINT weapons(p, i)
NEXT i
k$ = INKEY$
IF time <= 0 THEN k$ = CHR$(13)
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
LET score(p) = scorehold - ((scorehold / 2) - score(p))
ok$ = ""
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

