    .ORG $000
    LI R3, $0000

LOOP SLTI R0, R3, $0 ;R3 - $0
     BRN DONE ; if R3 < $0, goto done
     BRA LOOP
DONE STOP
