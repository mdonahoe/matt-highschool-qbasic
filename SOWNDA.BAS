SCREEN 12
    'Play scale in 7 different octaves
    scale$ = "CCC"
    FOR kui = 1 TO 3
    ta$ = ""
    FOR i = 1 TO LEN(scale$)
    ta$ = ta$ + MID$(scale$, i, 1) + "AEG"
    NEXT i
    scale$ = ta$
    NEXT kui
    PLAY "L16"
    FOR i = -3 TO 3
    PLAY "O" + STR$(ABS(i))
    PLAY "X" + VARPTR$(scale$)
    NEXT i

