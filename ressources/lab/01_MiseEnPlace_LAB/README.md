# Mise en place du lab. 
## Table des matières
- [Objectifs](#objectifs)  
- [Pré-Requis](#pré-requis)  
- [Ressources](#ressources)  
- [Guide](#guide)
# Objectifs  
- Valider les pré-requis.
- Télécharger le projet de notre application depuis Github.
- Ouvrir notre projet dans Visual Studio Code. 
- Entrer dans l'aventure "YABUG".

# Ressources  
- [Download Visual Studio Code](https://code.visualstudio.com/download)  
- [Download git](https://git-scm.com/downloads)
- [Download IBM i ACS](https://www.ibm.com/support/pages/ibm-i-access-client-solutions)  
- [🙏Compte gratuit sur PUB400](https://www.pub400.com/)  
# Pré-Requis  
- Accéder à internet. 
- Accéder à un profil sur un IBMi via ssh.
- vscode installé sur votre poste.
- git installé sur votre poste.
- git configuré avec votre compte. 

# Guide  
## Etape 0 - Valider les pré-requis.
1. Accéder à un profil sur un IBMi via ssh.
    - Ouvrir un shell (powershell pour windows par exemple) 
    - Se Connecter à votre profil IBMi via SSH:
        - Remplacer **<profil>** par votre profil IBMi.  
        - Remplacer **<hostnameIBMi>** par le nom d'hôte de votre IBMi.
        - Ajouter -p 2222 pour pub400.com (port du ssh) sinon ne pas mettre de port.

        ```console
            ssh <profil>@<hostnameIBMi> -p 2222
        ```
    ![picture 0](../../../images/c2003da9828d69e71296f2151c8f94e6891ee80ceca665e75f459fa8a9679c50.png)  

1. Configurer git sur votre poste.  
    - Ouvrir un shell (powershell pour windows par exemple) 
    - Vérifier que git est bien installé.  
    ```console
        git --version
    ```
    ![picture 1](../../../images/c4e81a96703e13b60882890bcaac75cf362a56a6fda88a5a9bfa7f759dfda616.png)   
      - si KO  
        - installer git sur votre poste.  
        - [Download git](https://git-scm.com/downloads)
    - Vérifier la configuration de votre compte dans git.
    ```console
        git config --list
    ```  

    ![picture 2](../../../images/24e09b00b9def4f22afddd28a34d643d4ac1eeb98e8020d1edbd4f3dd61b2078.png)    

      - si KO  
        - configurer git avec votre compte. 
        ```console
                git config --global user.name "John Doe"
                git config --global user.email "johndoe@example.com"
        ```  

## Etape 1 - Télécharger le projet de notre application depuis Github.
  - Ouvrir un shell (powershell pour windows par exemple)
  - Se placer dans son répertoire de projets.  
  ```console
    cd <répertoire de travail>
  ```
  - cloner le dépôt git de notre application **YABUG**.  
  ```console
    git clone https://github.com/novy400/yabug.git
  ``` 
![picture 3](../../../images/06f3d893afdd25f9194dbd031008d7c0d8983e5a3a2fd19a9bba726af756fec5.png)  

## Etape 2 - Ouvrir notre projet dans Visual Studio Code.  
  - Ouvrir un shell (powershell pour windows par exemple)
  - Se placer dans sur notre projet.  
  ```console
    cd <répertoire de YABUG>
  ```
  - Ouvrir notre projet dans Visual Studio Code.  
  ```console
    code .
  ```
  - faire confiance !   
![picture 4](../../../images/86da4b73976fa48b3e39cde1d969f385c654a7e8399200eb9cbebf3de2b0a84f.png)  
  - installer les extensions recommandées.  
![picture 5](../../../images/67a1f7ea610c4184064aa6bbd6138367b71aa3d2dc9297f94fd3efca3e18ca5c.png)  
  - patienter pendant l'installation des extensions.  
![picture 6](../../../images/02049d61c49b65b4aa243e9718d19286d46df4edeb220b9d65c56a17efbb62d5.png)  
![picture 7](../../../images/00f442efcfc2d912d6f128b13d9b05fc944246c577aaa29d9ef6433cddcfe4d8.png) 
- relancer vsc via la touche **reload** devant une extension.
![picture 8](../../../images/872ba9b7e8d0fb992d0732c14cfc1923b76d72eac24f658aaa56a394d6a0d485.png)  

## Etape 3 - Entrer dans l'aventure "YABUG".
//TODO: un petit coup de pub pour YABUG via un dessin animé.😀
1. suivre le guide.

## Conclusion et feed-back  

## Correction  



# 💡💡💡💡Idées 
- 