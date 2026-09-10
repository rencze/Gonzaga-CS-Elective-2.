import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'state/cart_controller.dart';
import 'state/favorites_controller.dart';
import 'state/cart_inherited.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  final CartController _cart = CartController();
  final FavoritesController _favorites = FavoritesController();
  ThemeMode _themeMode = ThemeMode.light;

  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = createRouter(
      onThemeToggle: _toggleTheme,
      cart: _cart,
      favorites: _favorites,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _cart.dispose();
    _favorites.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartInherited(
      cart: _cart,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Tech Shop',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        routerConfig: _router,
      ),
    );
  }
}
