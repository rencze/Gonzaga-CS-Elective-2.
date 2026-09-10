import 'package:flutter/widgets.dart';
import 'cart_controller.dart';

class CartInherited extends InheritedNotifier<CartController> {
  const CartInherited({
    super.key,
    required CartController cart,
    required super.child,
  }) : super(notifier: cart);
  static CartController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartInherited>()!.notifier!;
}
