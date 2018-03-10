DECLARE SUB terrain ()
DECLARE SUB quick ()
DECLARE SUB detonate2 ()
DECLARE SUB physics ()
DECLARE SUB detonate (i!)
DECLARE SUB printing ()
DECLARE SUB weaponfire ()
RANDOMIZE TIMER
CONST PI = 3.14159
CONST cvt = PI / 180

SCREEN 12
TYPE object
x AS SINGLE
y AS SINGLE
vx AS SINGLE
vy AS SINGLE
oldvx AS SINGLE
oldvy AS SINGLE
tx AS SINGLE
ty AS SINGLE
oldx AS SINGLE
oldy AS SINGLE
inair AS INTEGER
shelltype AS INTEGER
player AS INTEGER
END TYPE
CONST maxplayers = 20
TYPE Tank
health AS INTEGER
phys AS object
oldangle AS INTEGER
angle AS INTEGER
power AS INTEGER
title AS STRING * 9
shells AS object
shellselect AS INTEGER
score AS INTEGER
END TYPE
TYPE blast
go AS INTEGER
x AS INTEGER
y AS INTEGER
r AS INTEGER
END TYPE
DIM SHARED bombs(1 TO 50) AS object
DIM SHARED bomb(1 TO maxplayers) AS blast
DIM SHARED player(1 TO maxplayers) AS Tank
DIM SHARED order(1 TO maxplayers)
DIM SHARED currentplayer AS INTEGER
DIM SHARED currentturn AS INTEGER
DIM SHARED plrs
DIM SHARED shelldraw$(1 TO 9)
DIM SHARED turret$
DIM SHARED pow(1 TO maxplayers)
DIM SHARED envir AS object
turret$ = "r10ul10d"
shelldraw$(2) = "bh4r8d8l8u8f4"
shelldraw$(1) = "bll"'"h2l4d4r4e2"
INPUT plrs
FOR i = 1 TO plrs
order(i) = i
player(i).power = 100
player(i).angle = 90
player(i).phys.x = 150 * i
player(i).phys.y = 0
player(i).phys.oldx = 150 * i
player(i).phys.oldy = 0
player(i).health = 20
player(i).score = 20
NEXT i
currentturn = 1
currentplayer = order(currentturn)
CALL terrain
DO
LOCATE 1, 20: PRINT player(1).score; "  "; player(2).score
CALL quick
'CALL weaponfire
'SLEEP 5
CALL physics
CALL printing
CALL detonate2
LOOP

SUB detonate (i)
player(i).shells.inair = 0
bomb(i).go = 1
bomb(i).x = player(i).shells.x
bomb(i).y = player(i).shells.y
bomb(i).r = 1
END SUB

SUB detonate2
gorch = 0
CONST radius = 29
FOR i = 1 TO plrs
IF bomb(i).go = 1 AND bomb(i).r <= radius THEN
        CIRCLE (bomb(i).x, bomb(i).y), bomb(i).r, 4
        CIRCLE (bomb(i).x + 1, bomb(i).y), bomb(i).r, 4
        'SLEEP 1
        bomb(i).r = bomb(i).r + 1
END IF
IF bomb(i).go = 1 AND bomb(i).r > radius THEN
        gorch = 1
        CIRCLE (bomb(i).x, bomb(i).y), bomb(i).r - radius, 0
        CIRCLE (bomb(i).x + 1, bomb(i).y), bomb(i).r - radius, 0
        bomb(i).r = bomb(i).r + 1
        IF bomb(i).r = (radius * 2 + 1) THEN
                bomb(i).go = 0
                bomb(i).x = 0
                bomb(i).y = 0
                bomb(i).r = 0
        END IF
END IF
NEXT i
IF gorch = 1 THEN
        FOR j = 1 TO plrs
                IF POINT(player(j).phys.oldx, player(j).phys.oldy) = 0 AND POINT(player(j).phys.x, player(j).phys.y) = 0 THEN player(j).health = player(j).health - 10
                IF POINT(player(j).phys.oldx + 4, player(j).phys.oldy) = 0 AND POINT(player(j).phys.x + 4, player(j).phys.y) = 0 THEN player(j).health = player(j).health - 5
                IF POINT(player(j).phys.oldx - 4, player(j).phys.oldy) = 0 AND POINT(player(j).phys.x - 4, player(j).phys.y) = 0 THEN player(j).health = player(j).health - 5
                IF player(j).health < 0 THEN
                player(j).health = 20
                player(j).score = player(j).score - 1
                END IF
        NEXT j
END IF
END SUB

SUB physics
'PRINT 1
time = .05
wind = 0
gravity = .01
FOR i = 1 TO plrs
IF POINT(player(i).phys.x, player(i).phys.y + 5) = 0 THEN player(i).phys.inair = 1
IF player(i).phys.inair = 1 THEN
        'LOCATE 2, 2: PRINT player(i).phys.tx
        player(i).phys.tx = player(i).phys.tx + time
        player(i).phys.ty = player(i).phys.ty + time
        player(i).phys.vx = player(i).phys.vx + wind * player(i).phys.tx
        player(i).phys.vy = player(i).phys.vy + gravity * player(i).phys.ty
        player(i).phys.x = player(i).phys.oldx + player(i).phys.vx * time
        player(i).phys.y = player(i).phys.oldy + player(i).phys.vy * time
        IF player(i).phys.x > 640 THEN
                player(i).phys.tx = 1
                player(i).phys.x = 640
                player(i).phys.vx = player(i).phys.vx * -1
        END IF
        IF player(i).phys.x < 0 THEN
                player(i).phys.tx = 1
                player(i).phys.x = 0
                player(i).phys.vx = player(i).phys.vx * -1
        END IF
        IF player(i).phys.y > 480 THEN player(i).score = 0
        IF POINT(player(i).phys.x, player(i).phys.y + 5) > 0 AND POINT(player(i).phys.x, player(i).phys.y + 5) <> i THEN
                player(i).phys.vx = 0
                'player(i).phys.vy = player(i).phys.vy * -1
                player(i).phys.vy = 0
                player(i).phys.tx = 0
                player(i).phys.ty = 0
                player(i).phys.inair = 0
        END IF
END IF
IF player(i).shells.inair = 1 THEN
        player(i).shells.tx = player(i).shells.tx + time
        player(i).shells.ty = player(i).shells.ty + time
        player(i).shells.vx = player(i).shells.vx + wind * player(i).shells.tx
        player(i).shells.vy = player(i).shells.vy + gravity * player(i).shells.ty
        player(i).shells.x = player(i).shells.oldx + player(i).shells.vx * time
        player(i).shells.y = player(i).shells.oldy + player(i).shells.vy * time
        IF player(i).shells.x > 639 THEN
                player(i).shells.tx = 1
                player(i).shells.x = 640
                player(i).shells.vx = player(i).shells.vx * -1
        END IF
        IF player(i).shells.x < 0 THEN
                player(i).shells.tx = 1
                player(i).shells.x = 0
                player(i).shells.vx = player(i).shells.vx * -1

        END IF
        IF player(i).shells.y >= 480 THEN player(i).shells.inair = 0
        pix = POINT(player(i).shells.x, player(i).shells.y)
        IF player(i).shells.shelltype <> 2 AND pix > 0 AND pix < 15 AND player(i).shells.tx > 2 THEN CALL detonate(i)
        pix = POINT(player(i).shells.x, player(i).shells.y)
        'fix this shit2
        IF player(i).shells.shelltype = 2 THEN
                IF pix = 14 THEN
                        player(i).shells.vy = ABS(player(i).shells.vy) * -1
                        IF ABS(player(i).shells.vy) < 10 THEN CALL detonate(i)
                END IF
                IF pix > 0 AND pix < 14 AND player(i).shells.tx > 2 THEN CALL detonate(i)
                arked = player(i).shells.vx / ABS(player(i).shells.vx)
                pix = POINT(player(i).shells.x + arked, player(i).shells.y)
                pix2 = POINT(player(i).shells.x + arked, player(i).shells.y - 3)
                'LOCATE 3, 2: PRINT pix, pix2
                IF pix = 14 AND pix2 = 14 THEN player(i).shells.vx = player(i).shells.vx * -1
                
        END IF
END IF
NEXT i
IF envir.inair = 1 THEN
        envir.tx = envir.tx + time
        envir.ty = envir.ty + time
        envir.vx = envir.vx + wind * envir.tx
        envir.vy = envir.vy + gravity * envir.ty
        envir.x = envir.oldx + envir.vx * time
        envir.y = envir.oldy + envir.vy * time
        IF envir.x > 639 THEN
                envir.tx = 1
                envir.x = 640
                envir.vx = player(i).shells.vx * -1
        END IF
        IF envir.x < 0 THEN
                envir.tx = 1
                envir.x = 0
                envir.vx = envir.vx * -1

        END IF
        IF envir.y >= 480 THEN envir.inair = 0
END IF
END SUB

SUB physics2
FOR i = 1 TO plrs
        player(i).phys.x = player(i).phys.x + player(i).phys.vx
        player(i).phys.y = player(i).phys.y + player(i).phys.vy
        IF player(i).phys.x <= 0 THEN
                player(i).phys.x = 0
                player(i).phys.vx = ABS(player(i).phys.vx)
        END IF
        IF player(i).phys.x >= 639 THEN
                player(i).phys.x = 639
                player(i).phys.vx = ABS(player(i).phys.vx) * -1
        END IF
        IF player(i).phys.y >= 479 THEN
                player(i).health = 0
        END IF
NEXT i
END SUB

SUB printing
FOR i = 1 TO plrs
vx = player(i).shells.vx
vy = player(i).shells.vy
oldvx = player(i).shells.oldvx
oldvy = player(i).shells.oldvy
IF player(i).shells.inair = 1 THEN
PSET (player(i).shells.oldx, player(i).shells.oldy), 0: DRAW "ta0c" + STR$(0) + "ta" + STR$((180 - ((oldvx + ABS(oldvx)) / (2 * ABS(oldvx)) * 180)) + INT(ATN((oldvy * -10) / (oldvx * 10)) / cvt)) + shelldraw$(1)
PSET (player(i).shells.x, player(i).shells.y), 15': DRAW "ta0c" + STR$(i) + "ta" + STR$((180 - ((oldvx + ABS(oldvx)) / (2 * ABS(oldvx)) * 180)) + INT(ATN((vy * -10) / (vx * 10)) / cvt)) + shelldraw$(1)
END IF
IF player(i).health >= 0 THEN PSET (player(i).phys.oldx, player(i).phys.oldy), 0: DRAW "ta0c" + STR$(0) + shelldraw$(2) + "ta" + STR$(player(i).oldangle) + turret$
IF player(i).health > 0 THEN PSET (player(i).phys.x, player(i).phys.y), 0: DRAW "ta0c" + STR$(i) + shelldraw$(2) + "ta" + STR$(player(i).angle) + turret$
IF player(i).health = 0 THEN player(i).health = -1
player(i).shells.oldx = player(i).shells.x
player(i).shells.oldy = player(i).shells.y
player(i).shells.oldvx = player(i).shells.vx
player(i).shells.oldvy = player(i).shells.vy
player(i).phys.oldx = player(i).phys.x
player(i).phys.oldy = player(i).phys.y
player(i).oldangle = player(i).angle
NEXT i
END SUB

SUB quick
CONST dangle = 45
CONST dpower = 200
CONST typo = 2
k$ = INKEY$
IF k$ = "p" THEN
        envir.shelltype = 2
        envir.vx = RND * 100
        envir.vy = RND * 100
        envir.oldvy = envir.vx
        envir.oldvy = envir.vy
        envir.oldx = 320
        envir.oldy = 0
        envir.inair = 1
        envir.tx = 1
        envir.ty = 1
END IF
IF k$ = "e" AND player(1).shells.inair = 0 THEN
        player(1).angle = dangle
        player(1).shells.shelltype = typo
        player(1).shells.vx = (COS(dangle * cvt) * dpower) / 10 + player(1).phys.vx
        player(1).shells.vy = (SIN(dangle * cvt) * dpower) / -10 + player(1).phys.vy
        player(1).shells.oldvx = player(1).shells.vx
        player(1).shells.oldvy = player(1).shells.vy
        player(1).shells.oldx = player(1).phys.x
        player(1).shells.oldy = player(1).phys.y
        player(1).shells.inair = 1
        player(1).shells.tx = 1
        player(1).shells.ty = 1
END IF
IF k$ = "w" AND player(1).shells.inair = 0 THEN
        player(1).angle = 180 - dangle
        player(1).shells.shelltype = typo
        player(1).shells.vx = (COS((89) * cvt) * dpower) / 10 + player(1).phys.vx
        player(1).shells.vy = (SIN((89 - dangle) * cvt) * dpower) / -10 + player(1).phys.vy
        player(1).shells.oldvx = player(1).shells.vx
        player(1).shells.oldvy = player(1).shells.vy
        player(1).shells.oldx = player(1).phys.x
        player(1).shells.oldy = player(1).phys.y
        player(1).shells.inair = 1
        player(1).shells.tx = 1
        player(1).shells.ty = 1
END IF
IF k$ = "q" AND player(1).shells.inair = 0 THEN
        player(1).angle = 89
        player(1).shells.shelltype = typo
        player(1).shells.vx = (COS((180 - dangle) * cvt) * dpower) / 10 + player(1).phys.vx
        player(1).shells.vy = dpower / -10 + player(1).phys.vy
        player(1).shells.oldvx = player(1).shells.vx
        player(1).shells.oldvy = player(1).shells.vy
        player(1).shells.oldx = player(1).phys.x
        player(1).shells.oldy = player(1).phys.y
        player(1).shells.inair = 1
        player(1).shells.tx = 1
        player(1).shells.ty = 1
END IF

IF k$ = "9" AND player(2).shells.inair = 0 THEN
        player(2).angle = dangle
        player(2).shells.shelltype = typo
        player(2).shells.vx = (COS(dangle * cvt) * dpower) / 10 + player(2).phys.vx
        player(2).shells.vy = (SIN(dangle * cvt) * dpower) / -10 + player(2).phys.vy
        player(2).shells.oldvx = player(2).shells.vx
        player(2).shells.oldvy = player(2).shells.vy
        player(2).shells.oldx = player(2).phys.x
        player(2).shells.oldy = player(2).phys.y
        player(2).shells.inair = 1
        player(2).shells.tx = 1
        player(2).shells.ty = 1
END IF
IF k$ = "8" AND player(2).shells.inair = 0 THEN
        player(2).angle = 89
        player(2).shells.shelltype = typo
        player(2).shells.vx = (COS((89) * cvt) * dpower) / 10 + player(2).phys.vx
        player(2).shells.vy = (SIN((89) * cvt) * dpower) / -10 + player(2).phys.vy
        player(2).shells.oldvx = player(2).shells.vx
        player(2).shells.oldvy = player(2).shells.vy
        player(2).shells.oldx = player(2).phys.x
        player(2).shells.oldy = player(2).phys.y
        player(2).shells.inair = 1
        player(2).shells.tx = 1
        player(2).shells.ty = 1
END IF

IF k$ = "7" AND player(2).shells.inair = 0 THEN
        player(2).angle = 180 - dangle
        player(2).shells.shelltype = typo
        player(2).shells.vx = (COS((180 - dangle) * cvt) * dpower) / 10 + player(2).phys.vx
        player(2).shells.vy = (SIN((180 - dangle) * cvt) * dpower) / -10 + player(2).phys.vy
        player(2).shells.oldvx = player(2).shells.vx
        player(2).shells.oldvy = player(2).shells.vy
        player(2).shells.oldx = player(2).phys.x
        player(2).shells.oldy = player(2).phys.y
        player(2).shells.inair = 1
        player(2).shells.tx = 1
        player(2).shells.ty = 1
END IF

IF k$ = "d" AND player(1).phys.inair = 0 THEN
        player(1).phys.vx = (COS(dangle * cvt) * dpower) / 10
        player(1).phys.vy = (SIN(dangle * cvt) * dpower) / -10
        player(1).phys.inair = 1
        player(1).phys.tx = 1
        player(1).phys.ty = 1
END IF
IF k$ = "s" THEN
        player(1).phys.vy = (SIN(dangle * cvt) * dpower) / -10
        player(1).phys.inair = 1
        player(1).phys.tx = 1
        player(1).phys.ty = 1
END IF

IF k$ = "6" AND player(2).phys.inair = 0 THEN
        player(2).phys.vx = (COS(dangle * cvt) * dpower) / 10
        player(2).phys.vy = (SIN(dangle * cvt) * dpower) / -10
        player(2).phys.inair = 1
        player(2).phys.tx = 1
        player(2).phys.ty = 1
END IF
IF k$ = "5" THEN
        player(2).phys.vy = (SIN(dangle * cvt) * dpower) / -10
        player(2).phys.inair = 1
        player(2).phys.tx = 1
        player(2).phys.ty = 1
END IF
IF k$ = "a" AND player(1).phys.inair = 0 THEN
        player(1).phys.vx = (COS((180 - dangle) * cvt) * dpower) / 10
        player(1).phys.vy = (SIN((180 - dangle) * cvt) * dpower) / -10
        player(1).phys.inair = 1
        player(1).phys.tx = 1
        player(1).phys.ty = 1
END IF
IF k$ = "4" AND player(2).phys.inair = 0 THEN
        player(2).phys.vx = (COS((180 - dangle) * cvt) * dpower) / 10
        player(2).phys.vy = (SIN((180 - dangle) * cvt) * dpower) / -10
        player(2).phys.inair = 1
        player(2).phys.tx = 1
        player(2).phys.ty = 1
END IF
END SUB

SUB terrain
gx1 = 0
DO UNTIL gx1 > 640
a = INT(RND * 5) + 1
b = INT(RND * 5) + 1
c = INT(RND * 5) + 1
d = INT(RND * 10) + 1
E = INT(RND * 380) + 100
f = INT(RND * 620) + gx1
FOR x = gx1 TO f
y = 10 * a * SIN(x / 100 * b) + (2 * c * COS(x / d)) + E
IF y < 80 THEN y = 80
IF x <= 640 THEN LINE (x, 480)-(x, y), 14
NEXT x
gx1 = x
LOOP
END SUB

SUB weaponfire
CONST maxpower = 600
IF player(currentplayer).health <= 0 THEN
        currentturn = currentturn + 1
        IF currentturn > plrs THEN currentturn = 1
        currentplayer = order(currentturn)
ELSEIF player(currentplayer).phys.inair = 0 THEN
LOCATE 1, 1: PRINT player(currentplayer).health; "  "; player(currentplayer).shellselect; " "; player(currentplayer).angle; "  "; player(currentplayer).power
k$ = INKEY$
IF k$ = CHR$(0) + "K" THEN player(currentplayer).angle = player(currentplayer).angle + 5
IF k$ = CHR$(0) + "M" THEN player(currentplayer).angle = player(currentplayer).angle - 5
IF player(currentplayer).angle > 359 THEN player(currentplayer).angle = 0
IF player(currentplayer).angle < 0 THEN player(currentplayer).angle = 359
IF k$ = CHR$(0) + "P" THEN player(currentplayer).power = player(currentplayer).power - 10
IF k$ = CHR$(0) + "H" THEN player(currentplayer).power = player(currentplayer).power + 10
IF player(currentplayer).power > maxpower THEN player(currentplayer).power = maxpower
IF player(currentplayer).power < 1 THEN player(currentplayer).power = 1
IF k$ = "1" THEN player(currentplayer).shellselect = 1
IF k$ = "2" THEN player(currentplayer).shellselect = 2
IF k$ = "3" THEN player(currentplayer).shellselect = 3
IF k$ = CHR$(13) AND player(currentplayer).shellselect <> 3 THEN
        'LOCATE 2, 1: PRINT "SWITCH DAMNIT!"
        'SLEEP 5
        player(currentplayer).shells.shelltype = player(currentplayer).shellselect
        player(currentplayer).shells.vx = (COS(player(currentplayer).angle * cvt) * player(currentplayer).power) / 10
        player(currentplayer).shells.vy = (SIN(player(currentplayer).angle * cvt) * player(currentplayer).power) / -10
        player(currentplayer).shells.oldvx = (COS(player(currentplayer).angle * cvt) * player(currentplayer).power) / 10
        player(currentplayer).shells.oldvy = (SIN(player(currentplayer).angle * cvt) * player(currentplayer).power) / -10
        player(currentplayer).shells.oldx = player(currentplayer).phys.x
        player(currentplayer).shells.oldy = player(currentplayer).phys.y
        player(currentplayer).shells.inair = 1
        player(currentplayer).shells.tx = 1
        player(currentplayer).shells.ty = 1
        currentturn = currentturn + 1
        ELSEIF k$ = CHR$(13) AND player(currentplayer).shellselect = 3 THEN
                'LOCATE 2, 1: PRINT "SWITCH DAMNIT!"
                'SLEEP 5
                player(currentplayer).phys.vx = (COS(player(currentplayer).angle * cvt) * player(currentplayer).power) / 10
                player(currentplayer).phys.vy = (SIN(player(currentplayer).angle * cvt) * player(currentplayer).power) / -10
                player(currentplayer).phys.inair = 1
                player(currentplayer).phys.tx = 1
                player(currentplayer).phys.ty = 1
                currentturn = currentturn + 1
        END IF
IF k$ = "b" THEN
                player(currentplayer).angle = INT(RND * 180 + 1)
                player(currentplayer).power = INT(RND * 10 + 1) * 25
                player(currentplayer).phys.vx = (COS(player(currentplayer).angle * cvt) * player(currentplayer).power) / 10
                player(currentplayer).phys.vy = (SIN(player(currentplayer).angle * cvt) * player(currentplayer).power) / -10
                player(currentplayer).phys.inair = 1
                player(currentplayer).phys.tx = 1
                player(currentplayer).phys.ty = 1
                currentturn = currentturn + 1
END IF
IF currentturn > plrs THEN currentturn = 1
currentplayer = order(currentturn)
k$ = ""
END IF
END SUB

