DECLARE SUB energize ()
DECLARE SUB physics1 ()
DECLARE SUB cpu ()
DECLARE SUB physics4 (x!, vx!, y!, vy!)
DECLARE SUB healthy ()
DECLARE SUB physics2 ()
DECLARE SUB printer2 ()
DECLARE SUB buttons ()
DECLARE SUB detonate (a!, i!)
DECLARE SUB physics3 (x!, vx!, y!, vy!)
DECLARE SUB terrain ()
DECLARE SUB detonate2 ()
DECLARE FUNCTION reflecto! (x!, vx1!, vy1!, chc!)
DECLARE FUNCTION reflex! ()
RANDOMIZE TIMER
CONST PI = 3.14159
CONST cvt = PI / 180
CONST top = 5
CONST sand = 2
CONST dirt = 1
SCREEN 12
'FOR i = 1 TO 15
'LINE (200, 200)-(400, 300), i, BF
'SLEEP 10
'NEXT i
TYPE object
x AS SINGLE
y AS SINGLE
vx AS SINGLE
vy AS SINGLE
t AS SINGLE
oldx AS SINGLE
oldy AS SINGLE
inair AS INTEGER
owner AS INTEGER
typo AS INTEGER
fuse AS INTEGER
END TYPE
CONST maxplayers = 3
CONST maxcomps = 5
TYPE Tank
health AS INTEGER
phys AS object
title AS STRING * 9
energy AS INTEGER
END TYPE
TYPE blast
go AS INTEGER
x AS INTEGER
y AS INTEGER
r AS INTEGER
typo AS INTEGER
owner AS INTEGER
END TYPE
TYPE comp
phys AS object
health AS INTEGER
target AS INTEGER
stuff AS INTEGER
END TYPE
DIM SHARED ai(1 TO maxcomps) AS comp
DIM SHARED ground(1 TO 640, 1 TO 2)
DIM SHARED bombs(1 TO 60) AS object
DIM SHARED bomb(1 TO 60) AS blast
DIM SHARED player(1 TO maxplayers) AS Tank
DIM SHARED plrs
DIM SHARED ais
DIM SHARED game
DIM SHARED score(1 TO maxplayers)
DIM titles(1 TO 60, 1 TO 2)
DIM velc(1 TO 5)
velc(5) = (.2)
velc(4) = (.15)
velc(3) = (.1)
velc(2) = (.05)
velc(1) = (0)
DATA 1,2,3,3,3,3,3,4,5,7,7,7,7,7,8,8,9,9,10,10,11,11,11,11,11,13,13,13,13,13,14,15,16,17,17,17,17,17,19,19,19,19,19,20,21,22,22,23,23,25,26,26,26,27,27,27,28,28,28,29
DATA 1,1,1,2,3,4,5,1,1,1,2,3,4,5,1,4,1,4,1,4,1,2,3,4,5,1,2,3,4,5,2,3,4,1,2,3,4,5,1,2,3,4,5,3,3,2,4,1,5,2,1,3,5,1,3,5,1,3,5,4
FOR i = 1 TO 60
READ titles(i, 1)
NEXT i
FOR i = 1 TO 60
READ titles(i, 2)
NEXT i
DATA A,B,C,D,E,F,G
DIM SHARED note$(1 TO 7)
DIM SHARED pooop$
FOR i = 1 TO 7
READ note$(i)
NEXT i
DATA 4,5,15,14,13
DIM SHARED monk(1 TO 5)
FOR i = 1 TO 5
READ monk(i)
NEXT i
ireallyhatethis = 0
DO UNTIL ireallyhatethis = 1
CLS
CALL terrain
k$ = ""
LOCATE 1, 32: PRINT "Press P to play"
LOCATE 2, 32: PRINT "Print Q to quit"
DO UNTIL k$ = "p" OR k$ = "q"
goat = 0
FOR i = 1 TO 60
IF bombs(i).inair = 1 THEN goat = 1
NEXT i
IF goat = 0 THEN
ecks = INT(RND * 300 + 5)
why = INT(RND * 100 + 5)
vecks = RND - .5
vwhy = RND
'FOR wow = 1 TO 5
FOR i = 1 TO 60
bombs(i).x = titles(i, 1) * 5 + ecks
bombs(i).y = titles(i, 2) * 5 + why
bombs(i).inair = 1
bombs(i).typo = 15
bombs(i).owner = 1
bombs(i).fuse = 5000 - i * i
bombs(i).t = 0
bombs(i).vx = vecks
bombs(i).vy = vwhy + velc(titles(i, 2))
NEXT i
'NEXT wow
END IF
k$ = INKEY$
CALL physics2
CALL printer2
CALL detonate2
slab = slab + 1
IF slab > 640 THEN slab = 1
LINE (slab, 480)-(slab, ground(slab, 1)), dirt
LOOP
IF k$ = "p" THEN
ais = -1
PRINT "num of comps?"
DO UNTIL ais >= 0 AND ais < maxcomps + 1
INPUT ais
LOOP
plrs = 0
PRINT "num of plrs?"
DO UNTIL plrs > 0 AND plrs < maxplayers + 1
INPUT plrs
LOOP
health = 0
PRINT "num of health?"
DO UNTIL health > 0 AND health < 200
INPUT health
LOOP
FOR i = 1 TO plrs
score(i) = 0
NEXT i
ihatethis = 0
DO UNTIL ihatethis = 1
CLS
FOR i = 1 TO ais
ai(i).health = -1
NEXT i
FOR i = 1 TO 60
bomb(i).go = 0
bombs(i).inair = 0
NEXT i
FOR i = 1 TO plrs
player(i).phys.x = 150 * i
player(i).phys.y = 30
player(i).phys.vx = 0
player(i).phys.vy = 0
player(i).phys.oldx = 150 * i
player(i).phys.oldy = 30
player(i).health = health
player(i).phys.typo = 15
player(i).energy = 50
'15 14 4 5
NEXT i
CALL terrain
slab = 0
slob = 1
game = 1
DO UNTIL game = 0
slab = slab + 1
IF slab > 640 THEN slab = 1
ground(slab, 1) = ground(slab, 1) + slob
LINE (slab, 480)-(slab, ground(slab, 1)), dirt
PSET (slab, ground(slab, 1) - 2), 0
CALL healthy
CALL cpu
CALL buttons
CALL physics2
CALL printer2
CALL detonate2
CALL energize
LOOP
CLS
FOR i = 1 TO plrs
PRINT "Player "; i; "; "; score(i)
NEXT i
PRINT "Shall we have another round?"
k$ = ""
DO UNTIL k$ = "y" OR k$ = "n"
k$ = INKEY$
LOOP
IF k$ = "n" THEN ihatethis = 1
LOOP
ais = -1
plrs = 0
ELSE ireallyhatethis = 1
END IF
LOOP
END

SUB buttons
dangle = 45
dpower = 10
i = 1
k$ = INKEY$
IF k$ = "b" THEN LOCATE 1, 1: PRINT player(1).health, player(2).health, player(3).health
IF k$ = "m" THEN LOCATE 2, 1: PRINT player(1).energy, player(2).energy, player(3).energy
IF k$ = "n" THEN SLEEP 10
IF k$ = "q" OR k$ = "w" OR k$ = "e" OR k$ = "a" OR k$ = "s" OR k$ = "d" THEN i = 1
IF k$ = "7" OR k$ = "8" OR k$ = "9" OR k$ = "4" OR k$ = "5" OR k$ = "6" THEN i = 2
IF k$ = "i" OR k$ = "o" OR k$ = "p" OR k$ = "k" OR k$ = "l" OR k$ = ";" THEN i = 3
IF k$ = "q" OR k$ = "w" OR k$ = "e" OR k$ = "i" OR k$ = "o" OR k$ = "p" OR k$ = "7" OR k$ = "8" OR k$ = "9" THEN a = 1
IF k$ = "a" OR k$ = "s" OR k$ = "d" OR k$ = "k" OR k$ = "l" OR k$ = ";" OR k$ = "4" OR k$ = "5" OR k$ = "6" THEN a = 2
IF k$ = "q" OR k$ = "a" OR k$ = "i" OR k$ = "k" OR k$ = "7" OR k$ = "4" THEN b = 1
IF k$ = "w" OR k$ = "s" OR k$ = "o" OR k$ = "l" OR k$ = "8" OR k$ = "5" THEN b = 0
IF k$ = "e" OR k$ = "d" OR k$ = "p" OR k$ = ";" OR k$ = "9" OR k$ = "6" THEN b = -1
IF player(i).health > 0 AND player(i).energy > 0 THEN
IF a = 2 THEN
player(i).phys.vx = (COS((90 * (b + 1) - dangle * b) * cvt) * dpower * ABS(b)) / 10 + player(i).phys.vx
player(i).phys.vy = (SIN((90 * (b + 1) - dangle * b) * cvt) * dpower * ABS(1 - ABS(player(i).phys.inair * ABS(b)))) / -10 + player(i).phys.vy
player(i).phys.inair = 1
player(i).energy = player(i).energy - 1
END IF
z = 1
IF a = 1 AND player(i).energy > 9 THEN
player(i).energy = player(i).energy - 10
j = 1
big = 0
DO WHILE (z < 51)
IF bombs(z).t > big THEN big = bombs(i).t: j = z
IF bombs(z).inair = 0 THEN
j = z
z = 51
END IF
z = z + 1
LOOP
bombs(j).inair = 1
bombs(j).x = player(i).phys.x
bombs(j).y = player(i).phys.y
bombs(j).owner = i
bombs(j).vx = (COS((90 * (b + 1) - dangle * b) * cvt) * dpower * ABS(b)) / 10 + player(i).phys.vx '+ bombs(j).vx
bombs(j).vy = (SIN((90 * (b + 1) - dangle * b) * cvt) * dpower * ABS(1 - ABS(player(i).phys.inair * ABS(b)))) / -10 + player(i).phys.vy '+ bombs(j).vy
bombs(j).t = 0
bombs(j).typo = player(i).phys.typo
bombs(j).fuse = 1000
END IF
END IF
'IF k$ = "d" THEN player(i).phys.vx = 1
'IF k$ = "a" THEN player(i).phys.vx = -1
END SUB

SUB cpu
FOR k = 1 TO ais
IF ai(k).health < 0 THEN
ai(k).phys.x = INT(RND * 630 + 5)
ai(k).phys.y = 10
ai(k).phys.oldx = ai(k).phys.x
ai(k).phys.oldy = ai(k).phys.y
ai(k).phys.vx = 0
ai(k).phys.vy = 0
ai(k).phys.inair = 1
ai(k).phys.t = 0
ai(k).phys.typo = INT(RND * 5 + 1)
ai(k).health = 1
ai(k).stuff = 0
big = 0
FOR i = 1 TO plrs
IF player(i).health > big THEN ai(k).target = i: big = player(i).health
NEXT i
END IF
IF POINT(ai(k).phys.x, ai(k).phys.y + 5) = 0 OR POINT(ai(k).phys.x, ai(k).phys.y + 5) = 15 THEN ai(k).phys.inair = 1
IF ai(k).health > 0 AND ai(k).phys.inair = 1 THEN
ai(k).phys.oldx = ai(k).phys.x
ai(k).phys.oldy = ai(k).phys.y
CALL physics3(ai(k).phys.x, ai(k).phys.vx, ai(k).phys.y, ai(k).phys.vy)
IF ai(k).phys.y >= 480 THEN ai(k).health = -1
IF POINT(ai(k).phys.x + 5, ai(k).phys.y) = sand THEN ai(k).phys.vx = 0
IF POINT(ai(k).phys.x - 5, ai(k).phys.y) = sand THEN ai(k).phys.vx = 0
IF POINT(ai(k).phys.x, ai(k).phys.y + 5) = sand AND ai(k).phys.vy > 0 THEN ai(k).phys.inair = 0: ai(k).phys.vy = 0: ai(k).phys.vx = 0
IF ai(k).phys.y + 5 >= ground(INT(ai(k).phys.x), 1) THEN
ai(k).phys.y = ground(INT(ai(k).phys.x), 1) - 5
ai(k).phys.vx = .5 * reflecto(ai(k).phys.x, ai(k).phys.vx, ai(k).phys.vy, 1)
IF ai(k).phys.vx > top THEN ai(k).phys.vx = top
IF ai(k).phys.vx < -top THEN ai(k).phys.vx = -top
ai(k).phys.vy = 0
IF ABS(ai(k).phys.vx) < .02 THEN ai(k).phys.inair = 0: ai(k).phys.vx = 0
END IF
END IF
IF ai(k).phys.typo = 1 THEN
ai(k).phys.t = ai(k).phys.t + 1
IF ai(k).phys.t = 1500 THEN
ai(k).phys.t = 0
IF player(ai(k).target).phys.x < ai(k).phys.x THEN angle = 135
IF player(ai(k).target).phys.x >= ai(k).phys.x THEN angle = 45
xpower = SQR(ABS(ai(k).phys.x - player(ai(k).target).phys.x)) / 10
ypower = SQR(ABS(ai(k).phys.y - player(ai(k).target).phys.y)) / 10
IF xpower < .5 THEN xpower = .5
IF ypower < .5 THEN ypower = .5
j = 1
big = 0
z = 1
DO WHILE (z < 51)
IF bombs(z).t > big THEN big = bombs(z).t: j = z
IF bombs(z).inair = 0 THEN
j = z
z = 51
END IF
z = z + 1
LOOP
bombs(j).inair = 1
bombs(j).x = ai(k).phys.x
bombs(j).y = ai(k).phys.y
bombs(j).owner = 4
bombs(j).vx = COS(angle * cvt) * xpower
bombs(j).vy = SIN(angle * cvt) * -ypower
bombs(j).t = 0
bombs(j).typo = 4
bombs(j).fuse = 3000
END IF
END IF
IF ai(k).phys.typo = 2 THEN
IF ai(k).phys.inair = 1 AND INT(ai(k).phys.vy * 200) = 0 AND ai(k).phys.vx = 0 THEN
FOR i = 1 TO 3
'LOCATE 3 + i, 1: PRINT ai(k).phys.vy
IF player(ai(k).target).phys.x < ai(k).phys.x THEN angle = 135
IF player(ai(k).target).phys.x >= ai(k).phys.x THEN angle = 45
xpower = i * .5 + .5
ypower = 0'SQR(ABS(ai(k).phys.y - player(ai(k).target).phys.y)) / 10
IF xpower < .5 THEN xpower = .5
'IF ypower < .5 THEN ypower = .5
j = 1
big = 0
z = 1
DO WHILE (z < 51)
IF bombs(z).t > big THEN big = bombs(z).t: j = z
IF bombs(z).inair = 0 THEN
j = z
z = 51
END IF
z = z + 1
LOOP
'LOCATE 2, 1: PRINT j
bombs(j).inair = 1
bombs(j).x = ai(k).phys.x
bombs(j).y = ai(k).phys.y
bombs(j).owner = 4
bombs(j).vx = COS(angle * cvt) * xpower
bombs(j).vy = SIN(angle * cvt) * -ypower
bombs(j).t = 0
bombs(j).typo = 5
bombs(j).fuse = 750
NEXT i
END IF
IF ai(k).phys.inair = 0 THEN ai(k).phys.t = ai(k).phys.t + 1
IF ai(k).phys.t = 200 THEN
ai(k).phys.t = 0
xpower = 0'SQR(ABS(ai(k).phys.x - player(ai(k).target).phys.x)) / 10
ypower = -1'SQR(ABS(ai(k).phys.y - player(ai(k).target).phys.y)) / 10
ai(k).phys.inair = 1
ai(k).phys.vy = ypower
END IF
END IF
IF ai(k).phys.typo = 3 THEN
IF ai(k).phys.inair = 0 THEN
ai(k).stuff = 1
IF player(ai(k).target).phys.x < ai(k).phys.x THEN angle = 135
IF player(ai(k).target).phys.x >= ai(k).phys.x THEN angle = 45
xpower = SQR(ABS(ai(k).phys.x - player(ai(k).target).phys.x)) / 10
ypower = SQR(ABS(ai(k).phys.y - player(ai(k).target).phys.y)) / 5
IF xpower < .5 THEN xpower = .5
IF ypower < .5 THEN ypower = .5
ai(k).phys.vy = SIN(angle * cvt) * -ypower
ai(k).phys.vx = COS(angle * cvt) * xpower
ai(k).phys.inair = 1
END IF
IF INT(ai(k).phys.x) = INT(player(ai(k).target).phys.x) AND player(ai(k).target).phys.y > ai(k).phys.y AND ai(k).stuff = 1 THEN
j = 1
big = 0
z = 1
DO WHILE (z < 51)
IF bombs(z).t > big THEN big = bombs(z).t: j = z
IF bombs(z).inair = 0 THEN
j = z
z = 51
END IF
z = z + 1
LOOP
bombs(j).inair = 1
bombs(j).x = ai(k).phys.x
bombs(j).y = ai(k).phys.y
bombs(j).owner = 4
bombs(j).vx = 0
bombs(j).vy = 0
bombs(j).t = 0
bombs(j).typo = 15
bombs(j).fuse = 750
ai(k).stuff = 0
END IF
END IF
IF ai(k).phys.typo = 4 THEN
IF ai(k).phys.inair = 0 THEN
FOR i = -1 TO 1
j = 1
big = 0
z = 1
DO WHILE (z < 61)
IF bombs(z).t > big THEN big = bombs(z).t: j = z
IF bombs(z).inair = 0 THEN
j = z
z = 61
END IF
z = z + 1
LOOP
bombs(j).inair = 1
bombs(j).x = ai(k).phys.x
bombs(j).y = ai(k).phys.y
bombs(j).owner = 4
bombs(j).vx = i
bombs(j).vy = -1
bombs(j).t = 0
bombs(j).typo = 14
bombs(j).fuse = 750
NEXT i
ai(k).health = 0
END IF
END IF
IF ai(k).phys.typo = 5 THEN
ai(k).phys.t = ai(k).phys.t + 1
IF ai(k).phys.t = 500 THEN
ai(k).phys.t = 0
IF player(ai(k).target).phys.x < ai(k).phys.x THEN angle = 135
IF player(ai(k).target).phys.x >= ai(k).phys.x THEN angle = 45
xpower = SQR(ABS(ai(k).phys.x - player(ai(k).target).phys.x)) / 10
ypower = SQR(ABS(ai(k).phys.y - player(ai(k).target).phys.y)) / 10
IF xpower < .5 THEN xpower = .5
IF ypower < .5 THEN ypower = .5
j = 1
big = 0
z = 1
DO WHILE (z < 51)
IF bombs(z).t > big THEN big = bombs(z).t: j = z
IF bombs(z).inair = 0 THEN
j = z
z = 51
END IF
z = z + 1
LOOP
bombs(j).inair = 1
bombs(j).x = ai(k).phys.x
bombs(j).y = ai(k).phys.y
bombs(j).owner = 4
bombs(j).vx = COS(angle * cvt) * xpower
bombs(j).vy = SIN(angle * cvt) * -ypower
bombs(j).t = 0
bombs(j).typo = 13
bombs(j).fuse = 3000
END IF
END IF

NEXT k
END SUB

SUB detonate (a, i)
IF a = 1 THEN
x = player(i).phys.x
y = player(i).phys.y
own = i
typo = 1
END IF
IF a = 2 THEN
x = bombs(i).x
y = bombs(i).y
IF bombs(i).typo = 4 THEN y = y - 25
own = bombs(i).owner
bombs(i).inair = 0
bombs(i).vy = 0
bombs(i).vx = 0
typo = bombs(i).typo
END IF
IF a = 3 THEN
x = ai(i).phys.x
y = ai(i).phys.y
own = 4
typo = 15
END IF
z = 1
j = 1
DO WHILE (z < 61)
IF bomb(z).go = 0 THEN
j = z
z = 61
ELSE
z = z + 1
END IF
LOOP
bomb(j).go = 1
bomb(j).x = x
bomb(j).y = y
bomb(j).r = 1
bomb(j).owner = own
bomb(j).typo = typo
END SUB

SUB detonate2
CONST radius = 15
FOR i = 1 TO 60
IF bomb(i).go = 1 AND bomb(i).r <= radius THEN
CIRCLE (bomb(i).x, bomb(i).y), bomb(i).r + 2, 4
CIRCLE (bomb(i).x + 1, bomb(i).y), bomb(i).r + 2, 4
bomb(i).r = bomb(i).r + 1
FOR j = 1 TO plrs
IF ((player(j).phys.x - bomb(i).x) * (player(j).phys.x - bomb(i).x) + (player(j).phys.y - bomb(i).y) * (player(j).phys.y - bomb(i).y)) < (bomb(i).r + 2) * (bomb(i).r + 2) AND player(j).health > 0 THEN
player(j).health = player(j).health - 1
difx = (player(j).phys.x - bomb(i).x)
dify = (player(j).phys.y - bomb(i).y)
player(j).phys.vx = player(j).phys.vx + SQR(ABS((radius + 2) * (radius + 2) - dify * dify)) / (ABS(difx) + 1) * difx / 500
player(j).phys.vy = player(j).phys.vy + SQR(ABS((radius + 2) * (radius + 2) - difx * difx)) / (ABS(dify) + 1) * dify / 500
IF bomb(i).owner <> 4 AND j <> bomb(i).owner THEN player(bomb(i).owner).health = player(bomb(i).owner).health + 5: score(bomb(i).owner) = score(bomb(i).owner) + 10
END IF
NEXT j
FOR j = 1 TO ais
IF ((ai(j).phys.x - bomb(i).x) * (ai(j).phys.x - bomb(i).x) + (ai(j).phys.y - bomb(i).y) * (ai(j).phys.y - bomb(i).y)) < (bomb(i).r + 2) * (bomb(i).r + 2) AND ai(j).health > 0 THEN
ai(j).health = ai(j).health - 1
IF ai(j).health < 0 THEN ai(j).health = 0
IF bomb(i).owner <> 4 THEN
player(bomb(i).owner).health = player(bomb(i).owner).health + 5
IF player(bomb(i).owner).health > 50 THEN player(bomb(i).owner).health = 50
score(bomb(i).owner) = score(bomb(i).owner) + 10
player(bomb(i).owner).phys.typo = monk(ai(j).phys.typo)

END IF
END IF
NEXT j
END IF
IF bomb(i).go = 1 AND bomb(i).r > radius THEN
CIRCLE (bomb(i).x, bomb(i).y), bomb(i).r - radius, 0
CIRCLE (bomb(i).x + 1, bomb(i).y), bomb(i).r - radius, 0
bomb(i).r = bomb(i).r + 1
IF bomb(i).r = (radius * 2 + 3) THEN
bomb(i).go = 0
bomb(i).x = 0
bomb(i).y = 0
bomb(i).r = 0
END IF
END IF
NEXT i
END SUB

SUB energize
FOR i = 1 TO plrs
IF player(i).phys.inair = 0 THEN player(i).energy = player(i).energy + 1
IF player(i).energy > 50 THEN player(i).energy = 50
NEXT i
END SUB

SUB healthy
game = 0
FOR i = 1 TO plrs
IF player(i).health = 0 THEN CALL detonate(1, i): player(i).health = -1
IF player(i).health > 0 THEN game = game + 1
NEXT i
IF plrs > 1 AND game = 1 THEN game = 0
FOR i = 1 TO ais
IF ai(i).health = 0 THEN CALL detonate(3, i): ai(i).health = -1
NEXT i
END SUB

SUB options
z = 1
DO WHILE z = 1
LOCATE 15, 10: PRINT "Players---"
LOCATE 16, 10: PRINT "Computers-"
LOCATE 17, 10: PRINT "Health----"
LOOP
END SUB

SUB physics2
FOR i = 1 TO plrs
IF POINT(player(i).phys.x, player(i).phys.y + 5) = 0 OR POINT(player(i).phys.x, player(i).phys.y + 5) = 15 THEN player(i).phys.inair = 1
IF player(i).health > 0 AND player(i).phys.inair = 1 THEN
player(i).phys.oldx = player(i).phys.x
player(i).phys.oldy = player(i).phys.y
CALL physics3(player(i).phys.x, player(i).phys.vx, player(i).phys.y, player(i).phys.vy)
IF POINT(player(i).phys.x + 5, player(i).phys.y) = sand THEN player(i).phys.vx = 0
IF POINT(player(i).phys.x - 5, player(i).phys.y) = sand THEN player(i).phys.vx = 0
IF POINT(player(i).phys.x, player(i).phys.y + 5) = sand AND player(i).phys.vy >= 0 THEN player(i).phys.inair = 0: player(i).phys.vy = 0: player(i).phys.vx = 0
IF player(i).phys.y + 5 >= ground(INT(player(i).phys.x), 1) THEN
player(i).phys.y = ground(INT(player(i).phys.x), 1) - 5
player(i).phys.vx = .5 * reflecto(player(i).phys.x, player(i).phys.vx, player(i).phys.vy, 1)
IF player(i).phys.vx > top THEN player(i).phys.vx = top
IF player(i).phys.vx < -top THEN player(i).phys.vx = -top
player(i).phys.vy = 0'vy + reflecto(player(i).phys.x, player(i).phys.vx, player(i).phys.vy, 2)
IF ABS(player(i).phys.vx) < .02 THEN player(i).phys.inair = 0: player(i).phys.vx = 0
END IF

IF player(i).phys.y >= 480 THEN player(i).health = 0
END IF
NEXT i
FOR i = 1 TO 60
IF bombs(i).inair = 1 THEN
bombs(i).t = bombs(i).t + 1
bombs(i).oldx = bombs(i).x
bombs(i).oldy = bombs(i).y
CALL physics3(bombs(i).x, bombs(i).vx, bombs(i).y, bombs(i).vy)
IF bombs(i).y >= 485 THEN bombs(i).inair = 0
IF bombs(i).t > 10 THEN
IF bombs(i).typo = 15 OR bombs(i).typo = 13 THEN
IF POINT(bombs(i).x, bombs(i).y) > 0 AND POINT(bombs(i).x, bombs(i).y) <> dirt AND POINT(bombs(i).x, bombs(i).y) <> 15 THEN CALL detonate(2, i)
END IF
IF bombs(i).typo = 4 THEN
FOR j = 1 TO plrs
IF player(j).health > 0 AND INT(player(j).phys.x / 3) = INT(bombs(i).x / 3) AND player(j).phys.y - bombs(i).y >= -50 AND player(j).phys.y - bombs(i).y <= 0 THEN CALL detonate(1, j)
NEXT j
END IF
IF bombs(i).typo = 14 THEN
IF POINT(bombs(i).x, bombs(i).y) > 0 AND POINT(bombs(i).x, bombs(i).y) <> dirt AND POINT(bombs(i).x, bombs(i).y) <> sand THEN CALL detonate(2, i)
END IF
IF bombs(i).typo = 5 THEN
IF POINT(bombs(i).x, bombs(i).y) > 0 AND POINT(bombs(i).x, bombs(i).y) <> dirt AND POINT(bombs(i).x, bombs(i).y) <> bombs(i).owner + 10 THEN CALL detonate(2, i)
END IF
IF bombs(i).t = bombs(i).fuse THEN CALL detonate(2, i)
IF bombs(i).y + 5 >= ground(INT(bombs(i).x), 1) THEN
'PLAY "MBL64T32N" + STR$(INT(ground(INT(bombs(i).x), 1) / 6))
bombs(i).y = ground(INT(bombs(i).x), 1) - 5
vx = reflecto(bombs(i).x, bombs(i).vx, bombs(i).vy, 1)
IF vx > top THEN vx = top
IF vx < -top THEN vx = -top
vy = reflecto(bombs(i).x, bombs(i).vx, bombs(i).vy, 2)
IF bombs(i).typo = 13 THEN vy = reflecto(bombs(i).x, vx, bombs(i).vy, 2)
IF bombs(i).vy > top THEN vy = top
IF bombs(i).vy < -top THEN vy = -top
bombs(i).vx = vx
bombs(i).vy = vy
END IF
END IF
END IF
NEXT i
END SUB

SUB physics3 (x, vx, y, vy)
gravity = .005
IF vx > top THEN vx = top
IF vx < -top THEN vx = -top
x = x + vx
vy = vy + gravity
IF vy >= top THEN vy = top
IF vy < -top THEN vy = -top
y = y + vy
IF y <= 0 THEN vy = ABS(vy): y = 0
IF x <= 1 THEN
x = 1
vx = ABS(vx) * .6
END IF
IF x >= 639 THEN
x = 639
vx = ABS(vx) * -.6
END IF
END SUB

SUB printer2
FOR i = 1 TO 60
IF bombs(i).inair = 1 THEN
IF bombs(i).typo = 15 THEN
CIRCLE (bombs(i).oldx, bombs(i).oldy), 2, 0
CIRCLE (bombs(i).x, bombs(i).y), 2, 15
END IF
IF bombs(i).typo = 13 THEN
CIRCLE (bombs(i).oldx, bombs(i).oldy), 2, 0
CIRCLE (bombs(i).x, bombs(i).y), 2, 1
END IF

IF bombs(i).typo = 14 THEN
CIRCLE (bombs(i).x, bombs(i).y), 2, sand
END IF
IF bombs(i).typo = 4 THEN
FOR j = -1 TO 1
LINE (bombs(i).oldx + j, bombs(i).oldy)-(bombs(i).oldx + j, bombs(i).oldy - 30), 0
LINE (bombs(i).x + j, bombs(i).y)-(bombs(i).x + j, bombs(i).y - 30), bombs(i).typo
NEXT j
END IF
IF bombs(i).typo = 5 THEN
CIRCLE (bombs(i).oldx, bombs(i).oldy), 2, 0
CIRCLE (bombs(i).x, bombs(i).y), 2, bombs(i).owner + 10
END IF
END IF
NEXT i
FOR i = 1 TO plrs
IF player(i).health > 0 THEN
PSET (player(i).phys.oldx, player(i).phys.oldy), 0
CIRCLE (player(i).phys.oldx, player(i).phys.oldy), 4, 0
PSET (player(i).phys.x, player(i).phys.y), i + 10
CIRCLE (player(i).phys.x, player(i).phys.y), 4, i + 10
END IF
NEXT i
FOR i = 1 TO ais
IF ai(i).health > 0 THEN
CIRCLE (ai(i).phys.oldx, ai(i).phys.oldy), 4, 0
PSET (ai(i).phys.oldx, ai(i).phys.oldy), 0
CIRCLE (ai(i).phys.x, ai(i).phys.y), 4, 14
PSET (ai(i).phys.x, ai(i).phys.y), 14
END IF
NEXT i
END SUB

FUNCTION reflecto (x, vx1, vy1, chc)
slope = ground(x, 2)
xA = vx1 * 10
yA = -vy1 * 10
rA = SQR(xA * xA + yA * yA)
IF rA > 0 THEN
cosA = xA / rA
sinA = yA / rA
xB = slope
yB = 1
rB = SQR(xB * xB + yB * yB)
cosB = xB / rB
sinB = yB / rB
sinR = 2 * sinB * cosB * cosA - sinA * cosB * cosB + sinB * sinB * sinA
cosR = 2 * cosB * sinB * sinA - cosA * sinB * sinB + cosB * cosB * cosA
xR = cosR * rA / 10
yR = sinR * rA / 10
vx2 = -xR
vy2 = yR
END IF
IF chc = 1 THEN reflecto = vx2
IF chc = 2 THEN reflecto = vy2
END FUNCTION

SUB terrain
a = 10 * INT(RND * 5 + 1)
b = .01 * INT(RND * 5 + 1)
c = 2 * INT(RND * 5 + 1)
d = 1 / INT(RND * 25 + 10)
gv = RND - .5
E = -gv * 400 + 240
'e = -(gv + ABS(gv)) * gv * 400 + 440
'LOCATE 3, 1: PRINT a, b, c, d, e, gv
FOR x = 1 TO 640
ground(x, 1) = E + gv * x + gv * gv * gv * (x - 320) * (x - 320) / 100 + a * SIN(x * b) + c * COS(x * d)
ground(x, 2) = gv + gv * gv * gv * (2 * x - 640) / 100 + a * b * COS(x * b) - c * d * SIN(x * d)

NEXT x
FOR x = 1 TO 640
y = ground(x, 1)
LINE (x, y - 1)-(x, y - 31), sand
LINE (x, y - 1)-(x, 480), dirt
NEXT x
'test = 1
'pooop$ = "MBL16O2"
'FOR u = 1 TO 64
'        s = 10 * u
'        IF ground(s, 2) < 0 AND test < 0 THEN
'               test = 1
'               pooop$ = pooop$ + "L" + STR$((ground(s, 1) MOD 64 + 1))
'        END IF
'        IF ground(s, 2) > 0 AND test > 0 THEN
'                test = 1
'                pooop$ = pooop$ + "L" + STR$((ground(s, 1) MOD 64 + 1))
'        END IF
'        pooop$ = pooop$ + note$((ground(s, 1) MOD 7) + 1)
'NEXT u
'
'FOR i = 0 TO 7
'poop$ = poop$ + "L" + STR$(INT(ground(i * 10 + 1, 2)) * 4) + "O" + STR$(INT(ground(i * 8 + 1, 1)) MOD 7 + 1)
'FOR j = 0 TO 9
'pooop$ = pooop$ + note$((ground(i * 10 + j + 1, 1) MOD 7) + 1)
'NEXT j
'NEXT i
'PRINT pooop$
'PLAY pooop$
END SUB

