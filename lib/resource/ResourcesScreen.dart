import 'package:clicker_game/main.dart';
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
    createResourceList(resourceData);
  }

  void createResourceList(List<Map<String, dynamic>> data) {
    final List<Resource> resources = [];

    for (var item in data) {
      String name = item['name'];
      Color color = parseColor(item['color']);
      String description = item['description'];

      Resource resource = Resource(name, color, description);
      resources.add(resource);
    }

    var appState = Provider.of<AppState>(context, listen: false);
    appState.fillResources(resources);
  }

  Color parseColor(String colorCode) {
    return Color(int.parse(colorCode.replaceAll('#', '0xFF')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/recipes');
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
          return ResourceWidget(
              resource: Provider.of<AppState>(context).resources[index]);
        },
      ),
    );
  }
}