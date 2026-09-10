import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/shop_colors.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({super.key, required this.product, this.compact = false});
  final Product product;
  final bool compact;
  static String labelFor(Product product, {bool compact = false}) => compact
      ? '${product.rating.toStringAsFixed(1)} (${product.reviews.length} samples)'
      : '${product.rating.toStringAsFixed(1)} \u00b7 ${product.reviews.length} sample reviews';

  @override
  Widget build(BuildContext context) => Semantics(
    label:
        '${product.rating.toStringAsFixed(1)} out of 5, ${product.reviews.length} sample reviews',
    child: ExcludeSemantics(
      child: compact
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: ShopColors.of(context).rating,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    labelFor(product, compact: true),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            )
          : Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _Stars(rating: product.rating),
                Text(
                  labelFor(product),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
    ),
  );
}

class _Stars extends StatelessWidget {
  const _Stars({required this.rating});
  final double rating;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(
      5,
      (index) => Icon(
        rating >= index + 1
            ? Icons.star
            : rating >= index + .5
            ? Icons.star_half
            : Icons.star_border,
        size: 20,
        color: ShopColors.of(context).rating,
      ),
    ),
  );
}

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('Sample reviews', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 6),
      Text(
        'Illustrative feedback for this demo shop.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(height: 16),
      for (final review in product.reviews)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        review.author,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Semantics(
                        label: '${review.rating} out of 5 stars',
                        child: ExcludeSemantics(
                          child: _Stars(rating: review.rating.toDouble()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    review.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review.comment,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  );
}
