DIM a(10000)
DIM b(1000)
DIM c(1000)
SCREEN 12
h$ = "u100r20d100l20"
v$ = "u20r100d20l100"
bullet$ = "e30r80d60l80h30"
PSET (2, 378), 2: DRAW h$
PAINT (3, 377), 2, 2
GET (1, 276)-(23, 379), a(1)
PSET (529, 459), 10: DRAW v$
PAINT (530, 458), 10, 10
GET (528, 438)-(631, 460), b(1)
PSET (320, 240), 1: DRAW bullet$
PAINT (321, 240), 1, 1
GET (319, 209)-(399, 270), c(1)
CLS
FOR i = 0 TO 140
PUT (100, i), a(1), PSET
PUT (200, i), a(1), PSET
PUT (280, i), a(1), PSET
PUT (400, i), a(1), PSET
NEXT i

