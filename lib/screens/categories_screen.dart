import 'package:flutter/material.dart';
import 'men_screen.dart';
import 'women_screen.dart';
import 'kids_screen.dart';
import 'accessories_screen.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: const Text("Men"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const MenScreen())); }),
        ListTile(title: const Text("Women"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const WomenScreen())); }),
        ListTile(title: const Text("Kids"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const KidsScreen())); }),
        ListTile(title: const Text("Accessories"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const AccessoriesScreen())); }),
      ],
    );
  }
}