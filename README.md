# clicker_game

## Installation

- Cloner le projet avec git
- Installer les dépendances du projet

```bash
flutter pub get
```

## Lancer l'application

```bash
flutter run
```

## Choix de design/Implémentation

Pour cette appplication j'ai pris le partie d'organiser mon code autour de mes types de données : Les `Ressource` et les `Tool` (recettes dans l'énoncé). On retrouve ainsi des dossiers les dossiers suivants : `resource`, `tool`, `state`, `layout`

Les dossiers `resource` et `tool` sont découpés en au moins 3 types de fichiers les widget classiques se finissant par `Widget` (widgets de présentation principalement) les fichiers de classe métier sans suffix et les écrans avec le suffix `Screen`. Ce découpage permet de différencier les vues des classes métiers. La logique de global de state est géré dans le `AppState.dart` du dossier `state`

Pour chaque entité, je suis parti d'une map qui représente la structure la plus basique de donnée. En partant de cette map, au premier chargement des écrans je créer les données initiales du state avec des classes spécifiques.

Cette gestion global permet de mettre à jour le state global et d'impacter tous les widgets utilisant les données du state globale.

## Spécificités de l'UI

Sur la page `Outils`, les outils grisés n'ont pas assez de ressources pour être buildés. 
Les outils avec la mention `INDISPONIBLE` sont bloqués et pourront être déploqués avec 

## Difficultés 

### Reflexion autour de l'implémentation de la solution finale

Au départ j'ai eu du mal à visualiser comment structurer les données. Puisque c'est leur structure qui va déterminer l'algorithme à développer. Une fois cette phase d'étude fastidieuse mais nécéssaire le développement à été plus simple.  

### Difficultés en terme de temps

L'énoncé et les attendus était trop élevée par rapport au temps pour développer l'application et créer la documentation.

### UI pour android

Je suis parti au départ sur une application client lourd pour me concentrer sur l'algo et non sur un build pour une plateforme visée. Je n'ai donc pas eu le temps à la fin d'adapter l'UI au petits écrans.

### Pas le temps de faire la question 8.

Je n'ai malheureusement pas eu le temps d'implémenter ma réponse à la question 8. mais si j'avais eu le temps j'aurais ajouté un bouton apparaissant de manière aléatoire, 5 seconde toutes les 2 minutes et qui permet de faire x10 sur toutes ces ressources.

## Flutter doc

Je n'ai pas non plus eu le temps de faire de la flutter doc et de générer une visualisation de celle-ci

## Références/Ressources

- [Documentation de Flutter](https://docs.flutter.dev/) : La documentatin officiel de Flutter qui permet de vérifier les syntaxes de l'outil, les possibilités et fonctionnalités
- [Stackoverflow](https://stackoverflow.com/) : Plateforme d'échange et d'entraide en informatique
- [Documentation de Dart](https://dart.dev/guides) : La documentatin officiel de Dart pour vérifier les spécificités du langage


Reste à faire : 

- Commenter le code
- Rendre le projet et le questionnaire + dépot code veille
