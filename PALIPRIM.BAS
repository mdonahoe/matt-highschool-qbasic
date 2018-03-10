CLS
FOR prime = 10 TO 999
LET x = 0
FOR a = 2 TO (INT(prime / 2) + 1)
IF x <> 1 AND prime / a = INT(prime / a) THEN LET x = 1
NEXT a
IF x <> 1 THEN
IF prime > 100 THEN
LET h = INT(prime / 100)
LET t = INT((prime - (h * 100)) / 10)
LET o = prime - ((h * 100) + (t * 10))
LET prime2 = (o * 100) + (t * 10) + h
FOR b = 2 TO (INT(prime2 / 2) + 1)
IF x <> 1 AND prime2 / b = INT(prime2 / b) THEN LET x = 1
NEXT b
IF x <> 1 AND prime2 >= prime THEN PRINT prime; ","; prime2; "||";
END IF
IF prime < 100 THEN
LET t = INT(prime / 10)
LET o = prime - (t * 10)
LET prime2 = (o * 10) + t
FOR c = 2 TO (INT(prime / 2) + 1)
IF x <> 1 AND prime2 / c = INT(prime2 / c) THEN LET x = 1
NEXT c
IF x <> 1 AND prime2 >= prime THEN PRINT prime; ","; prime2; "||";
END IF
END IF
NEXT prime

