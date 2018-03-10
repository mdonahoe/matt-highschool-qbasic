CLS
OPEN "p:\crypto.txt" FOR INPUT AS #1

INPUT #1, quote$
CLOSE #1
cipher$ = "                           "
alpha$ = " ABCDEFGHIJKLMNOPQRSTUVWXYZ"
'INPUT "quote"; quote$
CLS
DO
FOR i = 1 TO LEN(quote$)
FOR j = 1 TO LEN(alpha$)
n = INT(i / 81) * 2 + 1
IF MID$(quote$, i, 1) = MID$(alpha$, j, 1) THEN
'PRINT i
'PRINT i - INT(i / 81) * 81
'FOR HOLD = 1 TO 10000: NEXT HOLD
'LOCATE 1, 80: PRINT "a"
LOCATE n, (i - INT(i / 81) * 80): COLOR 15: PRINT MID$(alpha$, j, 1)
LOCATE n + 1, i - INT(i / 81) * 80: COLOR 10: PRINT MID$(cipher$, j, 1)
END IF
NEXT j
NEXT i
INPUT "swap"; A$
INPUT "with"; B$
FOR j = 1 TO LEN(alpha$)
IF A$ = MID$(alpha$, j, 1) THEN
cipher$ = MID$(cipher$, 1, j - 1) + B$ + MID$(cipher$, j + 1, LEN(cipher$) - j)
END IF
NEXT j
CLS
LOOP

