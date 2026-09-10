import 'package:flutter/foundation.dart';
import '../data/products.dart';
import '../models/cart_item.dart';

double itemSubtotal(double price, int quantity) => price * quantity;
double cartTotal(Iterable<CartItem> items) =>
    items.fold(0, (sum, i) => sum + itemSubtotal(i.product.price, i.quantity));
String formatPrice(double price) {
  final parts = price.toStringAsFixed(2).split('.');
  final whole = parts.first.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+$)'),
    (match) => '${match[1]},',
  );
  return '\u20b1$whole.${parts.last}';
}

class CartController extends ChangeNotifier {
  static const maxQuantity = 10;
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);
  double get subtotal => cartTotal(_items);
  bool get hasItems => _items.isNotEmpty;
  int quantityOf(String id) => _items
      .where((i) => i.product.id == id)
      .fold(0, (sum, i) => sum + i.quantity);
  void add(String id, {int quantity = 1}) {
    if (quantity <= 0) return;
    if (quantityOf(id) > 0) {
      _change(id, quantity);
      return;
    }
    final product = products.where((p) => p.id == id).firstOrNull;
    if (product == null) return;
    _items.add(
      CartItem(product: product, quantity: quantity.clamp(1, maxQuantity)),
    );
    notifyListeners();
  }

  void increment(String id) => _change(id, 1);
  void decrement(String id) => _change(id, -1);
  void _change(String id, int delta) {
    final index = _items.indexWhere((i) => i.product.id == id);
    if (index < 0) return;
    final item = _items[index];
    final quantity = (item.quantity + delta).clamp(1, maxQuantity);
    if (quantity == item.quantity) return;
    _items[index] = CartItem(product: item.product, quantity: quantity);
    notifyListeners();
  }

  void remove(String id) {
    final count = _items.length;
    _items.removeWhere((i) => i.product.id == id);
    if (count != _items.length) notifyListeners();
  }

  void clear() {
    if (!hasItems) return;
    _items.clear();
    notifyListeners();
  }
}
