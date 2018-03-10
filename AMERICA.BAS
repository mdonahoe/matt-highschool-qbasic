DIM words$(14, 2)
DATA radio,wireless,elevator,lift,hood,bonnet,gasoline,petrol,truck,lorry,attic,loft,flashlight,torch
DATA french fries,chips,zero,naught,ice cream,ice,megaphone,loud hailer,sneakers,plimsolls,business suit,lounge suit,trunk,boot

TYPE trans
 eng AS STRING * 14
 amr AS STRING * 14
END TYPE
DIM word AS trans
OPEN "words.dat" FOR RANDOM AS #1 LEN = LEN(word)
FOR i = 1 TO 14
READ word.amr, word.eng
PUT #1, i, word
NEXT i
FOR i = 1 TO 14
GET #1, i, word
LET words$(i, 1) = word.amr
LET words$(i, 2) = word.eng
NEXT i

FOR i = 1 TO 13
FOR j = i + 1 TO 14
IF words$(i, 1) > words$(j, 1) THEN SWAP words$(i, 1), words$(j, 1): SWAP words$(i, 2), words$(j, 2)
NEXT j
NEXT i

FOR i = 1 TO 14
LET word.amr = words$(i, 1)
LET word.eng = words$(i, 2)
PUT #1, i, word
NEXT i
DO UNTIL amer$ = "quit"
INPUT "American word"; amer$
z = 0
LET low = 1
LET high = 14
DIM test AS trans
test.amr = amer$
DO UNTIL z > 0
mid = INT((high + low) / 2)
GET #1, mid, word
IF test.amr = word.amr THEN LET z = 1
IF low > high THEN PRINT "Word not found": z = 2
IF test.amr < word.amr THEN LET high = mid - 1
IF test.amr > word.amr THEN LET low = mid + 1
LOOP
IF z = 1 THEN
GET #1, mid, word.eng
PRINT word.eng
END IF
k$ = ""
DO UNTIL k$ = CHR$(13)
k$ = INKEY$
LOOP
LOOP

FOR i = 1 TO 14
FOR j = 1 TO 2
PRINT words$(i, j);
NEXT j
PRINT
NEXT i



CLOSE #1

