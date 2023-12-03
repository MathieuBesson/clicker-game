import 'package:clicker_game/tool/Tool.dart';
import 'package:clicker_game/tool/ToolScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resource/ResourceScreen.dart';
import 'resource/Resource.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MaterialApp(
          title: 'Clicker game',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/': (context) => const ResourcesScreen(),
            '/tools': (context) => const ToolScreen(),
          },
        ));
  }
}

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
    resource.quantity++;
    notifyListeners();
  }

  void createTool(Tool tool) {
    bool resourcesAvailable = checkResourcesAvailability(tool.recipes);

    if (resourcesAvailable) {
      consumeResources(tool.recipes);
      increaseToolQuantity(tool);
      notifyListeners();
    }
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
        // Si vous stockez les outils de la même manière dans AppState
        if (tools[key] != null) {
          tools[key]!.quantity -= quantity;
        }
      }
    }
  }

  void increaseToolQuantity(Tool tool) {
    if (tools[tool.key] != null) {
      tools[tool.key]!.quantity++;
    } else {
      tool.quantity = 1;
      tools[tool.key] = tool;
    }
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
    print('Valeur de maVariable : $key');
    if (key is ResourceKey && resources[key] != null) {
      return resources[key]!.name;
    } else if (key is ToolKey && tools[key] != null) {
      return tools[key]!.name;
    } else {
      return ''; 
    }
  }
}
