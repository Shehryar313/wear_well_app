import 'package:flutter/material.dart';
import 'men_screen.dart';
import 'women_screen.dart';
import 'kids_screen.dart';
import 'accessories_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Men"),
              Tab(text: "Women"),
              Tab(text: "Kids"),
              Tab(text: "Accessories"),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                MenScreen(),
                WomenScreen(),
                KidsScreen(),
                AccessoriesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}