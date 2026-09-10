import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/cart_item.dart';
import '../state/cart_controller.dart';
import '../state/cart_inherited.dart';
import 'product_image.dart';
import 'quantity_stepper.dart';
import 'product_reviews.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = CartInherited.of(context);
    final product = item.product;
    final theme = Theme.of(context);
    final photo = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 72,
        height: 72,
        child: ProductImage(product: product),
      ),
    );
    final name = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: theme.textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        RatingSummary(product: product, compact: true),
        const SizedBox(height: 4),
        Text(
          '${formatPrice(product.price)} each',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
    final remove = IconButton(
      tooltip: 'Remove ${product.name}',
      style: IconButton.styleFrom(
        foregroundColor: theme.colorScheme.onSurfaceVariant,
      ),
      onPressed: () {
        cart.remove(product.id);
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              persist: false,
              duration: const Duration(seconds: 3),
              content: Text('${product.name} removed'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () => cart.add(product.id, quantity: item.quantity),
              ),
            ),
          );
      },
      icon: const Icon(Icons.delete_outline),
    );
    final stepper = QuantityStepper(
      quantity: item.quantity,
      onIncrement: () => cart.increment(product.id),
      onDecrement: () => cart.decrement(product.id),
    );
    final subtotal = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Subtotal', style: theme.textTheme.bodySmall),
        Text(
          formatPrice(itemSubtotal(product.price, item.quantity)),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Tooltip(
                    message: 'View ${product.name} details',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => context.push('/product/${product.id}'),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          photo,
                          const SizedBox(width: 12),
                          Expanded(child: name),
                        ],
                      ),
                    ),
                  ),
                ),
                remove,
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: .035),
              border: Border(
                top: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [stepper, subtotal],
            ),
          ),
        ],
      ),
    );
  }
}
