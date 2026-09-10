import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/products.dart';
import '../state/cart_controller.dart';
import '../state/cart_inherited.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/shop_navigation.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = CartInherited.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final items = cart.items;
    final content = !cart.hasItems
        ? const _EmptyCart()
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, index) => const SizedBox(height: 16),
            itemBuilder: (_, index) => CartItemTile(
              key: ValueKey(items[index].product.id),
              item: items[index],
            ),
          );
    return Scaffold(
      appBar: AppBar(
        leading: const ShopBackButton(),
        title: Text('Your cart (${cart.itemCount})'),
      ),
      body: SafeArea(
        top: false,
        bottom: wide || !cart.hasItems,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: wide && cart.hasItems
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: content),
                      SizedBox(
                        width: 360,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: _CartSummary(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : content,
          ),
        ),
      ),
      bottomNavigationBar: wide || !cart.hasItems
          ? null
          : const ShopBottomBar(child: _CartSummary()),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExcludeSemantics(
                    child: SizedBox(
                      width: 248,
                      height: 104,
                      child: Row(
                        children: [
                          for (final product in [
                            products[0],
                            products[2],
                            products[5],
                          ])
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: ProductImage(product: product),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your cart is empty',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Find something that makes your everyday easier. Your picks will appear here.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.go('/products'),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward, size: 20),
                    label: const Text('Browse products'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _CartSummary extends StatelessWidget {
  const _CartSummary();
  @override
  Widget build(BuildContext context) {
    final cart = CartInherited.of(context);
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${cart.itemCount} ${cart.itemCount == 1 ? 'item' : 'items'} in your bag',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Semantics(
          liveRegion: true,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 16,
            children: [
              Text('Total', style: theme.textTheme.titleLarge),
              Text(
                formatPrice(cart.subtotal),
                key: const ValueKey('cart-total'),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: cart.hasItems ? () => context.go('/checkout') : null,
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Checkout'),
        ),
        const SizedBox(height: 8),
        Text(
          'Demo checkout \u00b7 No payment required',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
