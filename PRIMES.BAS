'GoldBach's Conjecture by Matt Donahoe.
'This program proves GoldBach's Conjecture for every even number
'greater than four up to an even number the user selects.
'The program also prints ERROR and the number that proves the conjecture false.
'That would be how GoldBach's Conjecture would be disproven.
'
'variable explanation:
'even, prime, and prime 2 are self explanatory.
'X,Y, and Z are varible that i use to communincate between loops.
'A and B are variables for number to divide suspected primes by.

CLS
PRINT "Goldbach's; Conjecture"
INPUT "even number to stop at"; num    'user defined termination point

'checks that the number is even
IF num / 2 = INT(num / 2) AND NOT num / 2 = 1 THEN

'loop for all the even numbers from four to end number.
FOR even = 4 TO num STEP 2
LET X = 0

'loop to find prime numbers
FOR prime = 3 TO (INT(num / 2) + 1) STEP 2
IF X <> 1 THEN
LET prime2 = 0      'clears variable
LET Y = 0           'clears variable
LET Z = 0           'clears variable

'loop for the numbers to test the prime number with
FOR A = 2 TO (INT(prime / 2) + 1)
IF (prime / A) = INT(prime / A) THEN LET Y = 1
NEXT A
IF Y <> 1 THEN LET prime2 = even - prime
IF prime2 = 1 THEN PRINT even; "="; prime; "+"; prime2: LET X = 1
IF prime2 > 1 AND (prime2 / 2) <> INT(prime2 / 2) AND prime2 = INT(prime2) THEN

'loop to test if the number formed by prime subtracting from the even is prime
FOR B = 2 TO (INT(prime2 / 2) + 1)
IF (prime2 / B) = INT(prime2 / B) THEN LET Z = 1
NEXT B
IF Z <> 1 THEN PRINT even; "="; prime; "+"; prime2: LET X = 1
END IF
END IF
NEXT prime

'This line checks for even numbers that do not fit the Conjecture
IF X = 0 THEN PRINT "ERROR!"; even: END
NEXT even
ELSE PRINT "invalid termination number!"
END IF
END

