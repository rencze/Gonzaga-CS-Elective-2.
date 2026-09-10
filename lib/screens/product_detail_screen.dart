import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/products.dart';
import '../models/product.dart';
import '../state/cart_controller.dart';
import '../state/cart_inherited.dart';
import '../widgets/product_image.dart';
import '../widgets/product_reviews.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/shop_navigation.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  @override
  void didUpdateWidget(covariant ProductDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.productId != widget.productId) _quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    final product = products.where((p) => p.id == widget.productId).firstOrNull;
    final cart = CartInherited.of(context);
    final theme = Theme.of(context);
    final remaining =
        CartController.maxQuantity - cart.quantityOf(widget.productId);
    final quantity = _quantity.clamp(
      1,
      remaining.clamp(1, CartController.maxQuantity),
    );
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final overview = product == null
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                label: Text(product.category),
                side: BorderSide.none,
                backgroundColor: theme.colorScheme.primaryContainer,
                labelStyle: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(product.name, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),
              RatingSummary(product: product),
              const SizedBox(height: 16),
              Text(
                formatPrice(product.price),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: product.highlights
                    .map(
                      (highlight) => Chip(
                        avatar: Icon(product.icon, size: 18),
                        label: Text(highlight),
                        backgroundColor: theme.colorScheme.surfaceContainerLow,
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 20,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Quantity', style: theme.textTheme.titleMedium),
                  QuantityStepper(
                    quantity: quantity,
                    maximum: remaining.clamp(1, CartController.maxQuantity),
                    enabled: remaining > 0,
                    onIncrement: () => setState(() => _quantity = quantity + 1),
                    onDecrement: () => setState(() => _quantity = quantity - 1),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${cart.quantityOf(widget.productId)} in cart \u00b7 Maximum ${CartController.maxQuantity} per product',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 28),
              _DescriptionAndReviews(product: product),
            ],
          );
    return Scaffold(
      appBar: AppBar(
        leading: const ShopBackButton(),
        title: const Text('Product details'),
        actions: const [CartButton(), SizedBox(width: 16)],
      ),
      body: product == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search_off, size: 56),
                  const SizedBox(height: 16),
                  const Text('Product not found'),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Browse products'),
                  ),
                ],
              ),
            )
          : SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: wide ? 1072 : 560),
                    child: wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: _Photo(product: product),
                              ),
                              const SizedBox(width: 40),
                              Expanded(flex: 5, child: overview),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _Photo(product: product),
                              const SizedBox(height: 20),
                              overview,
                            ],
                          ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: product == null
          ? null
          : ShopBottomBar(
              child: _PurchaseBar(
                total: itemSubtotal(product.price, quantity),
                atLimit: remaining == 0,
                onAdd: () {
                  cart.add(product.id, quantity: quantity);
                  setState(() => _quantity = 1);
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        persist: false,
                        duration: const Duration(seconds: 3),
                        content: Text(
                          quantity == 1
                              ? '${product.name} added to cart'
                              : '$quantity \u00d7 ${product.name} added to cart',
                        ),
                        action: SnackBarAction(
                          label: 'View cart',
                          onPressed: () => context.push('/cart'),
                        ),
                      ),
                    );
                },
              ),
            ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: AspectRatio(
      aspectRatio: 4 / 3,
      child: ProductImage(product: product, decorative: true),
    ),
  );
}

class _DescriptionAndReviews extends StatelessWidget {
  const _DescriptionAndReviews({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('About this product', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      Text(product.details, style: Theme.of(context).textTheme.bodyMedium),
      const Divider(height: 40),
      ProductReviews(product: product),
    ],
  );
}

class _PurchaseBar extends StatelessWidget {
  const _PurchaseBar({
    required this.total,
    required this.atLimit,
    required this.onAdd,
  });
  final double total;
  final bool atLimit;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amount = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total', style: theme.textTheme.bodySmall),
        Text(
          formatPrice(total),
          key: const ValueKey('product-total'),
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
    final action = FilledButton.icon(
      onPressed: atLimit ? null : onAdd,
      icon: const Icon(Icons.add_shopping_cart),
      label: Text(atLimit ? 'Maximum quantity reached' : 'Add to Cart'),
    );
    return LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth < 420
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [amount, const SizedBox(height: 12), action],
            )
          : Row(
              children: [
                Expanded(child: amount),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: action),
              ],
            ),
    );
  }
}
