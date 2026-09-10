import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/products.dart';
import '../state/favorites_controller.dart';
import '../widgets/product_grid.dart';
import '../widgets/shop_hero.dart';
import '../widgets/shop_navigation.dart';
import '../widgets/shop_brand.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.favorites,
  });
  final VoidCallback onThemeToggle;
  final FavoritesController favorites;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _featuredKey = GlobalKey();

  void _shop() {
    final section = _featuredKey.currentContext;
    if (section != null) {
      Scrollable.ensureVisible(
        section,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 350),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const ShopBrand(),
        actions: [
          IconButton(
            tooltip: 'Search products',
            onPressed: () => context.push('/products?search=1'),
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 6),
          IconButton(
            tooltip: dark ? 'Switch to light theme' : 'Switch to dark theme',
            onPressed: widget.onThemeToggle,
            icon: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode),
          ),
          const SizedBox(width: 6),
          const CartButton(),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShopHero(onShop: _shop),
                    const SizedBox(height: 28),
                    Wrap(
                      key: _featuredKey,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      children: [
                        Text(
                          'Featured Products',
                          style: theme.textTheme.titleLarge,
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: theme.textTheme.labelMedium,
                          ),
                          onPressed: () => context.push('/products'),
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(Icons.arrow_forward, size: 20),
                          label: const Text('View all products'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ProductGrid(
                      products: products,
                      favorites: widget.favorites,
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
}
