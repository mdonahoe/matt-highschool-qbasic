CLS
PRINT TAB(27); "Welcome to Matt's Program"
INPUT "name"; name$
PRINT "Hello "; name$;
PRINT "please select waht you would like to do. 1=palindromes 2=spanish conjugator 3=END"
30 INPUT chc
IF chc = 1 THEN GOTO 10
IF chc = 2 THEN GOTO 20
IF chc = 3 THEN END
PRINT "invalid selection, please choose again"
GOTO 30
10 CLS
PRINT "Palindrome detector"
INPUT "suspected palindrome"; pal$
FOR num = 1 TO LEN(pal$)
LET a$ = MID$(pal$, num, 1)
IF NOT a$ = " " THEN LET pal2$ = pal2$ + a$
NEXT num
FOR num = 1 TO LEN(pal2$)
LET a$ = MID$(pal2$, num, 1)
LET pal3$ = pal3$ + a$
NEXT num
IF pal3$ = pal2$ THEN PRINT "it is a palindrome" ELSE PRINT "sorry, it is not a palindrome"
40 INPUT "run again, 1=yes 2=no"; chc
IF chc = 1 THEN GOTO 10
IF chc = 2 THEN GOTO 30
PRINT "invalid selection"
GOTO 40
20 CLS
PRINT "spanish conjugator"
50 INPUT "verb"; verb$
LET a$ = RIGHT$(verb$, 2)
LET habl$ = MID$(verb$, 1, (LEN(verb$) - 2))
IF a$ = "ar" THEN
LET yo$ = habl$ + "o"
LET tu$ = habl$ + "as"
LET el$ = habl$ + "a"
LET nosot$ = habl$ + "amos"
LET vosot$ = habl$ + "ais"
LET ellos$ = habl$ + "an"
PRINT "yo:  "; yo$, "nosotros:  "; nosot$
PRINT "tu:  "; tu$, "vosotros:  "; vosot$
PRINT "el:  "; el$, "ellos:  "; ellos$
END
END IF
IF a$ = "er" THEN
LET yo$ = habl$ + "o"
LET tu$ = habl$ + "es"
LET el$ = habl$ + "e"
LET nosot$ = habl$ + "emos"
LET vosot$ = habl$ + "eis"
LET ellos$ = habl$ + "en"
PRINT "yo:  "; yo$, "nosotros:  "; nosot$
PRINT "tu:  "; tu$, "vosotros:  "; vosot$
PRINT "el:  "; el$, "ellos:  "; ellos$
END
END IF
IF a$ = "ir" THEN
LET yo$ = habl$ + "o"
LET tu$ = habl$ + "es"
LET el$ = habl$ + "e"
LET nosot$ = habl$ + "imos"
LET vosot$ = habl$ + "is"
LET ellos$ = habl$ + "en"
PRINT "yo:  "; yo$, "nosotros:  "; nosot$
PRINT "tu:  "; tu$, "vosotros:  "; vosot$
PRINT "el:  "; el$, "ellos:  "; ellos$
END
END IF
PRINT "not a verb"
GOTO 50

