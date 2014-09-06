' bob walker implemented in QBasic (QB64)
DO UNTIL sport_mode$ = "y" OR sport_mode$ = "n"
    INPUT "Is bob feeling sporty"; sport_mode$
LOOP

DO
    PRINT "beer"
    PRINT "beard"
    PRINT "pie"

    IF sport_mode$ = "y" THEN
        PRINT "cricket"
        PRINT "rugby"
    END IF

LOOP
