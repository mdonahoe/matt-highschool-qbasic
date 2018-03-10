'MATT DONAHOE
'I have been instructed to print the factors of a trinomial
'over the integers or print that the trinomial cannot be factored.
'
'Variable Explantion:
'a, b, c, stand for the coefficients in the trinomial equation
'    ax^2+bx+c.
'astep and zstep are varibles that account for whether the a or c
'    values are negative
'i is the loop variable used for finding the factors of a
'j is the loop variable used for finding the factors of c
'x has nothing to do with the trinomial, it is used to commumicate
'    between loops

CLS

'User inputs the coefficients
PRINT "Input the values for A, B and C for a trinomial"
PRINT "where: AX ^ 2 + BX + C"
INPUT "a"; a
INPUT "b"; b
INPUT "c"; c

'Determining if the inputed variables form a trinomial
IF a = 0 OR b = 0 OR c = 0 THEN PRINT "NOT A TRINOMIAL!": END

'Determining whether a and c are negative and adjusting step
'variables accordingly
IF a > 0 THEN LET astep = 1
IF a < 0 THEN LET astep = -1
IF c > 0 THEN LET cstep = 1
IF c < 0 THEN LET cstep = -1

'Clearing x
LET x = 0

'Loop for finding factors for a
FOR i = INT(a / 2) + (astep) TO 1 STEP -(astep)
IF x <> 1 THEN
LET a1 = i
IF a / i = INT(a / i) THEN
LET a2 = a / i

'Loop for finding factors for c
FOR j = INT(c / 2) + (cstep) TO 1 STEP -(cstep)
IF x <> 1 THEN
LET c1 = j
IF c / j = INT(c / j) THEN
LET c2 = c / j

'Determining if the trinomial can be factored with this configuration
IF x <> 1 AND (a1 * c1) + (a2 * c2) = b THEN

'Determines what signs to be placed depending on variables
IF a1 = 1 THEN PRINT "(x";  ELSE PRINT "("; a1; "x";
IF c2 > 0 THEN PRINT "+"; c2; ")";  ELSE PRINT c2; ")";
IF a2 = 1 THEN PRINT "(x";  ELSE PRINT "("; a2; "x";
IF c1 > 0 THEN PRINT "+"; c1; ")" ELSE PRINT c1; ")"

'Makes sure that only one answer is provided
LET x = 1
END IF

'Determining if the trinomial can be factored with this configuration
IF x <> 1 AND (a1 * c2) + (a2 * c1) = b THEN

'Determines what signs to be placed depending on variables 
IF a1 = 1 THEN PRINT "(x";  ELSE PRINT "("; a1; "x";
IF c1 > 0 THEN PRINT "+"; c1; ")";  ELSE PRINT "-"; (-c1); ")";
IF a2 = 1 THEN PRINT "(x";  ELSE PRINT "("; a2; "x";
IF c2 > 0 THEN PRINT "+"; c2; ")" ELSE PRINT "-"; (-c2); ")"

'Makes sure that only one answer is provided
LET x = 1

END IF
END IF
END IF
NEXT j
END IF
END IF
NEXT i

'Checks to see if the trinomial was factored
IF x <> 1 THEN PRINT "CANNOT BE FACTORED"

END

