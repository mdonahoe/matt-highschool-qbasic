DECLARE SUB printer (num!)
SCREEN 12
CLS
RANDOMIZE TIMER

DO
in = 0
oot = 0
area2# = 0
area1# = 0
INPUT num
CALL printer(num)
'monte carlo
FOR i = 1 TO num
x1 = RND
y1 = RND
y2 = SQR(1 - (x1 * x1))
IF y1 <= y2 THEN LET in = in + 1: PSET (80 + (x1 * 480), 480 - (y1 * 480)), 4:  ELSE LET oot = oot + 1: PSET (80 + (x1 * 480), 480 - (y1 * 480)), 1
NEXT i
LET monte# = in / (in + oot)
'rect
LET rectnum = 1 / num
FOR i = 0 TO 1 - rectnum STEP rectnum
area1# = area1# + (rectnum * (SQR(1 - (i * i))))
LINE (80 + (i * 480), 480)-(80 + (i * 480), 480 - (480 * (SQR(1 - ((i * i))))))
LINE (80 + (i * 480), 480 - (480 * (SQR(1 - ((i * i))))))-(80 + (480 * (i + rectnum)), 480 - (480 * (SQR(1 - ((i * i))))))
LINE (80 + (480 * (i + rectnum)), 480 - (480 * (SQR(1 - ((i) * (i))))))-(80 + (480 * (i + rectnum)), 480)
'LOCATE 1, 1: PRINT area1# * 4
'area2# = area2# + (rectnum * (((SQR(1 - (i * i)))) + (SQR(1 - (i * i)))) / 2)
NEXT i
SLEEP 10
FOR i = 0 TO 1 - rectnum STEP rectnum
'area1# = area1# + (rectnum * (SQR(1 - ((i* i)))))
'LOCATE 1, 1: PRINT area1# * 4
area2# = area2# + (rectnum * (((SQR(1 - (i * i)))) + (SQR(1 - ((i + rectnum) * (i + rectnum))))) / 2)
COLOR 2
LINE (80 + (i * 480), 480)-(80 + (i * 480), 480 - (480 * (SQR(1 - ((i * i))))))
LINE (80 + ((i) * 480), 480 - (480 * (SQR(1 - ((i * i))))))-(80 + (480 * (i + rectnum)), 480 - (480 * (SQR(1 - ((i + rectnum) * (i + rectnum))))))
LINE (80 + (480 * (i + rectnum)), 480 - (480 * (SQR(1 - ((i + rectnum) * (i + rectnum))))))-(80 + (480 * (i + rectnum)), 480)
NEXT i
COLOR 15
PRINT monte# * 4
PRINT area1# * 4
PRINT area2# * 4
LOOP

SUB printer (num)
CLS
FOR i = 0 TO 1 STEP .0001
x = i
y = SQR(1 - (x * x))
PSET (80 + (x * 480), 480 - (y * 480)), 14
NEXT i
END SUB

