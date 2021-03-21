//HMOV2A       JOB (ASM), 
//             'MOVE 2A',
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
        PRINT NOGEN              don't show macro expansions
****************************************************************
*        FILENAME:  MOVE2A.MLC                                 *
*        AUTHOR  :  Bill Qualls                                *
*        SYSTEM  :  Compaq 286LTE, PC/370 R4.2                 *
*        REMARKS :  Demonstrate character moves.               *
*        REMARKS :  Updated by B Rigg run on MVS38J.           *
****************************************************************

MOVE2A  CSECT                    start main code csect at base 0
        SAVE  (14,12)            Save input registers
        LR    R12,R15            base register := entry address
        USING MOVE2A,R12           declare base register
        ST    R13,SAVE+4         set back pointer in current save area
        LR    R2,R13             remember callers save area
        LA    R13,SAVE           setup current save area
        ST    R13,8(R2)          set forw pointer in callers save area
*
        MVC   WTOTEXT(7),IPHONE
        WTO   MF=(E,WTOBLOCK)

        MVC   OPFX,IPFX
        MVC   OHYPHEN,WHYPHEN
        MVC   OLINE,ILINE
        MVC   WTOTEXT(7),SPACE76

        MVC   WTOTEXT(8),OPHONE
        WTO   MF=(E,WTOBLOCK)


        L     R13,SAVE+4         get old save area back
        RETURN (14,12),RC=0      return to OS
*
*
*
SAVE     DS    18F                local save area


WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '

         LTORG
*
*        Other field definitions
*
WHYPHEN  DC    CL1'-'
*
IPHONE   DS    0CL7
IPFX     DC    CL3'555'
ILINE    DC    CL4'1212'
*
OPHONE   DS    0CL8
OPFX     DS    CL3
OHYPHEN  DS    CL1
OLINE    DS    CL4


SPACE76   DC    CL76' '

        YREGS ,
        END   MOVE2A               define main entry point

/*
//LKED     EXEC PGM=IEWL,
//             COND=(5,LT,ASMF1),
//             PARM='LIST,MAP,XREF,LET,RENT'
//SYSPRINT  DD SYSOUT=*
//SYSLMOD   DD DSN=HERC01.ASMMVS.LOADLIB,DISP=SHR
//SYSUT1    DD UNIT=SYSDA,SPACE=(TRK,(5,5))
//SYSLIN    DD DSN=&&OBJ,DISP=(OLD,DELETE)
//          DD *
 NAME MOVE2A(R)
//*-------------------------------------------------------------------
//MOVE2A    EXEC PGM=MOVE2A
//STEPLIB   DD DSN=HERC01.ASMMVS.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//