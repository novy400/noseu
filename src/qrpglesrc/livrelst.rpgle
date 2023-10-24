**free
**FREE
Ctl-Opt Main(LIVRELST)
        option(*nodebugio:*srcstmt:*nounref)
        alwnull(*usrctl)
        bnddir('QC2LE':'NOSEU');

/include '../qrpgleref/livrerst.rpgleinc'

Dcl-Proc LIVRELST;
  Dcl-Pi *N;
  End-Pi;
dcl-ds lLivres likeds(LIVRERST_Item) dim(1000);
clear lLivres;
LIVRERST_GETALL(lLivres);
  
End-Proc;
