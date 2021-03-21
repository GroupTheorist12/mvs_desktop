//HCSUB1       JOB (COBOL), 
//             'HCSUB 1',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//ASMF1     EXEC PGM=IFOX00,REGION=2048K
//SYSLIB    DD DSN=SYS1.AMODGEN,DISP=SHR
//          DD DSN=SYS1.AMACLIB,DISP=SHR
//          DD DSN=SYS2.MACLIB,DISP=SHR 
//SYSUT1    DD DISP=(NEW,DELETE),SPACE=(1700,(900,100)),UNIT=SYSDA
//SYSUT2    DD DISP=(NEW,DELETE),SPACE=(1700,(600,100)),UNIT=SYSDA
//SYSUT3    DD DISP=(NEW,DELETE),SPACE=(1700,(600,100)),UNIT=SYSDA
//SYSPRINT  DD SYSOUT=*
//SYSPUNCH  DD DSN=&&OBJ,UNIT=SYSDA,SPACE=(CYL,1),DISP=(NEW,PASS)
//SYSIN     DD * 
ASMASMA1 CSECT
*
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
         ST    R13,SAVREG13
*
         WTO   '* ASMASMA1 is starting, example of CALL macro...'
*
         WTO   '* ASMASMA1 calling ASMASMAA without parameters...'
         LA    R13,SAVEAREA
         SR    R1,R1
         CALL  ASMASMAA
         WTO   '* ASMASMA1 return...'
*
         WTO   '* ASMASMA1 calling ASMASMAA with four parameters...'
         LA    R13,SAVEAREA
         CALL  ASMASMAA,(PARM01,PARM02,PARM03,PARM04),VL
         WTO   '* ASMASMA1 return...'
*
*---------------------------------------------------------------------*
EOJAOK   EQU   *
         WTO   '* ASMASMA1 is complete, example of CALL macro......'
         L     R13,SAVREG13
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* ASMASMA1 is abending...RC=0008'
         L     R13,SAVREG13
         RETURN (14,12),RC=8
*
***********************************************************************
* Define Constants and EQUates
*
         DS    0F            + Force alignment
*
SAVEAREA EQU   *
         DC    A(0)
         DC    A(0)
SAVREG13 DC    A(0)
         DC    15A(0)        * Used by SAVE/RETURN functions
*
PARM01   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 01 '
PARM02   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 02 '
PARM03   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 03 '
PARM04   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 04 '
*
* Register EQUates
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
*
         END

/*
//ASMF2     EXEC PGM=IFOX00,REGION=2048K
//SYSLIB    DD DSN=SYS1.AMODGEN,DISP=SHR
//          DD DSN=SYS1.AMACLIB,DISP=SHR
//          DD DSN=SYS2.MACLIB,DISP=SHR 
//SYSUT1    DD DISP=(NEW,DELETE),SPACE=(1700,(900,100)),UNIT=SYSDA
//SYSUT2    DD DISP=(NEW,DELETE),SPACE=(1700,(600,100)),UNIT=SYSDA
//SYSUT3    DD DISP=(NEW,DELETE),SPACE=(1700,(600,100)),UNIT=SYSDA
//SYSPRINT  DD SYSOUT=*
//SYSPUNCH  DD DSN=&&OBJ,UNIT=SYSDA,SPACE=(CYL,1),DISP=(MOD,PASS)
//SYSIN     DD * 
ASMASMAA CSECT
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
*
         LTR   R1,R1
         BZ    NOPARMS
*
         LR    R2,R1           * Put addr of addr list into reg-2
*
         WTO   '* ASMASMAA is starting...'
*
         LA    R3,TOOMANY      * Limit loop count to reg-3 value
         LA    R4,4            * Set reg-4 to four (Loop Limit)
*
ADDRLOOP EQU   *
         L     R5,0(,R2)       * Use reg-5 for WTO address
         WTO   MF=(E,(R5))
         TM    0(R2),X'80'     * Is this last parameter...
         BO    EOJAOK          * If yes, Branch out of loop...
         LA    R2,4(,R2)               increment to next addr in list
         BCT   R4,ADDRLOOP       Else, decrement parameter count
         B     TOOMANY         * Too-many or invalid parm list
*
*---------------------------------------------------------------------*
* NORMAL END-OF-JOB
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
EOJAOK   EQU   *
         WTO   '* ASMASMAA is returning...'
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* ASMASMAA is abending...RC=0008'
         RETURN (14,12),RC=8
*
***********************************************************************
* Post a non-paramter message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
NOPARMS  EQU   *
         WTO   '* ASMASMAA called with zero parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Post a too-many-paramters message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
TOOMANY  EQU   *
         WTO   '* ASMASMAA called with too many parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Define Constants and EQUates
*
         DS    0F            + Force alignment
*
* Register EQUates
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
*
         END
/*
//LKED     EXEC PGM=IEWL,
//             COND=(5,LT,ASMF1),
//             PARM='LIST,MAP,XREF,LET,RENT'
//SYSPRINT  DD SYSOUT=*
//SYSLMOD   DD DSN=HERC01.ASMMVS.LOADLIB,DISP=SHR
//SYSUT1    DD UNIT=SYSDA,SPACE=(TRK,(5,5))
//SYSLIN    DD DSN=&&OBJ,DISP=(OLD,DELETE)
//          DD *
 NAME SUBPROG1(R)
//*-------------------------------------------------------------------
//SUBPROG1    EXEC PGM=SUBPROG1
//STEPLIB   DD DSN=HERC01.ASMMVS.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//