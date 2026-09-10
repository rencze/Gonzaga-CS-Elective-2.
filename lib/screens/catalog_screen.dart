import 'package:flutter/material.dart';
import '../data/products.dart';
import '../state/favorites_controller.dart';
import '../widgets/product_grid.dart';
import '../widgets/shop_navigation.dart';

enum _SortOrder {
  featured('Featured'),
  priceLow('Price: low to high'),
  priceHigh('Price: high to low');

  const _SortOrder(this.label);
  final String label;
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    required this.favorites,
    this.focusSearch = false,
  });
  final FavoritesController favorites;
  final bool focusSearch;
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _search = TextEditingController();
  bool _favoritesOnly = false;
  String? _category;
  _SortOrder _sort = _SortOrder.featured;

  void _resetFilters() => setState(() {
    _search.clear();
    _category = null;
    _favoritesOnly = false;
  });
  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: const ShopBackButton(),
      title: const Text('All products'),
      actions: const [CartButton(), SizedBox(width: 12)],
    ),
    body: SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _search,
                    autofocus: widget.focusSearch,
                    onChanged: (_) => setState(() {}),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      labelText: 'Search products',
                      hintText: 'Try headphones or storage',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: () => setState(_search.clear),
                              icon: const Icon(Icons.close),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      ChoiceChip(
                        label: const Text('All'),
                        selected: _category == null,
                        onSelected: (_) => setState(() => _category = null),
                      ),
                      for (final category
                          in products.map((p) => p.category).toSet())
                        ChoiceChip(
                          label: Text(category),
                          selected: _category == category,
                          onSelected: (selected) => setState(
                            () => _category = selected ? category : null,
                          ),
                        ),
                      FilterChip(
                        label: const Text('Favorites'),
                        avatar: const Icon(Icons.favorite_border, size: 18),
                        selected: _favoritesOnly,
                        onSelected: (selected) =>
                            setState(() => _favoritesOnly = selected),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListenableBuilder(
                    listenable: widget.favorites,
                    builder: (context, child) {
                      final query = _search.text.trim().toLowerCase();
                      final terms = query.split(RegExp(r'\s+'));
                      final matches = products.where((p) {
                        final searchable =
                            '${p.name} ${p.category} ${p.description}'
                                .toLowerCase();
                        return terms.every(searchable.contains) &&
                            (_category == null || p.category == _category) &&
                            (!_favoritesOnly ||
                                widget.favorites.contains(p.id));
                      }).toList();
                      if (_sort != _SortOrder.featured) {
                        matches.sort(
                          (a, b) => _sort == _SortOrder.priceLow
                              ? a.price.compareTo(b.price)
                              : b.price.compareTo(a.price),
                        );
                      }
                      final noFavorites =
                          matches.isEmpty &&
                          _favoritesOnly &&
                          query.isEmpty &&
                          _category == null;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) => Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 16,
                              runSpacing: 16,
                              children: [
                                Semantics(
                                  liveRegion: true,
                                  child: Text(
                                    '${matches.length} ${matches.length == 1 ? 'product' : 'products'}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth < 340
                                      ? constraints.maxWidth
                                      : 240,
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Sort by',
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 4,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<_SortOrder>(
                                        value: _sort,
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(14),
                                        items: [
                                          for (final order in _SortOrder.values)
                                            DropdownMenuItem(
                                              value: order,
                                              child: Text(
                                                order.label,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() => _sort = value);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (matches.isNotEmpty &&
                              (_category != null ||
                                  _favoritesOnly ||
                                  query.isNotEmpty))
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: _resetFilters,
                                icon: const Icon(
                                  Icons.filter_alt_off_outlined,
                                  size: 18,
                                ),
                                label: const Text('Clear filters'),
                              ),
                            ),
                          const SizedBox(height: 20),
                          if (matches.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 48),
                              child: Column(
                                children: [
                                  Icon(
                                    _favoritesOnly
                                        ? Icons.favorite_border
                                        : Icons.search_off,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    noFavorites
                                        ? 'No favorites yet'
                                        : 'No matching products',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    noFavorites
                                        ? 'Tap a heart on a product to save it here.'
                                        : 'Try another search or clear your filters.',
                                    textAlign: TextAlign.center,
                                  ),
                                  TextButton(
                                    onPressed: _resetFilters,
                                    child: const Text('Show all products'),
                                  ),
                                ],
                              ),
                            )
                          else
                            ProductGrid(
                              products: matches,
                              favorites: widget.favorites,
                            ),
                        ],
                      );
                    },
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
