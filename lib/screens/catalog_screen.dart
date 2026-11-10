import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/catalog_provider.dart';
import '../state/favorites_controller.dart';
import '../widgets/product_grid.dart';
import '../widgets/shop_navigation.dart';

String formatPrice(double price) => '\u20b1${price.toStringAsFixed(0)}';

enum _SortOrder {
  featured('Featured'),
  priceLow('Price: low to high'),
  priceHigh('Price: high to low');

  const _SortOrder(this.label);
  final String label;
}

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({
    super.key,
    required this.favorites,
    this.focusSearch = false,
  });
  final FavoritesController favorites;
  final bool focusSearch;
  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _search = TextEditingController();
  bool _favoritesOnly = false;
  String? _category;
  _SortOrder _sort = _SortOrder.featured;
  RangeValues _priceRange = const RangeValues(0, 100000);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(catalogControllerProvider.notifier).load();
    });
  }

  void _resetFilters() {
    _search.clear();
    setState(() {
      _category = null;
      _favoritesOnly = false;
      _priceRange = const RangeValues(0, 100000);
    });
    ref
        .read(catalogControllerProvider.notifier)
        .load(
          page: 0,
          minPrice: 0,
          maxPrice: 100000,
          query: '',
          clearCategory: true,
          favoritesOnly: false,
          favoriteIds: widget.favorites.ids,
        );
  }

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
                    onChanged: (value) {
                      setState(() {});
                      ref
                          .read(catalogControllerProvider.notifier)
                          .load(
                            page: 0,
                            query: value,
                            favoriteIds: widget.favorites.ids,
                          );
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      labelText: 'Search products',
                      hintText: 'Try headphones or storage',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: () {
                                _search.clear();
                                setState(() {});
                                ref
                                    .read(catalogControllerProvider.notifier)
                                    .load(
                                      page: 0,
                                      query: '',
                                      favoriteIds: widget.favorites.ids,
                                    );
                              },
                              icon: const Icon(Icons.close),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.price_change_outlined),
                              const SizedBox(width: 8),
                              const Expanded(child: Text('Price range')),
                              Text(
                                '${formatPrice(_priceRange.start)} – ${formatPrice(_priceRange.end)}',
                              ),
                            ],
                          ),
                          RangeSlider(
                            min: 0,
                            max: 100000,
                            divisions: 200,
                            labels: RangeLabels(
                              formatPrice(_priceRange.start),
                              formatPrice(_priceRange.end),
                            ),
                            values: _priceRange,
                            onChanged: (value) =>
                                setState(() => _priceRange = value),
                            onChangeEnd: (value) => ref
                                .read(catalogControllerProvider.notifier)
                                .load(
                                  page: 0,
                                  minPrice: value.start,
                                  maxPrice: value.end,
                                  favoriteIds: widget.favorites.ids,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Consumer(
                    builder: (context, ref, child) {
                      final catalog = ref.watch(catalogControllerProvider);
                      final currentPage = catalog.page;
                      final pageCount = catalog.pageCount;
                      final catalogItems = catalog.products;
                      return ListenableBuilder(
                        listenable: widget.favorites,
                        builder: (context, child) {
                          final query = _search.text.trim().toLowerCase();
                          final matches = catalogItems.toList();
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
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  ChoiceChip(
                                    label: const Text('All'),
                                    selected: _category == null,
                                    onSelected: (_) =>
                                        setState(() => _category = null),
                                  ),
                                  for (final category in [
                                    'Accessories',
                                    'Audio',
                                    'Video',
                                    'Storage',
                                    'Gaming',
                                    'Mobile',
                                    'Office',
                                  ])
                                    ChoiceChip(
                                      label: Text(category),
                                      selected: _category == category,
                                      onSelected: (selected) {
                                        setState(
                                          () => _category = selected
                                              ? category
                                              : null,
                                        );
                                        ref
                                            .read(
                                              catalogControllerProvider
                                                  .notifier,
                                            )
                                            .load(
                                              page: 0,
                                              category: _category,
                                              clearCategory: _category == null,
                                              favoriteIds: widget.favorites.ids,
                                            );
                                      },
                                    ),
                                  FilterChip(
                                    label: const Text('Favorites'),
                                    avatar: const Icon(
                                      Icons.favorite_border,
                                      size: 18,
                                    ),
                                    selected: _favoritesOnly,
                                    onSelected: (selected) {
                                      setState(() => _favoritesOnly = selected);
                                      ref
                                          .read(
                                            catalogControllerProvider.notifier,
                                          )
                                          .load(
                                            page: 0,
                                            favoritesOnly: selected,
                                            favoriteIds: widget.favorites.ids,
                                          );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
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
                                        '${catalog.totalCount} ${catalog.totalCount == 1 ? 'product' : 'products'} · page has ${matches.length}',
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
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            items: [
                                              for (final order
                                                  in _SortOrder.values)
                                                DropdownMenuItem(
                                                  value: order,
                                                  child: Text(
                                                    order.label,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                      query.isNotEmpty ||
                                      catalog.minPrice > 0 ||
                                      catalog.maxPrice < 100000))
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 48,
                                  ),
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
                              if (catalog.loading)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              if (catalog.error != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    children: [
                                      Text(
                                        catalog.error!,
                                        textAlign: TextAlign.center,
                                      ),
                                      TextButton.icon(
                                        onPressed: () => ref
                                            .read(
                                              catalogControllerProvider
                                                  .notifier,
                                            )
                                            .load(),
                                        icon: const Icon(Icons.refresh),
                                        label: const Text('Retry'),
                                      ),
                                    ],
                                  ),
                                ),
                              if (matches.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 12,
                                    children: [
                                      IconButton(
                                        tooltip: 'Previous page',
                                        onPressed:
                                            currentPage == 0 || catalog.loading
                                            ? null
                                            : () => ref
                                                  .read(
                                                    catalogControllerProvider
                                                        .notifier,
                                                  )
                                                  .load(page: currentPage - 1),
                                        icon: const Icon(Icons.chevron_left),
                                      ),
                                      Text(
                                        'Page ${currentPage + 1} of $pageCount · ${catalog.totalCount} products',
                                      ),
                                      IconButton(
                                        tooltip: 'Next page',
                                        onPressed:
                                            currentPage + 1 >= pageCount ||
                                                catalog.loading
                                            ? null
                                            : () => ref
                                                  .read(
                                                    catalogControllerProvider
                                                        .notifier,
                                                  )
                                                  .load(page: currentPage + 1),
                                        icon: const Icon(Icons.chevron_right),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
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
