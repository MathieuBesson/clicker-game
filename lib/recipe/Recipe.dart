import 'package:flutter/material.dart';
import './../resource/Resource.dart';


class CostRecipe {
  final Resource resource
}

class Recipe {
  final String name;
  final Color color;
  final String description;
  int quantity = 0;

  Resource(this.name, this.color, this.description);
}

const List<Map<String, dynamic>> resourceData = [
  {'name': 'Bois', 'color': '#967969', 'description': 'Du bois brut'},
];