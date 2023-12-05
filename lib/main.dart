import 'package:clicker_game/tool/InventoryScreen.dart';
import 'package:clicker_game/state/AppState.dart';
import 'package:clicker_game/tool/ToolScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resource/ResourceScreen.dart';

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
          /// Router de l'app
          routes: {
            '/': (context) => const ResourcesScreen(),
            '/tools': (context) => const ToolScreen(),
            '/inventory': (context) => const InventoryScreen(),
          },
        ));
  }
}
