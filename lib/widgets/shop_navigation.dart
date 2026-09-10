import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../state/cart_inherited.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});
  @override
  Widget build(BuildContext context) {
    final count = CartInherited.of(context).itemCount;
    return IconButton(
      tooltip: 'Open cart',
      onPressed: () => context.push('/cart'),
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}

class ShopBackButton extends StatelessWidget {
  const ShopBackButton({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: BackButton(
      onPressed: () => context.canPop() ? context.pop() : context.go('/'),
    ),
  );
}

class ShopBottomBar extends StatelessWidget {
  const ShopBottomBar({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.surfaceContainerLow,
    shape: Border(
      top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: child,
          ),
        ),
      ),
    ),
  );
}

class ShopStatusIcon extends StatelessWidget {
  const ShopStatusIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          color: colors.secondaryContainer,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Icon(icon, size: 56, color: colors.onSecondaryContainer),
      ),
    );
  }
}
