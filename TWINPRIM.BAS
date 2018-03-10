CLS
FOR prime = 3 TO 1000
LET x = 0
LET y = 0
FOR a = 2 TO (INT(prime / 2) + 1)
IF x <> 1 AND prime / a = INT(prime / a) THEN LET x = 1
NEXT a
IF x <> 1 THEN
LET prime2 = prime + 2
FOR b = 2 TO (INT(prime2 / 2) + 1)
IF y <> 1 AND prime2 / b = INT(prime2 / b) THEN LET y = 1
NEXT b
'IF x <> 1 AND y <> 1 THEN PRINT prime; ","; prime2; ")";
IF y <> 1 AND prime >= 3 AND prime2 <= 100 THEN LET sum1 = sum1 + 1
IF y <> 1 AND prime >= 101 AND prime2 <= 200 THEN LET sum2 = sum2 + 1
IF y <> 1 AND prime >= 201 AND prime2 <= 300 THEN LET sum3 = sum3 + 1
IF y <> 1 AND prime >= 301 AND prime2 <= 400 THEN LET sum4 = sum4 + 1
IF y <> 1 AND prime >= 401 AND prime2 <= 500 THEN LET sum5 = sum5 + 1
IF y <> 1 AND prime >= 501 AND prime2 <= 600 THEN LET sum6 = sum6 + 1
IF y <> 1 AND prime >= 601 AND prime2 <= 700 THEN LET sum7 = sum7 + 1
IF y <> 1 AND prime >= 701 AND prime2 <= 800 THEN LET sum8 = sum8 + 1
IF y <> 1 AND prime >= 801 AND prime2 <= 900 THEN LET sum9 = sum9 + 1
IF y <> 1 AND prime >= 901 AND prime2 <= 1000 THEN LET sum0 = sum0 + 1
END IF
NEXT prime
PRINT ""
PRINT "3-100", "101-200", "201-300", "301-400", "401-500"
PRINT sum1, sum2, sum3, sum4, sum5
PRINT "501-600", "601-700", "701-800", "801-900", "901-1000"
PRINT sum6, sum7, sum8, sum9, sum0

