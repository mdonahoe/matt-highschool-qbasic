DATA player names must be less than 10 characters long
DATA press enter to advance to the next step during weapon selection
DATA the left and right arrows control lateral tank movement
DATA the up and down arrows control the turret angle
DATA if you purchased an item press its button code to select it for use
DATA press enter to start the power bar - press it again to select a power
DATA non means a weapon will only detonate when enter is pressed
DATA imp means the weapon will detonate upon impact
DATA some impact weapons will perform functions if enter is pressed
DATA you receive the same amount of points for the amount of damage inflicted
DATA 3 damage areas on the tank - 5 damage on the sides - 10 in the middle
DATA tell me if you have or find any problems
a = 0
a$ = "Blank"
OPEN "tankwars.dat" FOR OUTPUT AS #1
FOR i = 1 TO 10
WRITE #1, a, a$
NEXT i
CLOSE #1
OPEN "tankhelp.dat" FOR OUTPUT AS #1
FOR i = 1 TO 12
READ n$
WRITE #1, n$
NEXT i
CLS
PRINT "Done"
END

