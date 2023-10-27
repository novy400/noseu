**free
ctl-opt nomain
        option(*nodebugio:*srcstmt:*nounref)
        alwnull(*usrctl)
        bnddir('QC2LE');
/copy RPGUNIT1,TESTCASE
/include '../qrpgleref/livrerst.rpgleinc'

dcl-proc setUpSuite;
  dcl-pi *N; 
  end-pi;
end-proc;

dcl-proc setUp;
  dcl-pi *N; 
  end-pi;
end-proc;

dcl-proc tearDown;
  dcl-pi *N; 
  end-pi;
end-proc;

dcl-proc tearDownSuite;
  dcl-pi *N; 
  end-pi;
end-proc;

dcl-proc  test_LIVRERST_GETALL export;
  dcl-pi *N; 
  end-pi;
  dcl-ds lLivres likeds(LIVRERST_Item) dim(1000);
  clear lLivres;
  LIVRERST_GETALL(lLivres);
  // sorta lLivres %fields(code);
  assert(lLivres(1).code > 0 : 'aucun livre trouvé !');
  assert(lLivres(1).code = 1 : 'code livre incorrect !');
end-proc;
