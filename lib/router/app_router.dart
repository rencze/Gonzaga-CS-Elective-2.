import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';

GoRouter createRouter({
  required VoidCallback onThemeToggle,
}) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomeScreen(
            onThemeToggle: onThemeToggle,
          );
        },
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;

          return ProductDetailScreen(
            productId: productId,
          );
        },
      ),
    ],
  );
}