         PRINT NOGEN
JSASM002 RMODE ANY
* ********************************************************************
* * THIS IS A TEST ASSEMBLER SUBROUTINE - PASS A FIELD TO IT AND
* * IT WILL RETURN A MODIFIED VERSION OF IT.
* ********************************************************************
JSASM002 CSECT
* ********************************************************************
* * BASE STUFF
* ********************************************************************
         STM R14,R12,12(R13)
         BALR R12,0
         USING *,R12
         ST R13,SAVEA+4
         LA R13,SAVEA
*
* ********************************************************************
* * GET THE PARMS
* *     - PUT IN R6 AND VARIABLE VARPARM
* *     - SET POINTER IN R4 TO 1ST BYTE OF STRING TO PARSE
* *     - PUT THE LOOP COUNTER IN R2 (CVB REQUIRES DBL WORD)
* ********************************************************************
         L R6,0(R1)              * PARMS ARE IN R1 PUT IN VARPARM & R6
         USING VARPARM,R6
         LA R4,6(,R6)            * SET PTR(R4) TO 1ST BYTE OF INPUT STR
         ZAP DBLWORD,VARLEN      * LOAD THE LOOP COUNT INTO R2
         SP  DBLWORD,=P'-1'      * "" -1 BECAUSE RELATIVE TO ZERO
         CVB R2,DBLWORD          * "" LOAD TO R2 FOR LOOP (BCT)
* ********************************************************************
* * LOOP THROUGH THE PASSED STRING AND CONVERT CHARS
* ********************************************************************
LOOP     EQU *
         CLC 0(1,R4),VARCHFR     * SEE IF TYPE NEEDS TO CHANGE
         BNE LOOPCONT
         MVC 0(1,R4),VARCHTO     * CHANGE BYTE
LOOPCONT EQU *
         LA R4,1(,R4)            * INCREMENT STR POINTER (R4)
         BCT R2,LOOP             * DECREMENT R2 AND LOOP UNTIL ZERO
*
LOOPEXT  EQU *
         L R1,0(R6)              * RETURN THE ADJUSTED STRING
*
* ********************************************************************
* * EXIT PROGRAM
* ********************************************************************
FINISH   DS 0H
         L 13,SAVEA+4
         LM R14,R12,12(R13)
         RETURN (14,12),RC=0
*
* ********************************************************************
* * DEFINE VARIABLES
* ********************************************************************
         LTORG
SAVEA    DS  18F
DBLWORD  DS D
*
VARPARM  DSECT
VARLEN   DS  PL4
VARCHFR  DS  CL1' '
VARCHTO  DS  CL1' '
VARIN    DS  CL0100' '
*
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
         END
