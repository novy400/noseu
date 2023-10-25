-- find a bug in FakeRestApi cf openApi https://fakerestapi.azurewebsites.net/index.html
values http_get('https://fakerestapi.azurewebsites.net/api/v1/Authors');
SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/Authors', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                firstname VARCHAR(132) PATH 'lax $.firstName',
                lastname VARCHAR(132) PATH 'lax $.lastName'
                )
        ) AS a
    where lastname is null
    ORDER BY id
    ;
SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/Books', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title',
                description VARCHAR(132) PATH 'lax $.description',
                nombrePages INTEGER PATH 'lax $.pageCount'
                )
        ) AS a
    ORDER BY id
    ; 
-- un livre sans photos ❓.  
 SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/CoverPhotos', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                idBook INTEGER PATH 'lax $.idBook', 
                url VARCHAR(132) PATH 'lax $.url'
                )
        ) AS a
    ORDER BY id
    ; 
-- les deux 
with BOOKS as (
    SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/Books', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title',
                description VARCHAR(132) PATH 'lax $.description',
                nombrePages INTEGER PATH 'lax $.pageCount'
                )
        ) AS a
    ),
    PHOTOS as (
     SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/CoverPhotos', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                idBook INTEGER PATH 'lax $.idBook', 
                url VARCHAR(132) PATH 'lax $.url'
                )
        ) AS a
    
    )
    select b.*,p.* from books b join photos p on b.id = p.idBook;
-- un bug 
with BOOKS as (
    SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/Books', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title',
                description VARCHAR(132) PATH 'lax $.description',
                nombrePages INTEGER PATH 'lax $.pageCount'
                )
        ) AS a
    ),
    PHOTOS as (
     SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/CoverPhotos', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                idBook INTEGER PATH 'lax $.idBook', 
                url VARCHAR(132) PATH 'lax $.url'
                )
        ) AS a
    
    )
    select b.*,p.* from books b left exception join photos p on b.id = p.idBook;   
-- tant pis on en crée un  
-- TODO: requête à implémenter   
with BOOKS as (
    SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/Books', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title',
                description VARCHAR(132) PATH 'lax $.description',
                nombrePages INTEGER PATH 'lax $.pageCount'
                )
        ) AS a
    ),
    PHOTOS as (
     SELECT *
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/CoverPhotos', ''),
            '$'
            COLUMNS(
                id INTEGER PATH 'lax $.id', 
                idBook INTEGER PATH 'lax $.idBook', 
                url VARCHAR(132) PATH 'lax $.url'
                )
        ) AS a
    where idBook <> 101
    )
    select b.*,p.* from books b left exception join photos p on b.id = p.idBook;   
 -- liste des books
 SELECT a.id, a.titre
    FROM JSON_TABLE(
            HTTP_GET('https://fakerestapi.azurewebsites.net/api/v1/Books',
            '{"header": "Accept,application/json","header": "Content-Type,application/json","signalErrors" : "true"}'),
            '$' COLUMNS(
                id INTEGER PATH 'lax $.id', 
                titre VARCHAR(132) PATH 'lax $.title'
                ) ERROR on error
                ) as a
    order by a.id ;   
