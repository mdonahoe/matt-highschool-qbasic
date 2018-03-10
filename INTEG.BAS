CLS
FOR num = 0 TO 10000
IF num > 1000 AND num < 10000 THEN
LET a = INT(num / 1000)
LET b = (INT((num - (a * 1000)) / 100)) * 10
LET c = (INT((num - ((a * 1000) + (b * 10))) / 10)) * 100
LET d = (num - ((a * 1000) + (b * 10) + (c / 10))) * 1000
LET num2 = (d + c + b + a)
IF (num2 / num) = INT(num2 / num) AND (num2 / num) > 1 THEN PRINT num, num2
END IF
NEXT num
'END

CLS
FOR i = 1 TO 10
DATA -3,2,6,10,7,-5,3,8,9,-4
READ n
IF (n / 2) = INT(n / 2) THEN LET evensum = evensum + n: LET ecount = ecount + 1
IF (n / 2) = INT(n / 2) THEN LET oddsum = oddsum + n: LET ocount = ocount + 1
NEXT i
IF (evensum / ecount) > (oddsum / ocount) THEN PRINT "even"; (evensum / ecount)
IF (evensum / ecount) < (oddsum / ocount) THEN PRINT "odd"; (oddsum / ocount)
END

