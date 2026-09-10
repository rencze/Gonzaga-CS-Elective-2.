import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/cart_item.dart';
import '../state/cart_controller.dart';
import '../widgets/shop_navigation.dart';

class CheckoutConfirmationScreen extends StatefulWidget {
  const CheckoutConfirmationScreen({super.key, required this.cart});
  final CartController cart;
  @override
  State<CheckoutConfirmationScreen> createState() =>
      _CheckoutConfirmationScreenState();
}

class _CheckoutConfirmationScreenState
    extends State<CheckoutConfirmationScreen> {
  late final List<CartItem> _order;
  @override
  void initState() {
    super.initState();
    _order = widget.cart.items;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order confirmation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ShopStatusIcon(icon: Icons.check_rounded),
                const SizedBox(height: 20),
                Text(
                  'Thank you!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your order has been placed.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is a demo order. No payment was collected.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Order summary',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        for (final item in _order)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: theme.textTheme.titleMedium,
                                ),
                                Text(
                                  '${item.quantity} \u00d7 ${formatPrice(item.product.price)}',
                                ),
                                Text(
                                  formatPrice(
                                    itemSubtotal(
                                      item.product.price,
                                      item.quantity,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Divider(),
                        Text(
                          'Total  ${formatPrice(cartTotal(_order))}',
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ShopBottomBar(
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Continue shopping'),
          ),
        ),
      ),
    );
  }
}
