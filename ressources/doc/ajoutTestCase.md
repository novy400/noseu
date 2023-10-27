## ajout d'un test case avec rpgunit
## Test ajout d'un test case avec rpgunit

### Description
Teste si la méthode `ajouterTestCase` ajoute correctement un nouveau test case à la suite de tests.

### Prérequis
- Avoir initialisé une instance de la classe `RpgUnit`.
- Avoir créé un test case valide.

### Étapes
1. Ajouter le test case à la suite de tests en appelant la méthode `ajouterTestCase`.
2. Exécuter la suite de tests en appelant la méthode `executerTests`.

### Résultat attendu
La suite de tests doit s'exécuter sans erreur et le nouveau test case doit être inclus dans la suite de tests.

### Code de test


## ajout d'un cas de test pour le detail d'un livre
```rpgle
LIVRERST_GETBYCODE(10);
```
ouvrir [le programme de test](../../src/qtstsrc/livrerst.tst.sqlrpgle) et ajouter un test case à la suite de tests.

```rpgle
dcl-proc  test_<nom_du_test> export;
  dcl-pi *N; 
  end-pi;
  // déclaration des variables  
  dcl-ds lLivres likeds(LIVRERST_Item) dim(1000);
  // initialisation des variables  
  clear lLivres;
  // appel de la procédure à tester  
  LIVRERST_GETALL(lLivres);
  // vérification des résultats  
  assert(lLivres(1).code > 0 : 'aucun livre trouvé !');
  assert(lLivres(1).code = 1 : 'code livre incorrect !');
end-proc;
```
![picture 0](../../images/07fdd4e72f68bb2454bc56587ce1349cad0d8f0a7d9fbc66f176e61ea8ff32ee.png)  

![picture 1](../../images/a8673c03246d73d08b5b17311d7d5a9f625ead1e966a72fe2e71c06eb0c61245.png)  

lancement 
![picture 2](../../images/d8622131196eb6461d6dbf28601bd072b9cf0ee60dfe9e0184a84a890f62ec09.png)  

![picture 3](../../images/b8306da07f5c3a9d6454763e800a6f6c44fd51022529bcdacb9ace81c8afa474.png)  
