import 'package:flutter/material.dart';

class Resource {
  final String name;
  final Color color;
  final String description;
  int quantity = 0;

  Resource(this.name, this.color, this.description);
}

const List<Map<String, dynamic>> resourceData = [
  {'name': 'Bois', 'color': '#967969', 'description': 'Du bois brut'},
  {
    'name': 'Minerai de fer',
    'color': '#ced4da',
    'description': 'Du minerai de fer brut'
  },
  {
    'name': 'Minerai de cuivre',
    'color': '#d9480f',
    'description': 'Du minerai de cuivre brut'
  },
  {'name': 'Charbon', 'color': '#000000', 'description': 'Du minerai de charbon'},
];