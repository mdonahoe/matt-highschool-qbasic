poop$ = "NONE"
poop = 0
OPEN "tankwars.dat" FOR OUTPUT AS #1
FOR i = 1 TO 10
WRITE #1, poop, poop$
NEXT i
CLOSE #1

SUB calc (a(), y)
FOR i = 1 TO y
LET a(i, 6) = a(i, 2) / a(i, 1)
LET a(i, 7) = ((a(i, 2) - (a(i, 3) + a(i, 4) + a(i, 5))) + (2 * a(i, 3)) + (3 * a(i, 4)) + (4 * a(i, 5))) / a(i, 1)
NEXT i
END SUB

SUB printer (n$(), a(), t$(), x, y, z, b)
LET title$ = "Sorted by " + t$(b)
PRINT
PRINT TAB((80 - LEN(title$)) / 2); title$
FOR i = 1 TO 80
PRINT "_";
NEXT i
PRINT
PRINT t$(1);
FOR t = 1 TO (17 - LEN(t$(1)))
PRINT " ";
NEXT t
FOR i = 2 TO z
PRINT t$(i); "  ";
FOR j = 1 TO 6 - (LEN(t$(i)))
PRINT " ";
NEXT j
NEXT i
PRINT
FOR i = 1 TO y
PRINT n$(i);
FOR t = 1 TO (16 - LEN(n$(i)))
PRINT " ";
NEXT t
FOR j = 1 TO x
IF j <> 6 AND j <> 7 THEN
PRINT a(i, j);
IF a(i, j) > 10000 AND a(i, j) < 100000 THEN PRINT " ";
IF a(i, j) > 1000 AND a(i, j) < 10000 THEN PRINT "  ";
IF a(i, j) > 100 AND a(i, j) < 1000 THEN PRINT "   ";
IF a(i, j) > 10 AND a(i, j) < 100 THEN PRINT "    ";
IF a(i, j) > 1 AND a(i, j) < 10 THEN PRINT "     ";
ELSE PRINT " "; : PRINT USING ".###"; a(i, j); : PRINT "   ";
END IF
NEXT j
PRINT
NEXT i
END SUB

SUB sorter (n$(), a(), x, y, b)
FOR i = 1 TO y - 1
FOR j = i + 1 TO y
IF a(i, b) < a(j, b) THEN
SWAP n$(i), n$(j)
FOR k = 1 TO x
SWAP a(i, k), a(j, k)
NEXT k
END IF
NEXT j
NEXT i
END SUB

