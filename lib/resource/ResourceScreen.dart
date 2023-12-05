import 'package:clicker_game/layout/CustomAppBar.dart';
import 'package:clicker_game/state/AppState.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:flutter/material.dart';
import 'Resource.dart';
import 'package:provider/provider.dart';
import 'ResourceWidget.dart';

/// Écran de liste des [Resource] permettant de les miner 
class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  ResourcesScreenState createState() => ResourcesScreenState();
}

/// Class compagnon d'état lié à [ResourcesScreen]
class ResourcesScreenState extends State<ResourcesScreen> {
  @override
  void initState() {
    super.initState();
    createResourceMap(resourceData);
  }

  /// Crée des objets [Resource] à partir des données fournies,
  /// puis remplit la map de [Resource] dans le state de l'application [AppState].
  void createResourceMap(Map<ResourceKey, Map<String, dynamic>> data) {
    final Map<ResourceKey, Resource> resources = {};

    data.forEach((resourceOrToolKey, resourceInfo) {
      String name = resourceInfo['name'];
      Color color = parseColor(resourceInfo['color']);
      String description = resourceInfo['description'];

      Resource resource = Resource(resourceOrToolKey, name, color, description);
      resources[resourceOrToolKey] = resource;
    });

    var appState = Provider.of<AppState>(context, listen: false);
    appState.fillResources(resources);
  }

  /// Génère un objet [Color] à partir d'une couleur en hexadecimal
  Color parseColor(String colorCode) {
    return Color(int.parse(colorCode.replaceAll('#', '0xFF')));
  }

  /// Décide si il faut ou non afficher la ressource à l'écran 
  bool isAuthorizedToDisplay(Resource? resource) {
    var appState = Provider.of<AppState>(context, listen: false);

    if (resource!.key != ResourceKey.coal) {
      return true;
    }

    if (appState.tools.isEmpty) {
      return false;
    }

    return appState.tools[ToolKey.copperIngot]!.quantity > 1000 &&
        appState.tools[ToolKey.ironIngot]!.quantity > 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Resources'),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: Provider.of<AppState>(context).resources.length,
        itemBuilder: (BuildContext context, int index) {
          final resourceMap = Provider.of<AppState>(context).resources;
          final resourceOrToolKey = resourceMap.keys.elementAt(index);
          final resource = resourceMap[resourceOrToolKey];

          if (isAuthorizedToDisplay(resource)) {
            return ResourceWidget(resource: resource!);
          }
        },
      ),
    );
  }
}
