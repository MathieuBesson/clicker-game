import '../resource/Resource.dart';

/// Représente une recette à la base de la création d'un [Tool]
class Recipe {
  final String key;
  final dynamic resourceOrToolKey;
  final int quantity;

  Recipe(this.key, this.resourceOrToolKey, this.quantity);
}

/// Représente un type de [Tool]
class ToolType {
  final String key;
  final String name;

  ToolType(this.key, this.name);
}

/// Enums listant les types de [Tool]
enum ToolTypeKey { tool, material, component, building }

/// Données initiales des types de [Tool]
final Map<ToolTypeKey, String> toolTypeData = {
  ToolTypeKey.tool: 'Outil',
  ToolTypeKey.material: 'Matériau',
  ToolTypeKey.component: 'Composant',
  ToolTypeKey.building: 'Bâtiment'
};

/// Représente un outil dans le jeu.
class Tool {
  final ToolKey key;
  final String name;
  final List<Recipe> recipes;
  final ToolType type;
  final String description;
  final String gamePlayDescription;
  bool blocked;
  int quantity = 0;

  Tool(this.key, this.name, this.recipes, this.type, this.description,
      this.blocked, this.gamePlayDescription);
}

/// Enums listant les [Tool] (pour identification)
enum ToolKey {
  axe,
  pickaxe,
  ironIngot,
  ironPlate,
  copperIngot,
  metalRod,
  threadElectric,
  miner,
  foundry
}

/// Map de donnée initiale des [Tool]
final Map<ToolKey, Map<String, dynamic>> toolData = {
  ToolKey.axe: {
    'name': 'Hache',
    'recipe': [
      {'key': ResourceKey.wood, 'quantity': 2},
      {'key': ResourceKey.iron, 'quantity': 2}
    ],
    'typeKey': ToolTypeKey.tool,
    'gamePlayDescription': 'Récolter le bois 3 par 3',
    'blocked': false,
    'description': 'Un outil utile',
  },
  ToolKey.pickaxe: {
    'name': 'Pioche',
    'recipe': [
      {'key': ResourceKey.wood, 'quantity': 2},
      {'key': ResourceKey.iron, 'quantity': 3}
    ],
    'typeKey': ToolTypeKey.tool,
    'gamePlayDescription': 'Récolter les minerais 5 par 5',
    'blocked': false,
    'description': 'Un outil utile',
  },
  ToolKey.ironIngot: {
    'name': 'Lingot de fer',
    'recipe': [
      {'key': ResourceKey.iron, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.material,
    'gamePlayDescription': 'Débloque d’autres recettes',
    'blocked': false,
    'description': 'Un lingot de fer pur',
  },
  ToolKey.ironPlate: {
    'name': 'Plaque de fer',
    'recipe': [
      {'key': ResourceKey.iron, 'quantity': 3},
    ],
    'typeKey': ToolTypeKey.material,
    'gamePlayDescription': 'Débloque d’autres recettes',
    'blocked': false,
    'description': 'Une plaque de fer pour la construction',
  },
  ToolKey.copperIngot: {
    'name': 'Lingot de cuivre',
    'recipe': [
      {'key': ResourceKey.copper, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.material,
    'gamePlayDescription': 'Débloque d’autres recettes',
    'blocked': true,
    'description': 'Une plaque de fer pour la construction',
  },
  ToolKey.metalRod: {
    'name': 'Tige en métal',
    'recipe': [
      {'key': ToolKey.ironIngot, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.material,
    'gamePlayDescription': 'Débloque d’autres recettes',
    'blocked': false,
    'description': 'Une tige de métal',
  },
  ToolKey.threadElectric: {
    'name': 'Fil électrique',
    'recipe': [
      {'key': ToolKey.copperIngot, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.component,
    'gamePlayDescription': 'Débloque d’autres recettes',
    'blocked': true,
    'description':
        'Un fil électrique pour fabriquer des composants électroniques',
  },
};

/// Enums de liste des types de gameplay
enum ToolGamePlay {
  threefoldMineWood,
  fiveFoldMineOres,
  unblockTools,
}
