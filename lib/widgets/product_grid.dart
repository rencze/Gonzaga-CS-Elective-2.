import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../state/favorites_controller.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.favorites,
  });
  final List<Product> products;
  final FavoritesController favorites;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = switch (MediaQuery.sizeOf(context).width) {
        >= 900 => 4,
        >= 600 => 3,
        _ => 2,
      };
      final width = (constraints.maxWidth - (columns - 1) * 16) / columns;
      final height = products
          .map((p) => ProductCard.heightFor(context, p, width))
          .fold(0.0, (a, b) => a > b ? a : b);
      return ListenableBuilder(
        listenable: favorites,
        builder: (context, child) => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: height,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              isFavorite: favorites.contains(product.id),
              onFavoriteToggle: () => favorites.toggle(product.id),
              onTap: () => context.push('/product/${product.id}'),
            );
          },
        ),
      );
    },
  );
}
