SCREEN 12
car$ = "ta0r50d50l75u25e25"
person$ = "r5d8l5u8d8r2d10l3d20r6u20l3bd20"
leg1$ = "d10"
leg2$ = "m-1,9"
x = 0
FOR y = 480 TO 240 STEP -.5
x = x + .5

angle = angle + 2
IF angle > 180 THEN LET angle = 2
ang = angle
IF angle > 90 THEN LET ang = 180 - ang
'IF c < 14 THEN c = c + 1
'IF c = 14 THEN c = 2
c = 4
PSET (x, y), c: DRAW "ta-10" + person$ + "ta" + STR$(ang) + leg1$ + "ta" + STR$(-ang) + leg1$
PSET (x, y), c: DRAW "ta-10" + person$ + "ta" + STR$(90 - ang) + leg2$ + "ta" + STR$(-(90 - ang)) + leg2$
FOR hold = 1 TO 1000
NEXT hold
PSET (x, y), 0: DRAW "ta-10" + person$ + "ta" + STR$(ang) + leg1$ + "ta" + STR$(-ang) + leg1$
PSET (x, y), 0: DRAW "ta-10" + person$ + "ta" + STR$(90 - ang) + leg2$ + "ta" + STR$(-(90 - ang)) + leg2$
NEXT y
PSET (x, y), c: DRAW "ta-10" + person$ + "ta" + STR$(ang) + leg1$ + "ta" + STR$(-ang) + leg1$
PSET (x, y), c: DRAW "ta-10" + person$ + "ta" + STR$(90 - ang) + leg2$ + "ta" + STR$(-(90 - ang)) + leg2$
FOR x = 640 TO 0 STEP -2
PSET (x, 240), 2: DRAW car$
FOR hold = 1 TO 100
NEXT hold
PSET (x, 240), 0: DRAW car$
NEXT x
SCREEN 12
LINE (0, 0)-(639, 479), 14, B
PSET (320, 240), 15
FOR x = -100 TO 100 STEP .001
y = x * x
IF y < 480 AND y > -1 THEN
PSET (x + 320, -y + 240), 14
FOR i = 1 TO 100
NEXT i
PSET (x + 320, y + 240), 0
END IF
NEXT x

