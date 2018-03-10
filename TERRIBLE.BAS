CLS
FOR num = 100 TO 999
LET h = INT(num / 100)
LET t = INT((num - (h * 100)) / 10) * 10
LET o = INT(num - ((h * 100) + t)) * 100
LET num2 = o + t + h
IF num2 > 100 AND num2 > num THEN
LET prod = num * num
IF prod < 99999 THEN
LET z = INT(prod / 10000)
LET y = INT((prod - (z * 10000)) / 1000) * 10
LET x = INT((prod - ((z * 10000) + (y * 100))) / 100) * 100
LET w = INT((prod - ((z * 10000) + (y * 100) + x)) / 10) * 1000
LET v = INT(prod - ((z * 10000) + (y * 100) + x + (w / 100))) * 10000
LET prod2 = v + w + x + y + z
IF prod2 = (num2 * num2) THEN PRINT num
END IF
IF prod < 999999 AND prod > 100000 THEN
LET z = INT(prod / 100000)
LET y = (INT((prod - (z * 100000)) / 10000)) * 10
LET x = (INT((prod - ((z * 100000) + (y * 1000))) / 1000)) * 100
LET w = (INT((prod - ((z * 100000) + (y * 1000) + (x * 10)))) / 100) * 1000
LET v = INT((prod - ((z * 100000) + (y * 1000) + (x * 10) + (w / 10))) / 10) * 10000
LET u = INT(prod - ((z * 100000) + (y * 1000) + (x * 10) + (w / 10) + (v / 1000))) * 100000
LET prod2 = u + v + w + x + y + z
IF prod2 = (num2 * num2) THEN PRINT num
END IF
END IF
NEXT num
END

