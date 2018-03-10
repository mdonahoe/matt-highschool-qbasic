CLS
FOR num1 = 10 TO 1200
IF num2 <> num1 THEN
LET total1 = 1
LET total2 = 1
LET y = 0
LET x = 0
FOR factor1 = 2 TO INT((num1 / 2) + 1)
IF num1 / factor1 = INT(num1 / factor1) AND (num1 / factor1) > factor1 THEN LET total1 = total1 + factor1 + (num1 / factor1)
IF y <> 1 AND num1 / factor1 = INT(num1 / factor1) AND (num1 / factor1) = factor1 THEN LET y = 1: LET total1 = total1 + factor1
NEXT factor1
FOR factor2 = 2 TO INT((total1 / 2) + 1)
IF total1 / factor2 = INT(total1 / factor2) AND (total1 / factor2) > factor2 THEN LET total2 = total2 + factor2 + (total1 / factor2)
IF x <> 1 AND (total1 / factor2) = INT(total1 / factor2) AND (total1 / factor2) = factor2 THEN LET x = 1: LET total2 = total2 + factor2
NEXT factor2
IF total2 = num1 AND total1 <> total2 THEN
PRINT ""
PRINT num1, total1
LET num2 = total1
'ELSE PRINT ".";
END IF
END IF
NEXT num1

