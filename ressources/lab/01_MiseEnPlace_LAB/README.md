# Tutorial 1 Mise en place du lab. 
## Table des matières
- [Objectifs](#objectifs)  
- [Ressources](#ressources)  
- [Pré-Requis](#pré-requis)  
## Objectifs  
Ce TP utilise de nombreuses technologies (xml,http,rpg,sql,rest,...).  
Afin de faciliter les manipulations nous allons utiliser Visual studio Code.  
VSC (visual studio code) est un IDE universel et open source. 
Il est relativement rapide, peu gourmand et gratuit.  
Mais ce n'est pas son seul atout , il est extensible.  
Ainsi il peut facilement s'adapter aux besoins des utilisateurs (développeur, testeur, rédacteur de doc,.....) avec l'installation d'extensions disponible sur une [**market place**](https://marketplace.visualstudio.com/vscode)  

Pour ce faire nous avons de réaliser quelques manipulations et installations d'outils.  

Ainsi nous allons :  
- Installer visual studio code sur votre poste client.  
- Installer les différentes extensions nécessaires (code for IBMi) via un profile gist ?
- Ajouter un .profile et .bashrc  
- Configurer git  (?)  
- Cloner le dépôt [M13_P12] en local.  
- Configurer notre connexion  
- Configurer notre projet  
- Compiler notre premier programme  
- Lancer notre premier script sql  

## Ressources  
- Environnement  
- Temps : 45 mn.  
## Pré-Requis  
- Accéder à internet.  

## Énoncé  
### Etape 1 Installer el lancer Visual Studio Code sur le poste client.  
1. Rechercher Visual studio code sur votre poste client.  
![picture 1](../../../images/0ab6e8c0bd948aebc785bd62d6218ad7adb49f62c41a109aa6999240656bf1fe.png)  
si  : 
    - il existe passer en 4 pour le lancer.  
    - sinon passer en 2 pour l'installer.  
1. [Download Visual Studio Code](https://code.visualstudio.com/download)  
1. Lancer l'installation.  
🧐lors de l'installation ,choisissez l'option pour avoir vsc en clic droit et le raccourci sur le bureau.  
1. Ouvrer VSC et créer un dossier (ou vous voulez pour travailler)  
![picture 2](../../../images/27d4117231460b99b3e8208da6a3419454f1c5374297f7d444e01d5ccadd8ea2.png)  

![picture 3](../../../images/4682ed24f9fd933efc32369eef61f4da886bc27d720b84b770601d7cba26b250.png)  
![picture 4](../../../images/607f99e58f3854fc781e5cc60d0cbc2445286f500f6eb41ccccb7432d284fcf5.png)  

![picture 5](../../../images/4336c24de39c5c91abd7a6a923de1fcab3136015d2f3d81f9c7a023ca8343852.png)  

### Etape 2 Installer code for IBMi.  
1.installation des extensions via un profile.  
[profile Ansible](https://vscode.dev/profile/github/c06f3ba02b988ca7822e6b2aca0ac37f)  
![picture 6](../../../images/91da06f2d453fe14fa96c6c9a4428f380beca232d366f429d81f9ce5cf6a977f.png)  
```bash
CTRL-C 
https://vscode.dev/profile/github/c06f3ba02b988ca7822e6b2aca0ac37f
```  

![picture 7](../../../images/cf0d27f395909aae76f23da66fb6d416ef9c2918e8fa3b74771302b5b489feec.png)  
![picture 8](../../../images/0aabb3496b5b389b46317fc10051e76fcffad77f44edce0265eedb875769115d.png)  
![picture 9](../../../images/d4903f8e77edf07b70651a09581244c7ae8e91b044d74c053afc182c19807c10.png)  

### Etape 3 Se connecter à l'IBMi.  
![picture 10](../../../images/32b37e2eb2634d79eb179f0020a9ded4f411a3dc5052268b24ad2fb250820928.png)  
```yaml
connection name : `ceQueVousVoulez`
host ou IP: `HOST_NAME_IBMI`
userName : `VotreProfilIBMi`
password : `votrePasswordIBMi`
savePassword : ok 
```  

![picture 11](../../../images/19ebf03820ca57d8c5eb07cae6dd72e104ad56f38eaffc1f9cb20c876071484e.png)  

![picture 12](../../../images/c5b795bacd89b52791fec9db50196901c8585932cc49541d53da99a1353d2e89.png)  

![picture 13](../../../images/9609e1504eef7191d812b98d75c82995ddd43ae20d8266ec54a2d3471815bc9a.png)  

### Etape 4 configurer votre projet.  
1. création d'un filtre pour vos sources.  
1. ajout d'un profil.  
1. modification liste de bibliothèques *LIBL  
### Etape 5 Hello World.  
1. créer un dossier src  
![picture 15](../../../images/6ba1ce0a11bd722b3785536ffd91e0acf35834b1939e56a077f6f8d6ea9b6f10.png)  


1. créer un dossier qrpglesrc dans src  
![picture 16](../../../images/84cd4b4bb4e18856d8881e4d8bf34be4c18de4f91c3064464d0ed79de6094906.png)  


1. créer un fichier `hello.rpgle`  
![picture 17](../../../images/5c6d5e453cc51c9bf4a99def4ae8c4d78bd3e95686eb27316d954489d940b2be.png)  
1. écrire `**free` sur la premiere colonne de la première ligne.  
1. écrire  `main` sur la seconde ligne du fichier et taper `CTRL-SPACE` et 😀laisser faire la magie de `code for IBMi`  
![picture 19](../../../images/f65c826d490c30be4997211c96446652ee542058705187b5bb2e34155aaa32bd.png)  
![picture 20](../../../images/05a07172dcde6f8c5cce809258f4b37b084c9a5e5b8f08a328d35e384138138d.png)  
ajouter la ligne de code  
` dsply 'bonjour';`
sauvegarder via la touche  `CTRL-S`  
1. ajout des actions (compile,....)  
![picture 18](../../../images/cf96da3254975a80403fac275bfa453dcf9e3ad755fd33903b45975ca7ef9ad0.png)  
ou  
. appeler le menu des commandes de vsc via la touche `F1`  
![picture 21](../../../images/f82ca7b92df8fe7de7f82211f75124e4d9d35d83411f3785d11b26b41aefc977.png)  
puis 
. inscrivez `action` sur le prompt  
![picture 22](../../../images/2e48e81f00d7e2678f9cf201d5948795c1f60a2a27b7ff31b4dcb299dcae5391.png)  
. sélectionnez toutes les options  
![picture 23](../../../images/5c75bf075272576f857e5ea9ae01dbd796ae41a97c92a56a796a7ea75d67b9af.png)  
sauvegarder via la touche  `CTRL-S` et fermer le fichier  
![picture 24](../../../images/2d208bd58ad12f198fba68085e3453e10b77c9b2caadefd5d26d58ffe938a947.png)  
1. lancer la compile de hello  
![picture 25](../../../images/a884e8804069c537dd33bf967c442beacd7e2796e04bd1fa61575212a252ed8e.png)  
![picture 26](../../../images/509f89757a63dd1223f4be688b53611af47eb60d64d3f8b24a354dadd40d1a64.png)  

![picture 27](../../../images/dfc5d8348ee858befe78d6f2d23b11868a3693516cd4d8a88d3c1241439e22ea.png)  

![picture 28](../../../images/dffe500ee5de03d8e427ee6e11597c22b2759b2af68eec7b8f295d06e3459f71.png)  

### Etape 6 KO world !  
1. modifier le programme hello pour ajouter une erreur.  
    nous allons pour l'exemple utiliser une variable non définie  
```
dcl-proc main;
  dsply message;
end-proc;
```  
compiler !  
![picture 29](../../../images/b6d88707b770ccf9723ce603fe20352443c06403ab2eeca7a95af6b32c2df44d.png)  
![picture 30](../../../images/0b62dbdcf3cc02f67e5abae9bb36adddbca2eaf84498649b355322612a88d25a.png)  
![picture 31](../../../images/281f22456e92bbfbf99512214e0fd507e6aaaa01fcc019f3c19d7c96d40b82c5.png)  
![picture 32](../../../images/902a94687f6c1b93adf03b448ccc7e73d1ad40d81015e6c92bde29aab3841132.png)  

corriger et recompiler..  
![picture 33](../../../images/4cd26eafdcc472b70aa4f665ff0c930b4bba2837c93e7ef92efa70f633cb02b4.png)  

cool non  ?  


## Conclusion et feed-back  

## Correction  



# 💡💡💡💡Idées 
- 