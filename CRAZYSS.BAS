DECLARE SUB physics ()
DECLARE SUB detonate (i!)
DECLARE SUB printing ()

DECLARE SUB weaponfire ()
SCREEN 12
TYPE Object
x AS SINGLE
y AS SINGLE
vx AS SINGLE
vy AS SINGLE
tx AS SINGLE
ty AS SINGLE
oldx AS SINGLE
oldy AS SINGLE
inair AS INTEGER
shelltype AS INTEGER
END TYPE
maxplayers = 20
TYPE Tank
health AS INTEGER
phys AS Object
angle AS INTEGER
power AS INTEGER
title AS STRING * 9
shells AS Object
shellselect AS INTEGER
score AS INTEGER
END TYPE
DIM SHARED player(1 TO maxplayers) AS Tank
DIM SHARED order(1 TO maxplayers)
DIM SHARED currentplayer AS INTEGER
DIM SHARED currentturn AS INTEGER
DIM SHARED plrs
DIM SHARED shelldraw$(1 TO 9)
shelldraw$(1) = "bh2r4d4l4u4"
INPUT plrs
FOR i = 1 TO plrs
order(i) = i
player(i).phys.x = 320
player(i).phys.y = 200
player(i).phys.oldx = 320
player(i).phys.oldy = 200
NEXT i
currentturn = 1
currentplayer = order(currentturn)
FOR i = 0 TO 640
LINE (i, 480)-(i, 460), 14
NEXT i
DO
CALL weaponfire

CALL physics

CALL printing

LOOP

SUB detonate (i)
SELECT CASE player(i).shells.shelltype
        CASE 1
        FOR r = 1 TO 50
        IF r < 30 THEN CIRCLE (player(i).shells.x, player(i).shells.y), r, 4
        IF r > 20 THEN CIRCLE (player(i).shells.x, player(i).shells.y), r - 20, 0
        NEXT r
END SELECT
END SUB

SUB physics
'PRINT 1
time = .05
wind = 0
gravity = .01
FOR i = 1 TO plrs
IF POINT(player(i).phys.x, player(i).phys.y + 5) = 0 THEN player(i).phys.inair = 1
IF player(i).phys.inair = 1 THEN
        LOCATE 2, 2: PRINT player(i).phys.tx
        player(i).phys.tx = player(i).phys.tx + time
        player(i).phys.ty = player(i).phys.ty + time
        player(i).phys.vx = player(i).phys.vx + wind * player(i).phys.tx
        player(i).phys.vy = player(i).phys.vy + gravity * player(i).phys.ty
        player(i).phys.x = player(i).phys.oldx + player(i).phys.vx * time
        player(i).phys.y = player(i).phys.oldy + player(i).phys.vy * time
        IF POINT(player(i).phys.x, player(i).phys.y + 5) > 2 AND player(i).phys.tx > 2 THEN
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
        IF POINT(player(i).shells.x, player(i).shells.y) > 3 THEN
        player(i).shells.inair = 0
        CALL detonate(i)
        END IF
END IF
NEXT i
END SUB

SUB printing
i = 1
PSET (player(i).phys.oldx, player(i).phys.oldy), 0: DRAW "c" + STR$(0) + shelldraw$(1)
PSET (player(i).shells.oldx, player(i).shells.oldy), 0: DRAW "c" + STR$(0) + shelldraw$(1)

PSET (player(i).phys.x, player(i).phys.y), 0: DRAW "c" + STR$(i) + shelldraw$(1)
PSET (player(i).shells.x, player(i).shells.y), 0: DRAW "c" + STR$(i) + shelldraw$(1)
player(i).phys.oldx = player(i).phys.x
player(i).phys.oldy = player(i).phys.y
END SUB

SUB weaponfire
LOCATE 1, 1: PRINT player(currentplayer).shellselect; " "; player(currentplayer).angle; "  "; player(currentplayer).power
k$ = INKEY$
IF k$ = CHR$(0) + "H" THEN player(currentplayer).angle = player(currentplayer).angle + 2
IF k$ = CHR$(0) + "P" THEN player(currentplayer).angle = player(currentplayer).angle - 2
IF k$ = CHR$(0) + "K" THEN player(currentplayer).power = player(currentplayer).power - 5
IF k$ = CHR$(0) + "M" THEN player(currentplayer).power = player(currentplayer).power + 5
IF k$ = "1" THEN player(currentplayer).shellselect = 1
IF k$ = "2" THEN player(currentplayer).shellselect = 2
IF k$ = CHR$(13) AND player(currentplayer).shellselect <> 2 THEN
        player(currentplayer).shells.shelltype = player(currentplayer).shellselect
        player(currentplayer).shells.vx = (COS(player(currentplayer).angle) * player(currentplayer).power) * 500
        player(currentplayer).shells.vy = (SIN(player(currentplayer).angle) * player(currentplayer).power) * 500
        player(currentplayer).shells.oldx = player(currentplayer).phys.x
        player(currentplayer).shells.oldy = player(currentplayer).phys.y
        player(currentplayer).shells.inair = 1
        currentturn = currentturn + 1
        ELSEIF k$ = CHR$(13) AND player(currentplayer).shellselect = 2 THEN
                player(currentplayer).phys.vx = (COS(player(currentplayer).angle) * player(currentplayer).power) / 500
                player(currentplayer).phys.vy = (SIN(player(currentplayer).angle) * player(currentplayer).power) / 500
                player(currentplayer).phys.inair = 1
                currentturn = currentturn + 1
        END IF
IF currentturn > plrs THEN currentturn = 1
currentplayer = order(currentturn)
k$ = ""
END SUB

