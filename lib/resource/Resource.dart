import 'package:flutter/material.dart';

class Resource {
  final ResourceKey key;
  final String name;
  final Color color;
  final String description;
  int quantity = 0;

  Resource(this.key, this.name, this.color, this.description);
}

enum ResourceKey { wood, iron, copper, coal }
final Map<ResourceKey, Map<String, dynamic>> resourceData = {
  ResourceKey.wood: {'name': 'Bois', 'color': '#967969', 'description': 'Du bois brut'},
  ResourceKey.iron: {
    'name': 'Minerai de fer',
    'color': '#ced4da',
    'description': 'Du minerai de fer brut'
  },
  ResourceKey.copper: {
    'name': 'Minerai de cuivre',
    'color': '#d9480f',
    'description': 'Du minerai de cuivre brut'
  },
  ResourceKey.coal: {
    'name': 'Charbon',
    'color': '#000000',
    'description': 'Du minerai de charbon'
  },
};
