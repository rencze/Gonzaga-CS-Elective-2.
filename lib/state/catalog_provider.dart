import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/products.dart';
import '../models/product.dart';

const catalogPageSize = 6;

final catalogControllerProvider =
    NotifierProvider<CatalogController, CatalogState>(CatalogController.new);

class CatalogState {
  const CatalogState({
    this.products = const [],
    this.loading = false,
    this.error,
    this.page = 0,
    this.pageCount = 1,
    this.totalCount = 0,
    this.minPrice = 0,
    this.maxPrice = 5000,
    this.query = '',
    this.category,
    this.favoriteIds = const {},
    this.favoritesOnly = false,
    this.source = CatalogSource.local,
  });

  final List<Product> products;
  final bool loading;
  final String? error;
  final int page;
  final int pageCount;
  final int totalCount;
  final double minPrice;
  final double maxPrice;
  final String query;
  final String? category;
  final Set<String> favoriteIds;
  final bool favoritesOnly;
  final CatalogSource source;

  CatalogState copyWith({
    List<Product>? products,
    bool? loading,
    String? error,
    bool clearError = false,
    int? page,
    int? pageCount,
    int? totalCount,
    double? minPrice,
    double? maxPrice,
    String? query,
    String? category,
    bool clearCategory = false,
    Set<String>? favoriteIds,
    bool? favoritesOnly,
    CatalogSource? source,
  }) => CatalogState(
    products: products ?? this.products,
    loading: loading ?? this.loading,
    error: clearError ? null : error ?? this.error,
    page: page ?? this.page,
    pageCount: pageCount ?? this.pageCount,
    totalCount: totalCount ?? this.totalCount,
    minPrice: minPrice ?? this.minPrice,
    maxPrice: maxPrice ?? this.maxPrice,
    query: query ?? this.query,
    category: clearCategory ? null : category ?? this.category,
    favoriteIds: favoriteIds ?? this.favoriteIds,
    favoritesOnly: favoritesOnly ?? this.favoritesOnly,
    source: source ?? this.source,
  );
}

enum CatalogSource { local, supabase }

class CatalogController extends Notifier<CatalogState> {
  SupabaseClient? get _client => Supabase.instance.client;

  @override
  CatalogState build() {
    final initial = _localPage(0, 0, 100000);
    Future.microtask(load);
    return initial;
  }

  Future<void> load({
    int? page,
    double? minPrice,
    double? maxPrice,
    String? query,
    String? category,
    bool clearCategory = false,
    Set<String>? favoriteIds,
    bool? favoritesOnly,
  }) async {
    final nextPage = page ?? state.page;
    final minimum = minPrice ?? state.minPrice;
    final maximum = maxPrice ?? state.maxPrice;
    final search = query ?? state.query;
    final selectedCategory = clearCategory ? null : category ?? state.category;
    final selectedFavorites = favoriteIds ?? state.favoriteIds;
    final selectedFavoritesOnly = favoritesOnly ?? state.favoritesOnly;
    state = state.copyWith(loading: true, clearError: true);
    try {
      final client = _client;
      if (client == null) {
        state = _localPage(
          nextPage,
          minimum,
          maximum,
          query: search,
          category: selectedCategory,
          favoriteIds: selectedFavorites,
          favoritesOnly: selectedFavoritesOnly,
        );
        return;
      }
      dynamic queryBuilder = client
          .from('products')
          .select(
            'id,name,description,price,image_asset,category,details,highlights',
          )
          .gte('price', minimum)
          .lte('price', maximum);
      if (search.trim().isNotEmpty) {
        queryBuilder = queryBuilder.ilike('name', '%${search.trim()}%');
      }
      if (selectedCategory != null) {
        queryBuilder = queryBuilder.eq('category', selectedCategory);
      }
      if (selectedFavoritesOnly) {
        queryBuilder = queryBuilder.inFilter('id', selectedFavorites);
      }
      final response = await queryBuilder
          .order('id')
          .range(
            nextPage * catalogPageSize,
            nextPage * catalogPageSize + catalogPageSize - 1,
          );
      final rows = (response as List).cast<Map<String, dynamic>>();
      dynamic countBuilder = client
          .from('products')
          .select('id')
          .gte('price', minimum)
          .lte('price', maximum);
      if (search.trim().isNotEmpty) {
        countBuilder = countBuilder.ilike('name', '%${search.trim()}%');
      }
      if (selectedCategory != null) {
        countBuilder = countBuilder.eq('category', selectedCategory);
      }
      if (selectedFavoritesOnly) {
        countBuilder = countBuilder.inFilter('id', selectedFavorites);
      }
      final countResponse = await countBuilder.count(CountOption.exact);
      final count = countResponse.count;
      final pages = (count / catalogPageSize).ceil().clamp(1, 1 << 30).toInt();
      final safePage = nextPage.clamp(0, pages - 1).toInt();
      state = state.copyWith(
        products: rows.map(_productFromRow).toList(),
        loading: false,
        page: safePage,
        pageCount: pages,
        totalCount: count,
        minPrice: minimum,
        maxPrice: maximum,
        query: search,
        category: selectedCategory,
        favoriteIds: selectedFavorites,
        favoritesOnly: selectedFavoritesOnly,
        source: CatalogSource.supabase,
        clearError: true,
      );
    } on Exception catch (error) {
      state = state.copyWith(
        loading: false,
        error: 'Could not load products from Supabase: $error',
      );
    }
  }

  CatalogState _localPage(
    int page,
    double minimum,
    double maximum, {
    String query = '',
    String? category,
    Set<String> favoriteIds = const {},
    bool favoritesOnly = false,
  }) {
    final terms = query
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((term) => term.isNotEmpty);
    final filtered = products
        .where(
          (product) =>
              product.price >= minimum &&
              product.price <= maximum &&
              terms.every(
                (term) =>
                    '${product.name} ${product.category} ${product.description}'
                        .toLowerCase()
                        .contains(term),
              ) &&
              (category == null || product.category == category) &&
              (!favoritesOnly || favoriteIds.contains(product.id)),
        )
        .toList();
    final pageCount = (filtered.length / catalogPageSize).ceil().clamp(
      1,
      1 << 30,
    );
    final safePage = page.clamp(0, pageCount - 1);
    final start = safePage * catalogPageSize;
    final end = (start + catalogPageSize).clamp(0, filtered.length);
    return CatalogState(
      products: filtered.sublist(start, end),
      page: safePage,
      pageCount: pageCount,
      totalCount: filtered.length,
      minPrice: minimum,
      maxPrice: maximum,
      query: query,
      category: category,
      favoriteIds: favoriteIds,
      favoritesOnly: favoritesOnly,
      source: CatalogSource.local,
    );
  }

  Product _productFromRow(Map<String, dynamic> row) => Product(
    id: row['id'].toString(),
    name: row['name'] as String,
    description: row['description'] as String? ?? '',
    price: (row['price'] as num).toDouble(),
    imageAsset: row['image_asset'] as String? ?? '',
    category: row['category'] as String? ?? 'Other',
    details: row['details'] as String? ?? row['description'] as String? ?? '',
    highlights: (row['highlights'] as List?)?.cast<String>() ?? const [],
    reviews: const [],
    icon: Icons.devices_other_outlined,
  );
}
