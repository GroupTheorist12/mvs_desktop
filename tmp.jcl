//HCSUB3       JOB (COBOL), 
//             'HCSUB 3',
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

MAINPRG3 CSECT
*
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
         ST    R13,SAVREG13
*
         WTO   '* MAINPRG3 is starting.'

         WTO   '* MAINPRG3 calling SUBPRG3.'
         LA    R13,SAVEAREA

         OPEN  (SYSIN,(INPUT))
         GET   SYSIN,INREC

FINISH   DS   0H                 Invoked at End of Data of SYSIN 
         CLOSE (SYSIN)           

         MVC   MNTHVAL(2),INREC   
         CALL  SUBPRG3,(CREC),VL

         
         WTO   'Month value is'

         MVC   WTOTEXT(9),MNTHOUT
         WTO   MF=(E,WTOBLOCK)

*
*---------------------------------------------------------------------*
EOJAOK   EQU   *
         WTO   '* MAINPRG3 is complete.'
         L     R13,SAVREG13
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* MAINPRG3 is abending...RC=0008'
         L     R13,SAVREG13
         RETURN (14,12),RC=8
*
***********************************************************************
* Define Constants and EQUates
*

*
SAVEAREA EQU   *
         DC    A(0)
         DC    A(0)
SAVREG13 DC    A(0)
         DC    15A(0)        * Used by SAVE/RETURN functions


CREC     DS 0CL11    THE RECORD WITH ITS SUBFIELDS
MNTHVAL  DC    CL2'01'                                                  
MNTHOUT  DS    CL9                                                  

DUMMY     DC    CL9' '


WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '


SPACE76   DC    CL76' '
INREC     DC    CL80' '


SYSIN    DCB   DSORG=PS,MACRF=(GM),DDNAME=SYSIN,EODAD=FINISH,          *
                RECFM=FB,LRECL=80,BLKSIZE=0     

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

DATAB    DSECT
MNTHVAL  DS    CL2                                                  
MNTHOUT  DC    CL9' '                                                  

SUBPRG3 CSECT
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
*
         LTR   R1,R1
         BZ    NOPARMS
*
         USING DATAB,R2
         L    R2,0(R1)           * Put addr of addr list into reg-2
*
         WTO   '* SUBPRG3 is starting.'

         LA     8,MONTAB
C10LOOP  CLC    MNTHVAL,0(8)
         BE     C20EQUAL
         BL     R10INV
         AH      8,=H'11'
         B      C10LOOP 
C20EQUAL MVC    MNTHOUT,2(8)                
         B      EOJAOK
         
R10INV   MVC    MNTHOUT,INVALID        


*
*---------------------------------------------------------------------*
* NORMAL END-OF-JOB
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*

EOJAOK   EQU   *

         WTO   '* SUBPRG3 is returning.'
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* SUBPRG3 is abending...RC=0008'
         RETURN (14,12),RC=8
*
***********************************************************************
* Post a non-paramter message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
NOPARMS  EQU   *
         WTO   '* SUBPRG3 called with zero parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Post a too-many-paramters message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
TOOMANY  EQU   *
         WTO   '* SUBPRG3 called with too many parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Define Constants and EQUates
*
         DS    0F            + Force alignment

MONTAB   DC     C'01JANUARY  '  
         DC     C'02FEBRUARY '           
         DC     C'03MARCH    '           
         DC     C'04APRIL    '           
         DC     C'05MAY      '           
         DC     C'06JUNE     '           
         DC     C'07JULY     '           
         DC     C'08AUGUST   '           
         DC     C'09SEPTEMBER'           
         DC     C'10OCTOBER  '           
         DC     C'11NOVEMBER '           
         DC     C'12DECEMBER '           
         DC     X'FFFF' 

WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '

INVALID  DC     C'INVALID  '
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
 NAME SUBPROG3(R)
//*-------------------------------------------------------------------
//SUBPROG3    EXEC PGM=SUBPROG3
//STEPLIB   DD DSN=HERC01.ASMMVS.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//SYSIN     DD * 
11
/*
//