//{{JOBNM}} JOB (COBOL), 
//             'Create PS',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//STEP1 EXEC PGM=IEBGENER 
//SYSPRINT DD SYSOUT=*
//SYSIN DD DUMMY
//SYSUT1 DD *
{{REPLACE_ME_WITH_CONTENT}}
/*
//SYSUT2 DD DSN={{REPLACE_ME_WITH_FILENAME}},
//       DISP=SHR
/*