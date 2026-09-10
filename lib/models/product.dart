import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageAsset;
  final String category;
  final String details;
  final List<String> highlights;
  final List<ProductReview> reviews;
  final IconData icon;

  double get rating => reviews.isEmpty
      ? 0
      : reviews.fold(0, (sum, review) => sum + review.rating) / reviews.length;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    required this.category,
    required this.details,
    required this.highlights,
    required this.reviews,
    required this.icon,
  });
}

class ProductReview {
  const ProductReview({
    required this.author,
    required this.rating,
    required this.title,
    required this.comment,
  });
  final String author;
  final int rating;
  final String title;
  final String comment;
}
