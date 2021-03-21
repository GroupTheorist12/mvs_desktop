//HCREAPDS JOB (COBOL), 
//             'Create PDS',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//IDCAMS  EXEC PGM=IDCAMS                                               
//SYSPRINT DD SYSOUT=*                                                  
//SYSIN    DD *                                                         
 DELETE 'HERC01.ASMMVS.LOADLIB' NONVSAM PURGE
 DELETE 'HERC01.ASMMVS.ASM'     NONVSAM PURGE                            
 DELETE 'HERC01.ASMMVS.SOURCE'  NONVSAM PURGE                            
 SET MAXCC = 0                                                          
//*                                                                     
//STEP010 EXEC PGM=IEFBR14  
//DD1 DD DSN=HERC01.ASMMVS.LOADLIB,
//      DISP=(NEW,CATLG,DELETE), 
//      UNIT=DISK,VOL=SER=PUB012,                                    
//      SPACE=(TRK,(2,2,2),RLSE),                         
//      DCB=(RECFM=U,BLKSIZE=19069,DSORG=PO)
//*                                                                     
//STEP011  EXEC PGM=IEFBR14                     
//SYSUT2   DD DSN=HERC01.ASMMVS.ASM,DISP=(NEW,CATLG,DELETE),             
//         UNIT=DISK,SPACE=(TRK,(1,1,1)),VOL=SER=PUB012,               
//         DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120,DSORG=PO)               
//SYSPRINT DD SYSOUT=*                                                 
//SYSIN    DD *                                                        
//*                                                                     
//STEP012  EXEC PGM=IEFBR14                     
//SYSUT2   DD DSN=HERC01.ASMMVS.SOURCE,DISP=(NEW,CATLG,DELETE),             
//         UNIT=DISK,SPACE=(TRK,(1,1,1)),VOL=SER=PUB012,               
//         DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120,DSORG=PO)               
//SYSPRINT DD SYSOUT=*                                                 
//SYSIN    DD *                                                        
/*