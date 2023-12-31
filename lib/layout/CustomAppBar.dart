import 'package:flutter/material.dart';

/// AppBar de l'application avec un [pageTitle] personnalisé
/// Cette AppBar permet de naviguer entre les différents écrans
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;

  const CustomAppBar({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(pageTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.construction),
          onPressed: () {
            Navigator.pushNamed(context, '/tools');
          },
        ),
        IconButton(
          icon: const Icon(Icons.inventory),
          onPressed: () {
            Navigator.pushNamed(context, '/inventory');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
