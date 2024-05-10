# Projet Flutter - Application Mobile de Répertoire de Projets "MyTechLib"

*VROLAND Yanis*
*M2 Cyber*

## Introduction

Ce projet est une application mobile développée avec Flutter pour faciliter la gestion des informations de projet pour les entreprises. L'application vise à offrir une interface conviviale et des fonctionnalités avancées pour aider les utilisateurs à organiser, suivre et collaborer sur différents projets.

## Fonctionnalités principales

- **Authentification sécurisée :** Les utilisateurs peuvent créer un compte et se connecter de manière sécurisée à l'application.
- **Gestion des comptes utilisateur :** Les utilisateurs peuvent créer et gérer leur profil personnel, y compris leurs informations de contact et leur photo de profil.
- **Gestion des entreprises :** Les utilisateurs peuvent ajouter, mettre à jour et supprimer des informations sur les entreprises associées aux projets.
- **Gestion des projets :** Les utilisateurs peuvent créer de nouveaux projets, mettre à jour les détails existants et visualiser des informations détaillées sur chaque projet.
- **Suivi des modifications de projet :** Une page dédiée permet aux utilisateurs de visualiser les modifications apportées aux projets au fil du temps.

## Instalation

Pour exécuter l'application localement, suivez ces étapes :

1. Assurez-vous d'avoir installé Flutter sur votre système. 

> Suivre les instructions de la [documentation Flutter](https://docs.flutter.dev/get-started/install) **OU** suivre le fichier tuto nomé **"installation_flutter"** qui est dans le dossier **annexes**.

2. Clonez ou télécharger ce dépôt sur votre machine locale.

> **Commande git :** git clone https://github.com/YanisVroland/Mobile_MyTechLib.git

3. Ouvrez le projet dans votre IDE

> Si vous n'en avez pas, vous pouvez suivre le [tuto flutter](https://docs.flutter.dev/get-started/editor?tab=androidstudio).

4. Exécutez **flutter pub get** dans votre terminal pour installer les dépendances.

5. Configurez le projet avant de le démarer

> Pour que l'application fonctionne en local il faut démmarer le [projet api](https://github.com/YanisVroland/API_MyTechLib) (suivre le README du projet).

> Une fois fait, modifier l'url dans le fichier /lib/app/theme/app_const.dart
```
app_const.dart

  static const String baseUrl = 'http://votre_ip_pc:3000'; (ou localhost si vous utilisez un émultateur de téléphone sur votre machine)
```

6. Lancez l'application en exécutant **flutter run**.
