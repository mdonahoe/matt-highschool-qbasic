CLS
PRINT "Total", "sailor 1", "sailor 2", "sailor 3"
FOR pile = 1 TO 1000
LET a = (2 / 3) * (pile - 1)
LET b = 0
LET c = 0
LET d = 0
IF a > 0 AND INT(a) = a THEN LET b = (2 / 3) * (a - 1)
IF b > 0 AND INT(b) = b THEN LET c = (2 / 3) * (b - 1)
IF c > 0 AND INT(c) = c THEN LET d = (1 / 3) * (c - 1)
IF d > 0 AND INT(d) = d THEN
PRINT pile, (a / 2) + 7, (b / 2) + 7, (c / 2) + 7
END
END IF
NEXT pile
PRINT "DONE"

