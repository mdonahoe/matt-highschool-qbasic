DECLARE SUB printer (hand2!(), title$())
DECLARE SUB shuffler (i!, hand2!(), hand!(), cards$())
DECLARE SUB scoring (straight!(), hand!(), value!)
SCREEN 0
DIM title$(13, 2)
CLS
DATA A,2,3,4,5,6,7,8,9,10,J,Q,K
DATA 46,5438,632946,23296369,2329636946,232963694349,23296369434946,2329636943493656,232963694349365646,23296369434926365666,23242526272829374757676665646353,2324252627282939495958575655545343336646,2434445464454637572868
FOR j = 1 TO 2
 FOR i = 1 TO 13
  READ title$(i, j)
 NEXT i
NEXT j
SLEEP 10
RANDOMIZE TIMER
DIM switcher(5)
DIM score(10)
DIM cards$(13)
DIM win$(10)
DIM hand(4, 13)
DIM hand2(5, 2)
DIM straight(13)
DATA Royal Flush,Straight Flush,Four of a Kind,Full House,Flush,Straight,Three of a Kind,Two Pair,Two of a Kind,Nothing!
DATA Ace,Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Jack,Queen,King
FOR i = 1 TO 10
 READ win$(i)
NEXT i
FOR i = 1 TO 13
 READ cards$(i)
NEXT i
k$ = ""
game = 0
DO UNTIL game = 32787
 game = game + 1
 k$ = INKEY$
 hand$ = ""
 FOR i = 1 TO 2
  FOR j = 1 TO 5
   hand2(j, i) = 0
   switcher(j) = 0
  NEXT j
 NEXT i
 FOR i = 1 TO 4
  FOR j = 1 TO 13
   hand(i, j) = 0
   straight(j) = 0
  NEXT j
 NEXT i
 COLOR 15, 0
 CLS
 FOR i = 1 TO 5
  CALL shuffler(i, hand2(), hand(), cards$())
 NEXT i
 CALL printer(hand2(), title$())
 k$ = ""
 i = 1
 DO UNTIL k$ = CHR$(13) OR i = 6
  k$ = INKEY$
  IF k$ <> "" AND k$ <> j$ AND VAL(k$) > 0 AND VAL(k$) < 6 THEN
   switcher(i) = VAL(k$)
   i = i + 1
   FOR k = 1 TO 11
    FOR j = 1 TO 7
     COLOR 0, 15
     LOCATE 10 + j, ((VAL(k$) - 1) * 15) + 5 + k: PRINT " "
    NEXT j
   NEXT k
  END IF
  j$ = k$
 LOOP
 k$ = ""
 FOR i = 1 TO 5
  IF switcher(i) > 0 THEN
   F = switcher(i)
   CALL shuffler(F, hand2(), hand(), cards$())
  END IF
 NEXT i
 CALL printer(hand2(), title$())
 value = 0
 CALL scoring(straight(), hand(), value)
 LOCATE 20, 35: PRINT " "; win$(value); " "
 LET score(value) = score(value) + 1
 SLEEP 10
LOOP
PRINT "# of games:"; game
FOR i = 1 TO 10
 PRINT score(i), win$(i)
NEXT i

SUB printer (hand2(), title$())
COLOR 0, 7
y = 10
x = 5
FOR cad = 1 TO 5
suit = hand2(cad, 1)
card = hand2(cad, 2)
FOR i = 1 TO 11
FOR j = 1 TO 7
LOCATE y + j, x + i: PRINT " "
NEXT j
NEXT i
IF suit > 2 THEN c = 0 ELSE c = 4
COLOR c, 15
LOCATE y + 1, x + 1: PRINT title$(card, 1)
IF card <> 10 THEN
LOCATE y + 7, x + 11: PRINT title$(card, 1)
ELSE LOCATE y + 7, x + 10: PRINT title$(card, 1)
END IF
FOR gram = 1 TO LEN(title$(card, 2)) / 2
LOCATE VAL(MID$(title$(card, 2), (2 * gram) - 1, 1)) + y, VAL(MID$(title$(card, 2), 2 * gram, 1)) + x: PRINT CHR$(suit + 2)
NEXT gram
x = x + 15
NEXT cad
END SUB

SUB scoring (straight(), hand(), value)
FOR suit = 1 TO 4
 'royal flush
 IF hand(suit, 10) = 1 AND hand(suit, 11) = 1 AND hand(suit, 12) = 1 AND hand(suit, 13) = 1 AND hand(suit, 1) = 1 THEN LET value = 1
 FOR i = 1 TO 9
  'straight flush
  IF hand(suit, i) = 1 AND hand(suit, i + 1) = 1 AND hand(suit, i + 2) = 1 AND hand(suit, i + 3) = 1 AND hand(suit, i + 4) = 1 THEN LET value = 2
 NEXT i
NEXT suit

'4 of a kind
IF value = 0 THEN
 FOR i = 1 TO 13
  IF hand(1, i) = 1 AND hand(2, i) = 1 AND hand(3, i) = 1 AND hand(4, i) = 1 THEN LET value = 3
 NEXT i
END IF

IF value = 0 THEN
'flush
FOR i = 1 TO 4
 flush = 0
 FOR j = 1 TO 13
  IF hand(i, j) = 1 THEN LET flush = flush + 1
  IF flush = 5 THEN LET value = 5
 NEXT j
NEXT i
END IF

IF value = 0 THEN
 'straight
 FOR i = 1 TO 4
  FOR j = 1 TO 13
   IF hand(i, j) = 1 THEN LET straight(j) = 1
  NEXT j
 NEXT i
 FOR i = 1 TO 9
  IF straight(i) = 1 AND straight(i + 1) = 1 AND straight(i + 2) = 1 AND straight(i + 3) = 1 AND straight(i + 4) = 1 THEN value = 6
 NEXT i
 IF straight(10) = 1 AND straight(11) = 1 AND straight(12) = 1 AND straight(13) = 1 AND straight(1) = 1 THEN value = 6
END IF

IF value = 0 THEN
 'full house
 house = 0
 FOR j = 1 TO 13
  full = 0
  FOR i = 1 TO 4
   IF hand(i, j) = 1 THEN LET full = full + 1
   IF full = 3 THEN LET house = j
  NEXT i
 NEXT j
 IF house > 0 THEN
  FOR j = 1 TO 13
   pair = 0
   FOR i = 1 TO 4
    IF j <> house AND hand(i, j) = 1 THEN LET pair = pair + 1
    IF pair = 2 THEN LET value = 4
   NEXT i
  NEXT j
 END IF
END IF

'2 pair
IF value = 0 THEN
FOR j = 1 TO 13
pair = 0
FOR i = 1 TO 4
IF hand(i, j) = 1 THEN LET pair = pair + 1
IF pair = 2 THEN LET pair2 = j
NEXT i
NEXT j
FOR j = 1 TO 13
pair = 0
FOR i = 1 TO 4
IF j <> pair2 AND hand(i, j) = 1 THEN LET pair = pair + 1
IF pair = 2 THEN LET value = 8
NEXT i
NEXT j
END IF

'3 of a kind
IF value = 0 THEN
FOR j = 1 TO 13
kind3 = 0
FOR i = 1 TO 4
IF hand(i, j) = 1 THEN LET kind3 = kind3 + 1
IF kind3 = 3 THEN LET value = 7
NEXT i
NEXT j
END IF

'2 of a kind
IF value = 0 THEN
FOR j = 1 TO 13
pair = 0
FOR i = 1 TO 4
IF hand(i, j) = 1 THEN LET pair = pair + 1
IF pair = 2 THEN LET value = 9
NEXT i
NEXT j
END IF

'nothing
IF value = 0 THEN LET value = 10

END SUB

SUB shuffler (i, hand2(), hand(), cards$())
IF hand2(i, 1) <> 0 AND hand2(i, 2) <> 0 THEN LET hand(hand2(i, 1), hand2(i, 2)) = 0
z = 0
DO UNTIL z = 1
LET suit = INT(RND * 4 + 1)
LET card = INT(RND * 13 + 1)
IF hand(suit, card) <> 1 THEN LET hand(suit, card) = 1: hand2(i, 1) = suit: hand2(i, 2) = card: z = 1
LOOP
END SUB

