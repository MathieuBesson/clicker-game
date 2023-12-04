import 'package:clicker_game/resource/Resource.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Map<ResourceKey, Resource> resources = {};
  Map<ToolKey, Tool> tools = {};

  void fillResources(Map<ResourceKey, Resource> resourcesToFill) {
    resources = resourcesToFill;
    notifyListeners();
  }

  void fillTools(Map<ToolKey, Tool> toolsToFill) {
    tools = toolsToFill;
    notifyListeners();
  }

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

  void createTool(Tool tool) {
    bool resourcesAvailable = checkResourcesAvailability(tool.recipes);

    if (resourcesAvailable) {
      consumeResources(tool.recipes);
      increaseToolQuantity(tool);
      unblockFirstBlockedTool(tool);
      notifyListeners();
    }
  }

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

  void increaseToolQuantity(Tool tool) {
    tools[tool.key]!.quantity++;
  }

  bool checkBuildAvailability(List<Recipe> recipes) {
    for (var recipe in recipes) {
      dynamic key = recipe.resourceOrToolKey;
      int quantity = recipe.quantity;

      if (key is ResourceKey && resources[key] != null) {
        if (resources[key]!.quantity < quantity) {
          return false;
        }
      } else if (key is ToolKey && tools[key] != null) {
        if (tools[key]!.quantity < quantity) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }

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
