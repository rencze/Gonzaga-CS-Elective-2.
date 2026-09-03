import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/products.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Shop'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: onThemeToggle,
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth =
              constraints.maxWidth > 1200
                  ? 1200.0
                  : constraints.maxWidth;

          int columnCount;

          if (contentWidth >= 900) {
            columnCount = 4;
          } else if (contentWidth >= 600) {
            columnCount = 3;
          } else {
            columnCount = 2;
          }

          final cardHeight = contentWidth >= 900
              ? 300.0
              : contentWidth >= 600
                  ? 280.0
                  : 250.0;

          return Center(
            child: SizedBox(
              width: contentWidth,
              height: constraints.maxHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    Text(
                      'Products',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Browse our latest tech accessories',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columnCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: cardHeight,
                        ),
                        itemBuilder: (context, index) {
                          final product =
                              products[index];

                          return ProductCard(
                            product: product,
                            onTap: () {
                              context.push(
                                '/product/${product.id}',
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}