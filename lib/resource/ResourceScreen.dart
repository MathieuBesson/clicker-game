import 'package:clicker_game/main.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:flutter/material.dart';
import 'Resource.dart';
import 'package:provider/provider.dart';
import 'ResourceWidget.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  ResourcesScreenState createState() => ResourcesScreenState();
}

class ResourcesScreenState extends State<ResourcesScreen> {
  @override
  void initState() {
    super.initState();
    createResourceMap(resourceData);
  }

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

  Color parseColor(String colorCode) {
    return Color(int.parse(colorCode.replaceAll('#', '0xFF')));
  }

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
      appBar: AppBar(
        title: const Text('Resources'),
        actions: [
          IconButton(
            icon: Icon(Icons.construction),
            onPressed: () {
              Navigator.pushNamed(context, '/tools');
            },
          ),
        ],
      ),
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
