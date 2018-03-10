DIM land(640)
SCREEN 12
pi = 3.14159
a$ = "bg2u4l4d4r4"
PRINT "Press r to reverse directions, p to toggle paint mode, c to change the color"
PRINT "and enter to quit out and try again"

DO UNTIL again$ = "n"
       
        INPUT "angle", angle
        INPUT "velocity", velc
        angle = angle * (pi / 180)
        vx = COS(angle) * velc
        vy = SIN(angle) * velc
        vx = vx / 500
        vy = vy / 500
        g = .01
        posx = 320
        posy = 240
        timex = 1
        timey = 1
        wind = .01
        clr = -1
        k$ = ""
        colour = 4
        sang$ = "ta" + STR$(angle * -1)
        CLS
        FOR i = 1 TO 640
                y = 10 * COS(3 * i * pi / 180) + 400
                LINE (i, 480)-(i, y), 14
                land(i) = y
        NEXT i
       
        'FOR i = 1 TO 640
        '        y = 0
        '        DO UNTIL land(i - 1) > 0
        '                IF POINT(i - 1, y) = 14 THEN land(i) = y
        '                y = y + 1
        '        LOOP
        'NEXT i
        DO UNTIL k$ = CHR$(13)
                timex = timex + .04
                timey = timey + .04
                x = posx + vx * timex + .5 * wind * (timex * timex)
                y = posy - (vy * timey) + (.5 * g * (timey * timey))
                IF x >= 640 THEN
                        vx = -(wind * timex + vx) * .75
                        posx = 640
                        timex = 1
                END IF
                IF x <= 0 THEN
                        vx = -(wind * timex + vx) * .75
                        posx = 0
                        timex = 1
                END IF
                IF y >= 480 THEN
                        vy = (g * timey - vy) * .75
                        posy = 480
                        timey = 1
                END IF
                IF y <= 0 THEN
                        vy = (g * timey - vy) * .75
                        posy = 0
                        timey = 1
               
                END IF
                k$ = INKEY$
                IF k$ = "c" THEN colour = INT(RND * 15 + 1)
                IF k$ = "p" THEN clr = clr * -1
                IF k$ = "r" THEN
                        vy = -((g * timey) - vy)
                        g = g * -1
                        posy = y
                        timey = 1
                END IF
                IF k$ = "w" THEN
                        vx = ((wind * timex) + vx)
                        wind = wind * -1
                        posx = x
                        timex = 1
                END IF
              
               
                PSET (oldx, oldy), 0: DRAW "c" + STR$((colour * clr + colour) / 2) + sang$ + a$
                ta = ATN((oldy - y) / (oldx - x + .000001))
                ta = INT(ta / pi * 180) * -1
                sang$ = "ta" + STR$(ta)
                IF y >= land(INT(x)) THEN
                        la = ATN(land(x + 1) - y)
                        la = INT(la / pi * 180)
                        'PRINT la
                        'SLEEP 10
                        angle = -(2 * la + ABS(ta))
                        'PRINT angle
                        vx = (wind * timex + vx) * .75
                        vy = (g * timey + vy) * .75
                        velc = vx * vx + vy * vy
                        angle = angle * pi / 180
                        vx = COS(angle) * velc
                        vy = SIN(angle) * velc
                        'PRINT vx, vy
                        'SLEEP 10
                        posx = x
                        posy = y
                        timex = 1
                        timey = 1
                END IF
                PSET (x, y), 0: DRAW "c" + STR$(colour) + sang$ + a$
                oldy = y
                oldx = x
        LOOP
        again$ = ""
        DO UNTIL again$ = "y" OR again$ = "n"
                INPUT "again?   (y/n)", again$
        LOOP

LOOP

