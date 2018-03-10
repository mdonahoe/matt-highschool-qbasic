  LOCATE 12, 33: PRINT "by matt donahoe"
  LOCATE 15, 35: PRINT "Tank Wars"
  LOCATE 18, 35: PRINT "Pacman"
  LOCATE 21, 35: PRINT "Worm Tunnel"
  LOCATE 24, 35: PRINT "Exit"
  LET m = 15
  k$ = ""
  PSET (268, (16 * m) - 8), 0: DRAW "c4" + arrow$
  CALL hold(10)
  DO UNTIL k$ = CHR$(13)
   LET k$ = INKEY$
   IF k$ = CHR$(0) + "P" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + arrow$
    IF m < 24 THEN LET m = m + 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + arrow$
   END IF
   IF k$ = CHR$(0) + "H" THEN
    PSET (268, (16 * m) - 8), 0: DRAW "c0" + arrow$
    IF m > 15 THEN LET m = m - 3
    PSET (268, (16 * m) - 8), 0: DRAW "c4" + arrow$
   END IF
  LOOP
  FOR x = 268 TO 640
   PSET (x, (16 * m) - 8), 0: DRAW "c4" + arrow$
   CALL hold(10)
   PSET (x, (16 * m) - 8), 0: DRAW "c0" + arrow$
  NEXT x
  IF m = 15 THEN z = 1
  IF m = 18 THEN z = 2
  IF m = 21 THEN z = 3
  IF m = 24 THEN END

