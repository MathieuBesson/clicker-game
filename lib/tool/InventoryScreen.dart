import 'package:clicker_game/layout/CustomAppBar.dart';
import 'package:clicker_game/state/AppState.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:clicker_game/tool/ToolWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Écran de liste des [Tool] construits  
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

/// Class compagnon d'état lié à [InventoryScreen]
class InventoryScreenState extends State<InventoryScreen> {
  late Map<ToolKey, Tool> tools = {};
  bool sortByQuantity = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tools = filterToolsNotEmpty();
  }

  /// Filtre les [Tool] du state global pour ne conserver que ceux ayant une quantité supérieur à 0
  Map<ToolKey, Tool> filterToolsNotEmpty() {
    return Map.fromEntries(Provider.of<AppState>(context)
        .tools
        .entries
        .where((entry) => entry.value.quantity > 0));
  }

  /// Tri les [Tool] par quantité récolté
  void sortByToolQuantity() {
    setState(() {
      sortByQuantity = true;
      tools = Map.fromEntries(tools.entries.toList()
        ..sort((a, b) => b.value.quantity.compareTo(a.value.quantity)));
    });
  }

  /// Tri les [Tool] par nom
  void sortByToolName() {
    setState(() {
      sortByQuantity = false;
      tools = Map.fromEntries(tools.entries.toList()
        ..sort((a, b) => a.value.name.compareTo(b.value.name)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(pageTitle: 'Inventaire'),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: sortByToolQuantity,
                child: Text('Trier par quantité'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: sortByToolName,
                child: Text('Trier par nom'),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: tools.length,
              itemBuilder: (BuildContext context, int index) {
                return ToolWidget(
                  tool: tools[tools.keys.elementAt(index)]!,
                  displayActions: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
