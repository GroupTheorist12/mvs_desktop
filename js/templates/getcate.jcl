//LISTPDS JOB (PDSS), 
//             'List PDS',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//STEP1    EXEC  PGM=IDCAMS 
//SYSPRINT DD    SYSOUT=A 
//SYSIN    DD    * 
 LISTCAT -
          LEVEL(HERC01) -
          NAME                        /* NAME INFORMATION ONLY     */ -
          CATALOG(SYS1.UCAT.TSO)           /* IN CATALOG ICFUCAT1 -
          ALL      
*/