# Gestion des livres

la gestion des livres permet : 
- de lister tous les livres.
- d'afficher les détails d'un livre.

Cette application utilisait anciennement des tables internes pour stocker les livres.
```mermaid 
erDiagram
    BOOK ||--o{ PHOTO : recouvre
    BOOK {
        int code        
        string titre
        string description
        int nombreDePages

    }
    PHOTO {
        int code
        string url
    }

```
## Ancienne architecture
```mermaid    
classDiagram

    class BOOK{
        int code        
        string titre
        string description
        int nombreDePages
    }
    class PHOTO{
        int code
        string url
    }
    BOOK <|-- LIVRELST
    PHOTO <|-- LIVREDET
    BOOK <|-- LIVREDET
    LIVREDET : + in code
```
## Modernisation de l'architecture

Cette table a été remplacée par l'appel d'une API externe.
Cette API est exposée sous la forme de web services de type REST.   
[FakerestAPi](https://fakerestapi.azurewebsites.net/index.html)


## Nouvelle architecture
```mermaid    
classDiagram
    class APIREST{
        GET https://fakerestapi.azurewebsites.net/api/v1/Books
        GET https://fakerestapi.azurewebsites.net/api/v1/CoverPhotos
    }
    class LIVRERST{
      livresrst_item
      livrerst_detail
      livrerst_getall()
      livrerst_getbycode()
    }
    APIREST <|-- LIVRERST
    LIVRERST <|-- LIVRELST
    LIVRERST <|-- LIVREDET
    LIVREDET : + in code
    class LIVRERST_TST{
        test_LIVRERST_GETALL()
        test_LIVRERST_GETBYCODE()
    }
    LIVRERST <|-- LIVRERST_TST
    RPGUNIT <|-- LIVRERST_TST
```