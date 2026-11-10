import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {
  final Set<String> _ids = {};
  Set<String> get ids => Set.unmodifiable(_ids);
  bool contains(String productId) => _ids.contains(productId);

  void toggle(String productId) {
    if (!_ids.add(productId)) _ids.remove(productId);
    notifyListeners();
  }
}
