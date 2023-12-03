import 'package:clicker_game/main.dart';
import 'package:clicker_game/resource/Resource.dart';
import 'package:clicker_game/tool/ToolWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Tool.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({super.key});

  @override
  ToolScreenState createState() => ToolScreenState();
}

class ToolScreenState extends State<ToolScreen> {
  @override
  void initState() {
    super.initState();
    createToolMap(toolData);
  }

  void createToolMap(Map<ToolKey, Map<String, dynamic>> toolData) {
    var tools = toolData.entries.map((entry) {
      final toolKey = entry.key;
      final data = entry.value;

      final name = data['name'] as String;
      final description = data['description'] as String;
      final recipeData = data['recipe'] as List<dynamic>;

      final recipes = recipeData.map((recipeItem) {
        final key = recipeItem['key'];
        final quantity = recipeItem['quantity'] as int;

        dynamic resourceOrToolKey;
        if (key is ResourceKey) {
          resourceOrToolKey = key;
        } else if (key is ToolKey) {
          resourceOrToolKey = key;
        }

        return Recipe('recipeKey', resourceOrToolKey, quantity);
      }).toList();

      final typeKey = data['typeKey'] as ToolTypeKey;
      final type = getToolTypeFromKey(typeKey);

      return MapEntry(
          toolKey, Tool(toolKey, name, recipes, type, description));
    }).toList();

    var appState = Provider.of<AppState>(context, listen: false);
    appState.fillTools(Map.fromEntries(tools));
  }

  ToolType getToolTypeFromKey(ToolTypeKey key) {
    return ToolType(key.toString(), toolTypeData[key]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outils'),
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
        itemCount: Provider.of<AppState>(context).tools.length,
        itemBuilder: (BuildContext context, int index) {
          final toolMap = Provider.of<AppState>(context).tools;
          final toolKey = toolMap.keys.elementAt(index);
          final tool = toolMap[toolKey];

          return ToolWidget(tool: tool!);
        },
      ),
    );
  }
}