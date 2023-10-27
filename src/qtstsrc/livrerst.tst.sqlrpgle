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

dcl-proc test_LIVRERST_GETBYCODE export;

  dcl-pi *n ;
  end-pi;
  // déclaration des variables
  dcl-ds lLivre likeds(LIVRERST_Detail);
  dcl-s lTrouve ind inz(*off);
  // initialisation des variables
  clear lLivre;
  // appel de la procédure à tester
  lTrouve = *off;
  lTrouve = LIVRERST_GETBYCODE(1:lLivre);
  // vérification des résultats 
  assert(lTrouve = *on : 'aucun livre trouvé !');
  assert( lLivre.titre = 'Book 1': 'titre Book 1 KO !');
end-proc;