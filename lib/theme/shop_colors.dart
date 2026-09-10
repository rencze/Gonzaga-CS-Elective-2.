import 'package:flutter/material.dart';

@immutable
class ShopColors extends ThemeExtension<ShopColors> {
  const ShopColors({required this.rating, required this.imageForeground});
  final Color rating;
  final Color imageForeground;

  static ShopColors of(BuildContext context) =>
      Theme.of(context).extension<ShopColors>()!;
  static const _backgrounds = {
    '1': Color(0xFFE3EFE8),
    '2': Color(0xFFF5E6EE),
    '3': Color(0xFFE3ECFA),
    '4': Color(0xFFF2EAE1),
    '5': Color(0xFFE5EEE3),
    '6': Color(0xFFECE5FC),
  };
  Color productBackground(String id) =>
      _backgrounds[id] ?? const Color(0xFFEEE9FC);
  Color productAccent(String id) =>
      Color.lerp(productBackground(id), Colors.black, .03)!;

  @override
  ShopColors copyWith({Color? rating, Color? imageForeground}) => ShopColors(
    rating: rating ?? this.rating,
    imageForeground: imageForeground ?? this.imageForeground,
  );
  @override
  ShopColors lerp(covariant ShopColors? other, double t) => other == null
      ? this
      : ShopColors(
          rating: Color.lerp(rating, other.rating, t)!,
          imageForeground: Color.lerp(
            imageForeground,
            other.imageForeground,
            t,
          )!,
        );
}
