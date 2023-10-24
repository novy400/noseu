**free
ctl-opt nomain
        option(*nodebugio:*srcstmt:*nounref)
        alwnull(*usrctl)
        pgminfo(*pcml:*module:*dclcase)
        bnddir('QC2LE');
/include '../qrpgleref/livrerst.rpgleinc'

dcl-proc LIVRERST_GETALL export;
  dcl-pi ind;
      pLivres likeds(LIVRERST_Item) dim(1000) options(*varsize);
  end-pi;
  dcl-s lUrl like(gLongueVariable);
  dcl-s lHeader like(gLongueVariable);
  dcl-s lMsg like(gLongueVariable);
  dcl-s lUriBook like(gLongueVariable);
  dcl-s lUriPhoto like(gLongueVariable);
monitor;
// initialisation
clear pLivres;
clear lHeader;
getHeader(lHeader);
clear lUrl;
getUrl(lUrl);
clear lUriBook;
lUriBook = lUrl + 'Books';
clear lUriPhoto;
lUriPhoto = lUrl + 'CoverPhotos';
snd-msg ('URL: ' + %trim(lUrl) + '.' + %trim(lHeader));
snd-msg ('HEADER: ' + %trim(lHeader) + '.');
// traitement
  // lecture d'une page 
  exec sql 
  DECLARE CUR_listeBook CURSOR FOR
    SELECT a.id, a.titre
    FROM JSON_TABLE(
            HTTP_GET(Http_Get(:lUriBook,:lHeader),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title'
                  )
        ) AS a
    order by a.id    
    optimize for 1000 rows
    for read only;
  Exec Sql
    open CUR_listeBook;
        select;    
     when SqlCode < *Zeros;
      clear lMsg;
      exec sql
        get diagnostics condition 1 :lMsg = MESSAGE_TEXT;
        snd-msg (%trim(%proc()) + 'horreur :'  + %trim(lMsg));
        clear pLivres;
        return *off;  
     when SqlCode = 100;
        clear pLivres;
        snd-msg (%trim(%proc()) + 'Aucun livre !');
        return *off;  
     other;    
    endsl;
  exec sql
    fetch next
    from CUR_listeBook
    for 1000 rows
    into :pLivres;

// finalisation  
on-error;
  // 💥 hooreur !
  clear pLivres
  snd-msg *escape ('Horreur ! dans ' + %trim(%proc()));
  return *off;
endmon;
return *on;
end-proc;

dcl-proc LIVRERST_Detail export;
  dcl-pi ind;
      pId like(LIVRERST_Detail.id) const;
      pLivre  likeds(LIVRERST_Detail);
  end-pi;
  dcl-s lUrl like(gLongueVariable);
  dcl-s lHeader like(gLongueVariable);
  dcl-s lMsg like(gLongueVariable);
  dcl-s lUriBook like(gLongueVariable);
  dcl-s lUriPhoto like(gLongueVariable);

  monitor;
  //initialition
  clear pLivre;
  clear lHeader;
  getHeader(lHeader);
  clear lUrl;
  getUrl(lUrl);
  clear lUriBook;
  lUriBook = lUrl + 'Books';
  clear lUriPhoto;
  lUriPhoto = lUrl + 'CoverPhotos';
  snd-msg ('URL: ' + %trim(lUrl) + '.' + %trim(lHeader));
  snd-msg ('HEADER: ' + %trim(lHeader) + '.');
  // traitement 
  // lecture d'un livre 
    exec sql 
   with BOOKS as (
    SELECT p.id, p.titre, p.description, p.nombrePages
    FROM JSON_TABLE(
            HTTP_GET(Http_Get(:lUriBook,:lHeader),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title',
                description VARCHAR(132) PATH 'lax $.description',
                nombrePages INTEGER PATH 'lax $.pageCount'
                )
        ) AS a
        where p.id = :pId
    ),
    PHOTOS as (
     SELECT a.idBook,a.url
    FROM JSON_TABLE(
            HTTP_GET(Http_Get(:lUriPhoto,:lHeader)),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                idBook INTEGER PATH 'lax $.idBook', 
                url VARCHAR(132) PATH 'lax $.url'
                )
        ) AS a
        where idBook <> 101
    )
    select p.id, p.titre, p.description, p.nombrePages,a.url
    into :pLivre
    from books b left join photos p on b.id = p.idBook
    optimize for 1000 rows
    for read only;
    select;
      when  SqlCode < 0;
        return *off;
    when  SqlCode = 100;
      return *off;
    other;
      return *on;
  endsl;
  // finalisation 
  return;
  on-error;
  // 💥 hooreur !
  clear pLivres
  snd-msg *escape ('Horreur ! dans ' + %trim(%proc()));
  return *off;
  endmon;
end-proc;


dcl-proc getUrl;
  dcl-pi *N;
    pUrl like(gLongueVariable);
  end-pi;
  //initialisation
  clear pUrl;
  //traitement
  pUrl = 
  'https://fakerestapi.azurewebsites.net/api/v1/';
  //finalisation
  return; 
end-proc; 
dcl-proc getHeader;
  dcl-pi *N;
    pHeader like(gLongueVariable);
  end-pi;
  //initialisation
  clear pHeader;
  //traitement
  pHeader = 
  '{"header": "Accept,application/json", ' + 
  '"header": "Content-Type,application/json",' +
  '"signalErrors" : "true"}';
  //finalisation
  return; 
end-proc; 
