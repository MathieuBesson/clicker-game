import 'package:clicker_game/state/AppState.dart';
import 'package:clicker_game/tool/Tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget d'affichage d'un [Tool]
class ToolWidget extends StatelessWidget {
  final Tool tool;
  final bool displayActions;

  const ToolWidget({super.key, required this.tool, this.displayActions = true});
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);

    bool isAvailable = provider.checkResourcesAvailability(tool.recipes) && tool.blocked == false;

    return Card(
      margin: EdgeInsets.all(10),
      color: isAvailable ? null : Colors.grey[400],
      elevation: isAvailable ? 0 : 3,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${tool.quantity} ${tool.name}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            tool.blocked
                ? const Text(
                    "INDISPONIBLE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 8),
            buildRichText("Description : ", tool.description, context),
            buildRichText("Type : ", tool.type.name, context),
            buildRichText("GamePlay : ", tool.gamePlayDescription, context),
            buildRichText("Recette : ", tool.quantity.toString(), context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tool.recipes.map((recipe) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: buildRichText(
                      "- ${recipe.quantity} x ",
                      provider.getRessourceOrToolNameFromKey(
                          recipe.resourceOrToolKey),
                      context),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            displayActions
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isAvailable ? Colors.blue : Colors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: isAvailable
                        ? () {
                            var appState =
                                Provider.of<AppState>(context, listen: false);
                            appState.createTool(tool);
                          }
                        : null,
                    child: const Text('Construire'),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  /// Construit un widget avec un label en bold et un contenu texte classqiue
  Widget buildRichText(String boldText, String text, BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: boldText,
            style: const TextStyle(
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
