import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_controller.dart';
import 'product_image.dart';
import 'product_reviews.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });
  final Product product;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  static TextStyle? _priceStyle(TextTheme text) =>
      text.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w800);

  static double heightFor(BuildContext context, Product product, double width) {
    final text = Theme.of(context).textTheme;
    double measure(
      String value,
      TextStyle? style, {
      int? maxLines,
      double reserved = 0,
    }) {
      final painter = TextPainter(
        text: TextSpan(text: value, style: style),
        textDirection: Directionality.of(context),
        textScaler: MediaQuery.textScalerOf(context),
        maxLines: maxLines,
      )..layout(maxWidth: width - 28 - reserved);
      final height = painter.height;
      painter.dispose();
      return height;
    }

    final footerHeight = measure(
      formatPrice(product.price),
      _priceStyle(text),
      reserved: width >= 200 ? 32 : 0,
    );
    final ratingHeight = measure(
      RatingSummary.labelFor(product, compact: true),
      text.bodySmall,
      reserved: 22,
    );
    return 16 +
        (width - 16) * .75 +
        74 +
        measure(product.category, text.bodySmall, maxLines: 1) +
        measure(product.name, text.titleMedium, maxLines: 2) +
        measure(product.description, text.bodySmall, maxLines: 2) +
        (ratingHeight > 16 ? ratingHeight : 16) +
        (footerHeight > 20 ? footerHeight : 20);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shadowColor: theme.colorScheme.onSurface.withValues(alpha: .06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: .7),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        hoverColor: theme.colorScheme.primary.withValues(alpha: .04),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: ProductImage(product: product),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          tooltip: isFavorite
                              ? 'Remove ${product.name} from favorites'
                              : 'Save ${product.name}',
                          isSelected: isFavorite,
                          onPressed: onFavoriteToggle,
                          style: IconButton.styleFrom(
                            backgroundColor:
                                theme.colorScheme.surfaceContainerLow,
                            foregroundColor: theme.colorScheme.primary,
                          ),
                          icon: const Icon(Icons.favorite_border, size: 20),
                          selectedIcon: const Icon(Icons.favorite, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      RatingSummary(product: product, compact: true),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Divider(
                        height: 24,
                        color: theme.colorScheme.outlineVariant.withValues(
                          alpha: .65,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              formatPrice(product.price),
                              style: _priceStyle(
                                theme.textTheme,
                              )?.copyWith(color: theme.colorScheme.primary),
                            ),
                          ),
                          if (constraints.maxWidth >= 200) ...[
                            const SizedBox(width: 12),
                            ExcludeSemantics(
                              child: Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
