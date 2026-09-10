import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/shop_colors.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    this.decorative = false,
  });
  final Product product;
  final bool decorative;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ShopColors.of(context).productBackground(product.id),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (decorative)
            Positioned(
              top: -48,
              left: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ShopColors.of(context).productAccent(product.id),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              product.imageAsset,
              fit: BoxFit.contain,
              semanticLabel: product.name,
              errorBuilder: (_, error, stack) => Semantics(
                label: product.name,
                image: true,
                child: Center(
                  child: Icon(
                    product.icon,
                    size: 40,
                    color: ShopColors.of(context).imageForeground,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
