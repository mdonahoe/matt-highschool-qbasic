CLS
0 INPUT "Encryption or decryption? 1 or 2: "; chc
IF chc = 1 THEN GOTO 1
IF chc = 2 THEN GOTO 2
PRINT "invalid"
GOTO 0
1 PRINT "Matt's Custom Encryption!"
PRINT "if you want to enter a custom encryption then press 0", "otherwise press the number of the desired key code."
PRINT "1: BCDEFGHIJKLMNOPQRSTUVWXYZA"
PRINT "2: THEQUICKBROWNFXJMPSVLAZYDG"
PRINT "3: QWERTYUIOPASDFGHJKLZXCVBNM"
INPUT n
IF n = 0 THEN GOTO 9
IF n = 1 THEN GOTO 10
IF n = 2 THEN GOTO 20
IF n = 3 THEN GOTO 30
PRINT "invalid choice"
GOTO 1
9 INPUT "key code"; keycode$
IF LEN(keycode$) <> 26 THEN PRINT "invalid": GOTO 9
GOTO 3
10 LET keycode$ = "bcdefghijklmnopqrstuvwxyza"
GOTO 3
20 LET keycode$ = "thequickbrownfxjmpsvlazydg"
GOTO 3
30 LET keycode$ = "qwertyuiopasdfghjklzxcvbnm"
3 INPUT "text"; text$
LET a$ = MID$(keycode$, 1, 1)
LET b$ = MID$(keycode$, 2, 1)
LET c$ = MID$(keycode$, 3, 1)
LET d$ = MID$(keycode$, 4, 1)
LET e$ = MID$(keycode$, 5, 1)
LET f$ = MID$(keycode$, 6, 1)
LET g$ = MID$(keycode$, 7, 1)
LET h$ = MID$(keycode$, 8, 1)
LET i$ = MID$(keycode$, 9, 1)
LET j$ = MID$(keycode$, 10, 1)
LET k$ = MID$(keycode$, 11, 1)
LET l$ = MID$(keycode$, 12, 1)
LET m$ = MID$(keycode$, 13, 1)
LET n$ = MID$(keycode$, 14, 1)
LET o$ = MID$(keycode$, 15, 1)
LET p$ = MID$(keycode$, 16, 1)
LET q$ = MID$(keycode$, 17, 1)
LET r$ = MID$(keycode$, 18, 1)
LET s$ = MID$(keycode$, 19, 1)
LET t$ = MID$(keycode$, 20, 1)
LET u$ = MID$(keycode$, 21, 1)
LET v$ = MID$(keycode$, 22, 1)
LET w$ = MID$(keycode$, 23, 1)
LET x$ = MID$(keycode$, 24, 1)
LET y$ = MID$(keycode$, 25, 1)
LET z$ = MID$(keycode$, 26, 1)
LET codetext$ = ""
FOR num = 1 TO LEN(text$)
IF MID$(text$, num, 1) = "a" THEN LET codetext$ = codetext$ + a$
IF MID$(text$, num, 1) = "b" THEN LET codetext$ = codetext$ + b$
IF MID$(text$, num, 1) = "c" THEN LET codetext$ = codetext$ + c$
IF MID$(text$, num, 1) = "d" THEN LET codetext$ = codetext$ + d$
IF MID$(text$, num, 1) = "e" THEN LET codetext$ = codetext$ + e$
IF MID$(text$, num, 1) = "f" THEN LET codetext$ = codetext$ + f$
IF MID$(text$, num, 1) = "g" THEN LET codetext$ = codetext$ + g$
IF MID$(text$, num, 1) = "h" THEN LET codetext$ = codetext$ + h$
IF MID$(text$, num, 1) = "i" THEN LET codetext$ = codetext$ + i$
IF MID$(text$, num, 1) = "j" THEN LET codetext$ = codetext$ + j$
IF MID$(text$, num, 1) = "k" THEN LET codetext$ = codetext$ + k$
IF MID$(text$, num, 1) = "l" THEN LET codetext$ = codetext$ + l$
IF MID$(text$, num, 1) = "m" THEN LET codetext$ = codetext$ + m$
IF MID$(text$, num, 1) = "n" THEN LET codetext$ = codetext$ + n$
IF MID$(text$, num, 1) = "o" THEN LET codetext$ = codetext$ + o$
IF MID$(text$, num, 1) = "p" THEN LET codetext$ = codetext$ + p$
IF MID$(text$, num, 1) = "q" THEN LET codetext$ = codetext$ + q$
IF MID$(text$, num, 1) = "r" THEN LET codetext$ = codetext$ + r$
IF MID$(text$, num, 1) = "s" THEN LET codetext$ = codetext$ + s$
IF MID$(text$, num, 1) = "t" THEN LET codetext$ = codetext$ + t$
IF MID$(text$, num, 1) = "u" THEN LET codetext$ = codetext$ + u$
IF MID$(text$, num, 1) = "v" THEN LET codetext$ = codetext$ + v$
IF MID$(text$, num, 1) = "w" THEN LET codetext$ = codetext$ + w$
IF MID$(text$, num, 1) = "x" THEN LET codetext$ = codetext$ + x$
IF MID$(text$, num, 1) = "y" THEN LET codetext$ = codetext$ + y$
IF MID$(text$, num, 1) = "z" THEN LET codetext$ = codetext$ + z$
IF MID$(text$, num, 1) = " " THEN LET codetext$ = codetext$ + " "
NEXT num
PRINT " "
PRINT codetext$
4 INPUT "AGAIN? (y/n)"; again$
IF again$ = "y" THEN GOTO 0
IF again$ = "n" THEN END
PRINT "invalid"
GOTO 4
2 CLS
PRINT "Matt's custom decryption!"
5 PRINT "enter the encrypted text"
INPUT text$
6 PRINT "enter the key code for decryption"
INPUT keycode$
IF LEN(keycode$) <> 26 THEN PRINT "invalid": GOTO 6
LET a$ = MID$(keycode$, 1, 1)
LET b$ = MID$(keycode$, 2, 1)
LET c$ = MID$(keycode$, 3, 1)
LET d$ = MID$(keycode$, 4, 1)
LET e$ = MID$(keycode$, 5, 1)
LET f$ = MID$(keycode$, 6, 1)
LET g$ = MID$(keycode$, 7, 1)
LET h$ = MID$(keycode$, 8, 1)
LET i$ = MID$(keycode$, 9, 1)
LET j$ = MID$(keycode$, 10, 1)
LET k$ = MID$(keycode$, 11, 1)
LET l$ = MID$(keycode$, 12, 1)
LET m$ = MID$(keycode$, 13, 1)
LET n$ = MID$(keycode$, 14, 1)
LET o$ = MID$(keycode$, 15, 1)
LET p$ = MID$(keycode$, 16, 1)
LET q$ = MID$(keycode$, 17, 1)
LET r$ = MID$(keycode$, 18, 1)
LET s$ = MID$(keycode$, 19, 1)
LET t$ = MID$(keycode$, 20, 1)
LET u$ = MID$(keycode$, 21, 1)
LET v$ = MID$(keycode$, 22, 1)
LET w$ = MID$(keycode$, 23, 1)
LET x$ = MID$(keycode$, 24, 1)
LET y$ = MID$(keycode$, 25, 1)
LET z$ = MID$(keycode$, 26, 1)
LET codetext$ = ""
FOR num = 1 TO LEN(text$)
IF MID$(text$, num, 1) = a$ THEN LET codetext$ = codetext$ + "a"
IF MID$(text$, num, 1) = b$ THEN LET codetext$ = codetext$ + "b"
IF MID$(text$, num, 1) = c$ THEN LET codetext$ = codetext$ + "c"
IF MID$(text$, num, 1) = d$ THEN LET codetext$ = codetext$ + "d"
IF MID$(text$, num, 1) = e$ THEN LET codetext$ = codetext$ + "e"
IF MID$(text$, num, 1) = f$ THEN LET codetext$ = codetext$ + "f"
IF MID$(text$, num, 1) = g$ THEN LET codetext$ = codetext$ + "g"
IF MID$(text$, num, 1) = h$ THEN LET codetext$ = codetext$ + "h"
IF MID$(text$, num, 1) = i$ THEN LET codetext$ = codetext$ + "i"
IF MID$(text$, num, 1) = j$ THEN LET codetext$ = codetext$ + "j"
IF MID$(text$, num, 1) = k$ THEN LET codetext$ = codetext$ + "k"
IF MID$(text$, num, 1) = l$ THEN LET codetext$ = codetext$ + "l"
IF MID$(text$, num, 1) = m$ THEN LET codetext$ = codetext$ + "m"
IF MID$(text$, num, 1) = n$ THEN LET codetext$ = codetext$ + "n"
IF MID$(text$, num, 1) = o$ THEN LET codetext$ = codetext$ + "o"
IF MID$(text$, num, 1) = p$ THEN LET codetext$ = codetext$ + "p"
IF MID$(text$, num, 1) = q$ THEN LET codetext$ = codetext$ + "q"
IF MID$(text$, num, 1) = r$ THEN LET codetext$ = codetext$ + "r"
IF MID$(text$, num, 1) = s$ THEN LET codetext$ = codetext$ + "s"
IF MID$(text$, num, 1) = t$ THEN LET codetext$ = codetext$ + "t"
IF MID$(text$, num, 1) = u$ THEN LET codetext$ = codetext$ + "u"
IF MID$(text$, num, 1) = v$ THEN LET codetext$ = codetext$ + "v"
IF MID$(text$, num, 1) = w$ THEN LET codetext$ = codetext$ + "w"
IF MID$(text$, num, 1) = x$ THEN LET codetext$ = codetext$ + "x"
IF MID$(text$, num, 1) = y$ THEN LET codetext$ = codetext$ + "y"
IF MID$(text$, num, 1) = z$ THEN LET codetext$ = codetext$ + "z"
IF MID$(text$, num, 1) = " " THEN LET codetext$ = codetext$ + " "
NEXT num
PRINT " "
PRINT codetext$
PRINT " "
PRINT "Satisfied?"
PRINT "press 1 to try to decrypt using a different keycode"
PRINT "press 2 to decrypt a different encrypted text"
PRINT "press 3 to go back to the main menu"
PRINT "press 4 to end now"
INPUT chc
IF chc = 1 THEN GOTO 6
IF chc = 2 THEN GOTO 5
IF chc = 3 THEN GOTO 0
IF chc = 4 THEN END
END

