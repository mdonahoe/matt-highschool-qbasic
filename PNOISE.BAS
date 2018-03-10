DIM a(1 TO 1000)
nott$(1) = "A"
nott$(2) = "C"
nott$(3) = "F"
nott$(4) = "<"
nott$(5) = ">"
q = 5
FOR num = 1 TO 1000
x = 1
IF num / 2 = INT(num / 2) THEN x = 3
IF num / 2 = INT(num / 2) AND SQR(num) = INT(SQR(num)) THEN x = q: q = 9 - q
IF num / 2 <> INT(num / 2) THEN
FOR j = 3 TO INT(SQR(num)) STEP 2
IF num / j = INT(num / j) THEN x = 2
NEXT j
END IF
a(num) = x
NEXT num
CLS
PLAY "o3"
FOR i = 1 TO 50
PLAY "T32L64" + nott$(a(i))
PRINT i, nott$(a(i))
NEXT i

