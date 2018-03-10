SCREEN 12
DIM SHARED board(8, 8)
DIM SHARED piece(16, 2, 2)
piece(1, 1, 1) = 3
piece(2, 1, 1) = 4
piece(3, 1, 1) = 2
piece(4, 1, 1) = 5
piece(5, 1, 1) = 1
piece(6, 1, 1) = 6
piece(7, 1, 1) = 0
piece(8, 1, 1) = 7
piece(9, 1, 1) = 0
piece(10, 1, 1) = 1
piece(11, 1, 1) = 2
piece(12, 1, 1) = 3
piece(13, 1, 1) = 4
piece(14, 1, 1) = 5
piece(15, 1, 1) = 6
piece(16, 1, 1) = 7
piece(1, 1, 2) = 0
piece(2, 1, 2) = 0
piece(3, 1, 2) = 0
piece(4, 1, 2) = 0
piece(5, 1, 2) = 0
piece(6, 1, 2) = 0
piece(7, 1, 2) = 0
piece(8, 1, 2) = 0
piece(9, 1, 2) = 1
piece(10, 1, 2) = 1
piece(11, 1, 2) = 1
piece(12, 1, 2) = 1
piece(13, 1, 2) = 1
piece(14, 1, 2) = 1
piece(15, 1, 2) = 1
piece(16, 1, 2) = 1
piece(1, 2, 1) = 3
piece(2, 2, 1) = 4
piece(3, 2, 1) = 2
piece(4, 2, 1) = 5
piece(5, 2, 1) = 1
piece(6, 2, 1) = 6
piece(7, 2, 1) = 0
piece(8, 2, 1) = 7
piece(9, 2, 1) = 0
piece(10, 2, 1) = 1
piece(11, 2, 1) = 2
piece(12, 2, 1) = 3
piece(13, 2, 1) = 4
piece(14, 2, 1) = 5
piece(15, 2, 1) = 6
piece(16, 2, 1) = 7
piece(1, 2, 2) = 7
piece(2, 2, 2) = 7
piece(3, 2, 2) = 7
piece(4, 2, 2) = 7
piece(5, 2, 2) = 7
piece(6, 2, 2) = 7
piece(7, 2, 2) = 7
piece(8, 2, 2) = 7
piece(9, 2, 2) = 6
piece(10, 2, 2) = 6
piece(11, 2, 2) = 6
piece(12, 2, 2) = 6
piece(13, 2, 2) = 6
piece(14, 2, 2) = 6
piece(15, 2, 2) = 6
piece(16, 2, 2) = 6
board(0, 0) = 4
board(0, 1) = 2
board(0, 2) = 3
board(0, 3) = 6
board(0, 4) = 5
board(0, 5) = 3
board(0, 6) = 2
board(0, 7) = 4
board(1, 0) = 1
board(1, 1) = 1
board(1, 2) = 1
board(1, 3) = 1
board(1, 4) = 1
board(1, 5) = 1
board(1, 6) = 1
board(1, 7) = 1
board(7, 0) = -4
board(7, 1) = -2
board(7, 2) = -3
board(7, 3) = -6
board(7, 4) = -5
board(7, 5) = -3
board(7, 6) = -2
board(7, 7) = -4
board(6, 0) = -1
board(6, 1) = -1
board(6, 2) = -1
board(6, 3) = -1
board(6, 4) = -1
board(6, 5) = -1
board(6, 6) = -1
board(6, 7) = -1
pawn$ = "bd40br15u20r5u10r10d10r5d20l20"
knight$ = "bd42br5m+20,-5u20l20u5m+20,-5r5u5r5d35f10l40u5"
bishop$ = "bd45br5m+20,-40m+20,+40l40"
rook$ = "bd45br7u5r5u20h5u5r5d3r3u3r3d3r3u3r3d3r3u3r3d3r3u3r3d3r3u3r5d5g5d20r5d5l37"
queen$ = "bd45br13u5e5u20h3u5f3e3f3e3f3e3d5g3d20f5d5l22"
king$ = "bd45br10e10u10l10u10r10u10r10d10r10d10l10d10f10l30"
DIM SHARED peace$(6)
peace$(1) = pawn$
peace$(2) = knight$
peace$(3) = bishop$
peace$(4) = rook$
peace$(5) = queen$
peace$(6) = king$
scroll = 1
plr = 1
pt = 1
DIM x(2)
DIM y(2)
the = 1
DO
LOCATE 1, 70: PRINT k$
IF k$ = " " THEN the = 3 - the
'IF scroll > 16 THEN scroll = 1
IF k$ = CHR$(0) + "K" THEN x(the) = x(the) - 1
IF x(the) < 0 THEN x(the) = 0
IF k$ = CHR$(0) + "M" THEN x(the) = x(the) + 1
IF x(the) > 7 THEN x(the) = 7
IF k$ = CHR$(0) + "H" THEN y(the) = y(the) - 1
IF y(the) < 0 THEN y(the) = 0
IF k$ = CHR$(0) + "P" THEN y(the) = y(the) + 1
IF y(the) > 7 THEN y(the) = 7
IF k$ = CHR$(13) THEN
FOR tempi = 0 TO 7
FOR tempj = 0 TO 7
tempboard(tempi, tempj) = board(tempi, tempj)
NEXT tempj
NEXT tempi
board(y(2), x(2)) = board(y(1), x(1))
board(y(1), x(1)) = 0
pt = 3 - pt
END IF
IF k$ = "u" THEN
FOR tempi = 0 TO 7
FOR tempj = 0 TO 7
board(tempi, tempj) = tempboard(tempi, tempj)
NEXT tempj
NEXT tempi
pt = 3 - pt
END IF
FOR i = 0 TO 7
FOR j = 0 TO 7
LINE (j * 50, i * 50)-((j + 1) * 50, (i + 1) * 50), (1 - ABS(((j MOD 2) - (i MOD 2)))) * 15, BF
IF board(i, j) <> 0 THEN
plr = (board(i, j) / ABS(board(i, j)) - 1) / -2 + 1
PSET (j * 50, i * 50), plr: DRAW peace$(ABS(board(i, j))): PAINT (j * 50 + 27, i * 50 + 25), 3 - plr, plr
END IF
NEXT j
NEXT i
LINE (0, 0)-(400, 400), 4, B
FOR qaz = 0 TO 4
LINE (x(2) * 50 + qaz, y(2) * 50 + qaz)-((x(2) + 1) * 50 - qaz, (y(2) + 1) * 50 - qaz), 4, B
LINE (x(1) * 50 + qaz, y(1) * 50 + qaz)-((x(1) + 1) * 50 - qaz, (y(1) + 1) * 50 - qaz), 3, B
NEXT qaz
k$ = ""
LOCATE 26, 1: PRINT "PLAYER"; pt
DO WHILE k$ = ""
k$ = INKEY$
LOOP
LOOP

