      .ORG $0
      BRA $200

      .ORG $0310
START .DW $FF80 ; R1 <- -128 for now
      .DW $FF80 ; R2 <- +127 for now

      .ORG $200
INIT  LI R3, $0 ; clears the product
      LI R6, $0 ; initializes count

      LW R7, R0, $0312 ; moves B to R7
      LW R2, R0, $0312 ; moves B to R2
      LW R1, R0, $0310 ; moves A to R1
      SLTI R0, R2, $0 ; performs R2 - $0
      BRN NEG
      BRA LOOP
NEG   NOT R2, R2 ; R2 <- not R2
      ADDI R2, R2, $1 ; R2 <- R2 + $1
LOOP  LI R4, $1 ; R4 <- $1
      AND R5, R2, R4 ; R5 <- B_abs & $1
      SLTI R0, R5, $1 ; performs R5 - $1
      BRZ INCR ; checks if R5 == $1
      BRA CONT
INCR  ADD R3, R3, R1 ; adds A to product
CONT  SRA R2, R2, R4 ; shifts B_abs to the right by $1
      SLL R1, R1, R4 ; shifts A to the left by $1
      ADDI R6, R6, $1 ; count <- count + 1
      SLTI R0, R6, $8 ; performs R6 - $8
      BRN LOOP ; continues loop if R6 < $8
      BRA FINAL ; if R6 == $8, done
FINAL SLTI R0, R7, $0 ; performs R7 - $0
      BRN NEG1 ; goes to neg1 if R7 < $0
      BRA DONE ; else returns
NEG1  NOT R3, R3 ; product <- not product
      ADDI R3, R3, $1 ;product <- product + $1
      ;SW R0, R3, $4000 ; M[0 + $4000] <- R3
DONE  SW R0, R3, $0300 ; M[0+4000] <- R3
      STOP

