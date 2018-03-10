CLS
SCREEN 12
DIM a(1 TO 10000)
DIM qaz$(1 TO 5)
qaz$(1) = "<l12AGE"
qaz$(2) = "CAB"
qaz$(3) = "FED>"
qaz$(4) = "<l6"
qaz$(5) = "<BEG"
FOR num = 1 TO 10000
x = 1
IF num / 2 = INT(num / 2) THEN
x = 2
ELSE
j = 3
DO UNTIL j > INT(SQR(num)) OR j = 0
IF num / j = INT(num / j) THEN x = 3: j = 0
j = j + 2
LOOP
END IF
IF SQR(num) = INT(SQR(num)) THEN x = 4
hun = INT(num / 100)
ten = INT((num - hun * 100) / 10)
one = num - hun * 100 - ten * 10
qwe = hun + ten + one
'IF qwe = 5 THEN x = 5
a(num) = x
NEXT num
PLAY "T200O4L12"
FOR i = 1 TO 10000
'IF a(i) = 4 THEN PRINT c; : c = 0
'IF a(i) = 1 THEN c = c + 1
COLOR 5 - a(i)
PRINT i;
PLAY qaz$(a(i))
NEXT i

