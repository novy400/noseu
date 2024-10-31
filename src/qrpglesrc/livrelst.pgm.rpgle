**free
Ctl-Opt Main(LIVRELST)
        option(*nodebugio:*srcstmt:*nounref)
        alwnull(*usrctl)
        bnddir('QC2LE':'NOSEU');

/include '../qrpgleref/livrerst.rpgleinc'

// Main procedure to list all books
Dcl-Proc LIVRELST;
  Dcl-Pi *N;
  End-Pi;
  dcl-ds lLivres likeds(LIVRERST_Item) dim(1000);
  clear lLivres;
  // Get all books
  LIVRERST_GETALL(lLivres);
  
End-Proc;
