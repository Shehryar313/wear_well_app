import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/product.dart';
import '../widgets/category_card.dart';
import '../utils/app_animations.dart';
import 'men_screen.dart';
import 'women_screen.dart';
import 'kids_screen.dart';
import 'accessories_screen.dart';

/// Categories screen with gradient cards and product counts.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Men',
        'icon': Icons.male_rounded,
        'colors': [const Color(0xFF4A90D9), const Color(0xFF357ABD)],
        'screen': const MenScreen(),
      },
      {
        'title': 'Women',
        'icon': Icons.female_rounded,
        'colors': [const Color(0xFFE86CA4), const Color(0xFFD4508B)],
        'screen': const WomenScreen(),
      },
      {
        'title': 'Kids',
        'icon': Icons.child_care_rounded,
        'colors': [const Color(0xFF4ECB71), const Color(0xFF3BAF5C)],
        'screen': const KidsScreen(),
      },
      {
        'title': 'Accessories',
        'icon': Icons.watch_rounded,
        'colors': [const Color(0xFFE8C547), const Color(0xFFD4A017)],
        'screen': const AccessoriesScreen(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shop by Category', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Expanded(
            child: AnimationLimiter(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: categories.length,
                itemBuilder: (ctx, i) {
                  final cat = categories[i];
                  final title = cat['title'] as String;
                  final count = sampleProducts.where((p) => p.category == title).length;

                  return AnimationConfiguration.staggeredGrid(
                    position: i,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 500),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: CategoryCard(
                          title: title,
                          icon: cat['icon'] as IconData,
                          productCount: count,
                          gradientColors: cat['colors'] as List<Color>,
                          onTap: () => Navigator.push(
                            context,
                            fadeRoute(cat['screen'] as Widget),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}