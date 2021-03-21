//HCSUB2       JOB (COBOL), 
//             'HCSUB 2',
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
MAINPRG2 CSECT
*
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
         ST    R13,SAVREG13
*
         WTO   '* MAINPRG2 is starting.'

         WTO   '* MAINPRG2 calling SUBPRG2.'
         LA    R13,SAVEAREA
         CALL  SUBPRG2,(CREC),VL

         MVC   WTOTEXT(30),CNAME
         WTO   MF=(E,WTOBLOCK)

         MVC   WTOTEXT(76),SPACE76
         MVC   WTOTEXT(20),CADDR1
         WTO   MF=(E,WTOBLOCK)

         MVC   WTOTEXT(76),SPACE76
         MVC   WTOTEXT(20),CADDR2
         WTO   MF=(E,WTOBLOCK)

         MVC   WTOTEXT(76),SPACE76
         MVC   WTOTEXT(15),CCITY
         WTO   MF=(E,WTOBLOCK)

         MVC   WTOTEXT(76),SPACE76
         MVC   WTOTEXT(2),CSTATE
         WTO   MF=(E,WTOBLOCK)

         MVC   WTOTEXT(76),SPACE76
         MVC   WTOTEXT(9),CZIP
         WTO   MF=(E,WTOBLOCK)

         
         WTO   '* MAINPRG2 returned'
*
*---------------------------------------------------------------------*
EOJAOK   EQU   *
         WTO   '* MAINPRG2 is complete.'
         L     R13,SAVREG13
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* MAINPRG2 is abending...RC=0008'
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

SPACE76   DC    CL76' '

CREC     DS 0CL96    THE RECORD WITH ITS SUBFIELDS
CNAME    DS CL30     OFFSET =  0
CADDR1   DS CL20     OFFSET = 30
CADDR2   DS CL20     OFFSET = 50
CCITY    DS CL15     OFFSET = 70
CSTATE   DS CL2      OFFSET = 85
CZIP     DS CL9      OFFSET = 87

WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '

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

CRECB    DSECT
CNAME    DS CL30     OFFSET =  0
CADDR1   DS CL20     OFFSET = 30
CADDR2   DS CL20     OFFSET = 50
CCITY    DS CL15     OFFSET = 70
CSTATE   DS CL2      OFFSET = 85
CZIP     DS CL9      OFFSET = 87

SUBPRG2 CSECT
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
*
         LTR   R1,R1
         BZ    NOPARMS
*
         USING CRECB,R2
         L    R2,0(R1)           * Put addr of addr list into reg-2
*
         WTO   '* SUBPRG2 is starting.'
         MVC CNAME,ONAME
         MVC CADDR1,OADDR1
         MVC CADDR2,OADDR2
         MVC CCITY,OCITY
         MVC CSTATE,OSTATE
         MVC CZIP,OZIP

        
*
*---------------------------------------------------------------------*
* NORMAL END-OF-JOB
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
EOJAOK   EQU   *
         WTO   '* SUBPRG2 is returning.'
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* SUBPRG2 is abending...RC=0008'
         RETURN (14,12),RC=8
*
***********************************************************************
* Post a non-paramter message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
NOPARMS  EQU   *
         WTO   '* SUBPRG2 called with zero parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Post a too-many-paramters message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
TOOMANY  EQU   *
         WTO   '* SUBPRG2 called with too many parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Define Constants and EQUates
*
         DS    0F            + Force alignment
ONAME    DC CL30'BRAD RIGG'
OADDR1   DC CL20'IN CARE OF M RIGG'
OADDR2   DC CL20'8050 32nd RD'
OCITY    DC CL15'RAPID RIVER'
OSTATE   DC CL2'MI'
OZIP     DC CL9'49878'


WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '
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
 NAME SUBPROG2(R)
//*-------------------------------------------------------------------
//SUBPROG2    EXEC PGM=SUBPROG2
//STEPLIB   DD DSN=HERC01.ASMMVS.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//