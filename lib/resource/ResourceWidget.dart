import 'package:clicker_game/state/AppState.dart';
import 'package:flutter/material.dart';
import 'Resource.dart';
import 'package:provider/provider.dart';

class ResourceWidget extends StatelessWidget {
  final Resource resource;

  const ResourceWidget({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Container(
        color: resource.color,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              resource.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              resource.quantity.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                appState.incrementResource(resource);
              },
              child: const Text('Miner'),
            ),
          ]),
        ),
      ),
    );
  }
}
