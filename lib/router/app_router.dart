import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/catalog_screen.dart';
import '../state/favorites_controller.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_confirmation_screen.dart';
import '../state/cart_controller.dart';
import '../screens/product_detail_screen.dart';

GoRouter createRouter({
  required VoidCallback onThemeToggle,
  required CartController cart,
  required FavoritesController favorites,
  String initialLocation = '/',
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/products',
        builder: (_, state) => CatalogScreen(
          favorites: favorites,
          focusSearch: state.uri.queryParameters['search'] == '1',
        ),
      ),
      GoRoute(path: '/cart', builder: (_, state) => const CartScreen()),
      GoRoute(
        path: '/checkout',
        redirect: (_, state) => cart.hasItems ? null : '/',
        builder: (_, state) => CheckoutConfirmationScreen(cart: cart),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomeScreen(onThemeToggle: onThemeToggle, favorites: favorites);
        },
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;

          return ProductDetailScreen(productId: productId);
        },
      ),
    ],
  );
}
