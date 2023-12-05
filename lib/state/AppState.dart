import 'package:clicker_game/resource/Resource.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  /// Map des [Resource] du jeu
  Map<ResourceKey, Resource> resources = {};
  /// Map des [Tool] du jeu
  Map<ToolKey, Tool> tools = {};

  /// Remplis la valeur initiale des [resources]
  void fillResources(Map<ResourceKey, Resource> resourcesToFill) {
    resources = resourcesToFill;
    notifyListeners();
  }

  /// Remplis la valeur initiale des [tools]
  void fillTools(Map<ToolKey, Tool> toolsToFill) {
    tools = toolsToFill;
    notifyListeners();
  }

  /// Incrémente une ressource en prenant en compte les éventuels multiplicateurs
  void incrementResource(Resource resource) {
    int toolMultiplier = 1;

    if (resource.key == ResourceKey.wood &&
        tools.containsKey(ToolKey.axe) &&
        tools[ToolKey.axe]!.quantity > 0) {
      toolMultiplier = tools[ToolKey.axe]!.quantity * 3;
    } else if ((resource.key == ResourceKey.iron ||
            resource.key == ResourceKey.copper) &&
        tools.containsKey(ToolKey.pickaxe) &&
        tools[ToolKey.pickaxe]!.quantity > 0) {
      toolMultiplier = tools[ToolKey.pickaxe]!.quantity * 5;
    }

    resource.quantity += toolMultiplier;
    notifyListeners();
  }

  /// Créer un [Tool] à partir de [Resource] et de [Tool] 
  void createTool(Tool tool) {
    bool resourcesAvailable = checkResourcesAvailability(tool.recipes);

    if (resourcesAvailable) {
      consumeResources(tool.recipes);
      increaseToolQuantity(tool);
      unblockFirstBlockedTool(tool);
      notifyListeners();
    }
  }

  /// Débloque le premier [Tool] de la liste
  void unblockFirstBlockedTool(Tool tool) {

    if(tool.key != ToolKey.metalRod && tool.key != ToolKey.copperIngot){
      return; 
    }

    bool foundBlocked = false;

    tools.forEach((key, tool) {
      if (tool.blocked && !foundBlocked) {
        tool.blocked = false;
        foundBlocked = true;
      }
    });
  }

  /// Vérifie si une recette est possible (disponibilité quantité)
  bool checkResourcesAvailability(List<Recipe> recipes) {
    for (var recipe in recipes) {
      dynamic key = recipe.resourceOrToolKey;
      int quantity = recipe.quantity;

      if (key is ResourceKey && resources[key] != null) {
        if (resources[key]!.quantity < quantity) {
          return false;
        }
      } else if (key is ToolKey) {
        if (tools[key] != null && tools[key]!.quantity < quantity) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }

  /// Consomme les quantités d'une recette
  void consumeResources(List<Recipe> recipes) {
    for (var recipe in recipes) {
      dynamic key = recipe.resourceOrToolKey;
      int quantity = recipe.quantity;

      if (key is ResourceKey && resources[key] != null) {
        resources[key]!.quantity -= quantity;
      } else if (key is ToolKey) {
        if (tools[key] != null) {
          tools[key]!.quantity -= quantity;
        }
      }
    }
  }

  /// Augmente la quantité d'un outil
  void increaseToolQuantity(Tool tool) {
    tools[tool.key]!.quantity++;
  }

  /// Récupère le nom d'une ressource ou d'un outil depuis une key
  String getRessourceOrToolNameFromKey(dynamic key) {
    if (key is ResourceKey && resources[key] != null) {
      return resources[key]!.name;
    } else if (key is ToolKey && tools[key] != null) {
      return tools[key]!.name;
    } else {
      return '';
    }
  }
}
