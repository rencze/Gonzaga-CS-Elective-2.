import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {
  final Set<String> _ids = {};
  bool contains(String productId) => _ids.contains(productId);

  void toggle(String productId) {
    if (!_ids.add(productId)) _ids.remove(productId);
    notifyListeners();
  }
}
