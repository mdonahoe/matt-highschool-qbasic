DECLARE SUB boxes (box$, i!, c!, by!(), b!())
SCREEN 12
DIM by(20)
DIM b(20)
FOR i = 1 TO 20
b(i) = 5
NEXT i
box$ = "bu3l5dr10dl10dr10"
boy$ = "bu5l5d10r10u10l5"
a = 1
RANDOMIZE TIMER
DO UNTIL z = 1
k$ = INKEY$
IF k$ = "a" THEN a = -a
x = x + ((ABS(a) + a) / 2)
x1 = x
PSET (x, 240), 0: DRAW "c1" + boy$
FOR i = 1 TO 20
CALL boxes(box$, i, 1, by(), b())
NEXT i
IF POINT(x, 240) = 4 THEN x1 = 0
FOR i = 1 TO 100: NEXT i
FOR i = 1 TO 20
CALL boxes(box$, i, 0, by(), b())
NEXT i
PSET (x, 240), 0: DRAW "c0" + boy$
x = x1
LOOP

SUB boxes (box$, i, c, by(), b())
by(i) = by(i) + b(i) * c
IF by(i) < 0 THEN by(i) = 0: b(i) = INT(RND * 5 + 1)
IF by(i) > 480 THEN by(i) = 480: b(i) = INT(RND * -5 - 1)
PSET (i * 30, by(i)), 0: DRAW "c" + STR$(c * 4) + box$
END SUB

