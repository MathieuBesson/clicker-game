import 'package:clicker_game/main.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToolWidget extends StatelessWidget {
  final Tool tool;

  const ToolWidget({super.key, required this.tool});
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    bool isAvailable = provider.checkBuildAvailability(tool.recipes);

    return Card(
      margin: EdgeInsets.all(10),
      color: isAvailable ? null : Colors.grey[400],
      elevation: isAvailable ? 3 : 0,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${tool.quantity} ${tool.name}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            buildRichText("Description : ", tool.description, context),
            buildRichText("Type : ", tool.type.name, context),
            buildRichText("Recette : ", tool.quantity.toString(), context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tool.recipes.map((recipe) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: buildRichText(
                      "- ${recipe.quantity} x ",
                      provider.getRessourceOrToolNameFromKey(
                          recipe.resourceOrToolKey),
                      context),
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(isAvailable ? Colors.blue : Colors.grey),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: isAvailable
                  ? () {
                      var appState =
                          Provider.of<AppState>(context, listen: false);
                      appState.createTool(tool);
                    }
                  : null,
              child: Text('Construire'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRichText(String boldText, String text, BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: boldText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text,
          ),
        ],
      ),
    );
  }
}
