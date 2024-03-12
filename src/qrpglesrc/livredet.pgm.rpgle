**free

Ctl-Opt Main(main)
        option(*nodebugio:*srcstmt:*nounref)
        alwnull(*usrctl)
        bnddir('QC2LE':'NOSEU');

/include '../qrpgleref/livrerst.rpgleinc'

Dcl-Proc main;
  Dcl-Pi *N;
    pCode char(4) const;
  End-Pi;
  dcl-ds lLivre likeds(LIVRERST_Detail);
  clear lLivre;
  if LIVRERST_GETBYCODE(%int(pCode):lLivre);
    snd-msg 'le code ' + %char(lLivre.code);
    snd-msg 'le titre ' + %trim(lLivre.titre);
  else; 
    snd-msg 'le code ' + %char(pCode) + ' n''existe pas'; 
  endif;
  
End-Proc;
