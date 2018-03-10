'Baseball Stats Calculator by the man...... Matt Donahoe
'This dumb probram calculates batting averages and slugging
'percentages, and then prints out a table sorted by any stat.
'The default is batting average and slugging percentage.
'varible definitions:
'
DECLARE SUB printer (n$(), a!(), t$(), x!, y!, z!, b!)
DECLARE SUB sorter (n$(), a!(), x!, y!, b!)
DECLARE SUB calc (a!(), y!)
CLS
DATA Name,at bats,hits,2B,3B,HR,b avg, slug%
DATA Mickey Mantle,Willie Mays,Roberto Clemente,Duke Snider, Hank Aaron, Harmon Killebrew
DATA 8102,2415,344,72,536,0,0
DATA 10881,3283,523,140,660,0,0
DATA 9454,3000,440,166,240,0,0
DATA 7161,2116,358,85,407,0,0
DATA 12364,3771,624,98,755,0,0
DATA 8147,2086,290,24,573,0,0
LET z = 8
LET y = 6
LET x = 7
DIM t$(z) 'title array
DIM n$(y) 'name array
DIM a(y, x) 'stats array

FOR i = 1 TO z
READ t$(i)      'reads in titles
NEXT i

FOR i = 1 TO y
READ n$(i)       'reads in names
NEXT i

FOR i = 1 TO y
FOR j = 1 TO x
READ a(i, j)     'reads in stats
NEXT j
NEXT i

CALL calc(a(), y)  'uh gee i dont remember what this does

FOR b = 6 TO 7
CALL sorter(n$(), a(), x, y, b)
CALL printer(n$(), a(), t$(), x, y, z, b + 1)
PRINT
NEXT b

END

SUB calc (a(), y)
FOR i = 1 TO y
LET a(i, 6) = a(i, 2) / a(i, 1) 'Batting Average

'Slugging percentage:
LET a(i, 7) = ((a(i, 2) - (a(i, 3) + a(i, 4) + a(i, 5))) + (2 * a(i, 3)) + (3 * a(i, 4)) + (4 * a(i, 5))) / a(i, 1)
'Cut off from above:  a(i, 4)) + (4 * a(i, 5))) / a(i, 1)
 
NEXT i
END SUB

SUB printer (n$(), a(), t$(), x, y, z, b)
LET title$ = "Sorted by " + t$(b)
PRINT TAB((80 - LEN(title$)) / 2); title$
FOR i = 1 TO 80
PRINT "_"; 'prints a line
NEXT i
PRINT
PRINT t$(1);
FOR t = 1 TO (17 - LEN(t$(1)))
PRINT " ";
NEXT t
FOR i = 2 TO z
PRINT t$(i);
FOR q = 1 TO 8 - LEN(t$(i))
PRINT " ";
NEXT q
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
IF a(i, j) >= 10000 AND a(i, j) < 100000 THEN PRINT " ";
IF a(i, j) >= 1000 AND a(i, j) < 10000 THEN PRINT "  ";
IF a(i, j) >= 100 AND a(i, j) < 1000 THEN PRINT "   ";
IF a(i, j) >= 10 AND a(i, j) < 100 THEN PRINT "    ";
IF a(i, j) >= 0 AND a(i, j) < 10 THEN PRINT "     ";
END IF
IF j = 6 OR j = 7 THEN
PRINT " ";
PRINT USING ".###"; a(i, j);
PRINT "   ";
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

