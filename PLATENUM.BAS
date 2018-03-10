CLS
LET num = 1500
DO UNTIL x = 1
PRINT num
LET sqr1 = 0
LET sqr2 = 0
LET sqr3 = 0
LET sqr4 = 0
LET num = num + 1
FOR sqr1 = 1 TO num
LET y = 0
LET z = 0
LET v = 0
LET w = 0
LET n = 0
DO UNTIL y = 1
LET n = n + 1
IF ((n * n) * n) = sqr1 AND INT(n) = n THEN LET y = 1: LET y1 = n
IF n > sqr1 THEN EXIT DO
LOOP
IF y = 1 THEN
LET sqr2 = num - sqr1
LET n = 0
DO UNTIL z = 1
LET n = n + 1
IF ((n * n) * n) = sqr2 AND INT(n) = n THEN LET z = 1: LET z1 = n
IF n > sqr2 THEN EXIT DO
LOOP
IF z = 1 THEN
FOR sqr3 = 1 TO num
LET v = 0
LET w = 0
IF sqr3 < num AND sqr3 <> sqr2 AND sqr3 <> sqr1 THEN
LET n = 0
DO UNTIL w = 1
LET n = n + 1
IF ((n * n) * n) = sqr3 THEN LET w = 1: LET w1 = n
IF n > sqr3 THEN EXIT DO
LOOP
IF w = 1 THEN
LET sqr4 = num - sqr3
LET n = 0
DO UNTIL v = 1
LET n = n + 1
IF ((n * n) * n) = sqr4 THEN LET v = 1: LET v1 = n
IF n > sqr4 THEN EXIT DO
LOOP
IF v = 1 THEN
LET x = 1
PRINT num, sqr1, sqr2, sqr3, sqr4
PRINT , y1, z1, w1, v1
EXIT DO
END IF
END IF
END IF
NEXT sqr3
END IF
END IF
NEXT sqr1
LOOP
PRINT done

