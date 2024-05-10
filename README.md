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

## Version APK pour Téléphones Android

Si vous préférez installer l'application directement sur un téléphone Android plutôt que de la construire localement, une version APK est disponible dans le dossier annexes du dépôt GitHub. Vous pouvez télécharger cette APK et l'installer sur votre téléphone en suivant les instructions habituelles pour l'installation d'applications depuis des sources inconnues.

En cas de problème lors de l'installation ou de l'exécution de l'application, n'hésitez pas à consulter la [documentation Flutter](https://docs.flutter.dev/), qui est très détaillée et offre des solutions à de nombreuses questions courantes.

> [!TIP]
> Un compte utilisateur de test y est prérempli (test@test.com).

## Installation en local du projet

Pour exécuter l'application localement, suivez ces étapes :

1. Assurez-vous d'avoir installé Flutter sur votre système. 

> Suivez les instructions de la [documentation Flutter](https://docs.flutter.dev/get-started/install) **OU** suivez le fichier tutoriel nommé **"installation_flutter"** qui est dans le dossier annexes du dépôt GitHub.

2. Clonez ou téléchargez ce dépôt sur votre machine locale.

> **Commande git :** git clone https://github.com/YanisVroland/Mobile_MyTechLib.git

3. Ouvrez le projet dans votre IDE.

> Si vous n'en avez pas, vous pouvez suivre le [tutoriel Flutter](https://docs.flutter.dev/get-started/editor?tab=androidstudio).

4. Exécutez la commande suivante dans votre terminal pour installer les dépendances.
```
  flutter pub get
```

5. **Optionnel :** Si vous voulez lier l'API en local, configurez le projet avant de le démarrer (Par défaut le projet est relié à une API hébergée).

> Pour que l'application fonctionne en local, il faut démarrer le [projet API](https://github.com/YanisVroland/API_MyTechLib) (suivre le README du projet).

> Une fois fait, modifiez l'URL dans le fichier /lib/app/theme/app_const.dart
```
  static const String baseUrl = 'http://votre_ip_pc:3000'; 

  // Si vous utilisez un émulateur de téléphone sur votre machine

  static const String baseUrl = 'http://localhost:3000'; 
```

6. Ouvrez votre émulateur de téléphone ou branchez votre téléphone au PC.

7. Lancez l'application en exécutant la commande suivante ou en cliquant sur le bouton start de votre IDE.
```
  flutter run 
```

> [!NOTE]
> Version nécessaire au projet : Flutter (3.13.6), Dart (3.1.3)

**REMARQUE** : En cas de problème lors de l'installation, n'hésitez pas à utiliser l'APK mis à disposition (voir partie : *Version APK pour Téléphones Android*)

## Structure du projet
