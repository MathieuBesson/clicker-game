import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resource/ResourcesScreen.dart';
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/': (context) => ResourcesScreen(),
            '/recipes': (context) => ResourcesScreen(),
          },
        ));
  }
}

class AppState extends ChangeNotifier {
  List<Resource> resources = [];

  void fillResources(List<Resource> resourcesToFill) {
    resources = resourcesToFill;
    notifyListeners();
  }

  void incrementResource(Resource resource) {
    resource.quantity++;
    notifyListeners();
  }
}
