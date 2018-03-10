SCREEN 12
pi = 3.14159
a$ = "bg2u4r4d4l4"
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
        wind = .01
        posx = 100
        posy = 400
        timex = 1
        timey = 1
        clr = 1
        k$ = ""
        colour = 4
        CLS
        DO UNTIL k$ = CHR$(13)
                k$ = INKEY$
                IF k$ = "c" THEN colour = INT(RND * 15 + 1)
                IF k$ = "p" THEN clr = clr * -1
                IF k$ = "r" THEN
                        vy = -((g * timey) - vy)
                        g = g * -1
                        posy = y
                        timey = 1
                END IF
                IF k$ = "e" THEN
                        vx = ((wind * timex) + vx)
                        wind = wind * -1
                        posx = x
                        timex = 1
                END IF
               
                timex = timex + .02
                timey = timey + .02
                x = posx + vx * timex + .5 * wind * timex * timex
                y = posy - (vy * timey) + (.5 * g * (timey * timey))
                IF x >= 640 THEN
                        vx = -(wind * timex + vx)
                        posx = 640
                        timex = 1
                END IF
                IF x <= 0 THEN
                        vx = -(wind * timex + vx)
                        posx = 0
                        timex = 1
                END IF
                IF y >= 480 THEN
                        vy = (g * timey) - vy
                        posy = 480
                        timey = 1
                END IF
                IF y <= 0 THEN
                        vy = (g * timey) - vy
                        posy = 0
                        timey = 1
               
                END IF
                PSET (oldx, oldy), 0: DRAW "c" + STR$((colour * clr + colour) / 2) + a$
                PSET (x, y), 0: DRAW "c" + STR$(colour) + a$
                oldy = y
                oldx = x
        LOOP
        again$ = ""
        DO UNTIL again$ = "y" OR again$ = "n"
                INPUT "again?   (y/n)", again$
        LOOP

LOOP

