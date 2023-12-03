import '../resource/Resource.dart';

class Recipe {
  final String key;
  final dynamic resourceOrToolKey;
  final int quantity;

  Recipe(this.key, this.resourceOrToolKey, this.quantity);
}

class ToolType {
  final String key;
  final String name;

  ToolType(this.key, this.name);
}

enum ToolTypeKey { tool, material, component, building }

final Map<ToolTypeKey, String> toolTypeData = {
  ToolTypeKey.tool: 'Outil',
  ToolTypeKey.material: 'Matériau',
  ToolTypeKey.component: 'Composant',
  ToolTypeKey.building: 'Bâtiment'
};

class Tool {
  final ToolKey key;
  final String name;
  final List<Recipe> recipes;
  final ToolType type;
  final String description;
  int quantity = 0;

  Tool(this.key, this.name, this.recipes, this.type, this.description);
}

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

final Map<ToolKey, Map<String, dynamic>> toolData = {
  ToolKey.axe: {
    'name': 'Hache',
    'recipe': [
      {'key': ResourceKey.wood, 'quantity': 2},
      {'key': ResourceKey.iron, 'quantity': 2}
    ],
    'typeKey': ToolTypeKey.tool,
    'description': 'Un outil utile',
  },
  ToolKey.pickaxe: {
    'name': 'Pioche',
    'recipe': [
      {'key': ResourceKey.wood, 'quantity': 2},
      {'key': ResourceKey.iron, 'quantity': 3}
    ],
    'typeKey': ToolTypeKey.tool,
    'description': 'Un outil utile',
  },
  ToolKey.ironIngot: {
    'name': 'Lingot de fer',
    'recipe': [
      {'key': ResourceKey.iron, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.material,
    'description': 'Un lingot de fer pur',
  },
  ToolKey.ironPlate: {
    'name': 'Plaque de fer',
    'recipe': [
      {'key': ResourceKey.iron, 'quantity': 3},
    ],
    'typeKey': ToolTypeKey.material,
    'description': 'Une plaque de fer pour la construction',
  },
  ToolKey.copperIngot: {
    'name': 'Lingot de cuivre',
    'recipe': [
      {'key': ResourceKey.copper, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.material,
    'description': 'Une plaque de fer pour la construction',
  },
  ToolKey.metalRod: {
    'name': 'Tige en métal',
    'recipe': [
      {'key': ToolKey.ironIngot, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.material,
    'description': 'Une tige de métal',
  },
  ToolKey.threadElectric: {
    'name': 'Fil électrique',
    'recipe': [
      {'key': ToolKey.copperIngot, 'quantity': 1},
    ],
    'typeKey': ToolTypeKey.component,
    'description':
        'Un fil électrique pour fabriquer des composants électroniques',
  },
  ToolKey.miner: {
    'name': 'Mineur',
    'recipe': [
      {'key': ToolKey.ironPlate, 'quantity': 10},
      {'key': ToolKey.threadElectric, 'quantity': 5},
    ],
    'typeKey': ToolTypeKey.building,
    'description': 'Un bâtiment qui permet d’automatiser le minage',
  },
  ToolKey.foundry: {
    'name': 'Fonderie',
    'recipe': [
      {'key': ToolKey.threadElectric, 'quantity': 5},
      {'key': ToolKey.metalRod, 'quantity': 8},
    ],
    'typeKey': ToolTypeKey.building,
    'description': 'Un bâtiment qui permet d’automatiser la production.',
  },
};

enum ToolGamePlay {
  tripleMineWood,
  tripleMineOres,
  unblockTools,
  ironToCopper,
  oreInIngot
}
