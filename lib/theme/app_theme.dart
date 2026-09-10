import 'package:flutter/material.dart';
import 'shop_colors.dart';

class AppTheme {
  static const primary = Color(0xFF5938E8);
  static final lightTheme = _build(Brightness.light);
  static final darkTheme = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final colors =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: brightness,
        ).copyWith(
          primary: dark ? const Color(0xFFC5B4FF) : primary,
          onPrimary: dark ? const Color(0xFF2E176D) : Colors.white,
          secondary: dark ? const Color(0xFFC5B4FF) : const Color(0xFF5938E8),
          onSecondary: dark ? const Color(0xFF00382F) : Colors.white,
          secondaryContainer: dark
              ? const Color(0xFF30294B)
              : const Color(0xFFEEE9FC),
          onSecondaryContainer: dark
              ? const Color(0xFFD5C9FF)
              : const Color(0xFF4D30B5),
          surface: dark ? const Color(0xFF141322) : const Color(0xFFF9FAFE),
          surfaceContainerLow: dark ? const Color(0xFF1D1C30) : Colors.white,
          surfaceContainer: dark
              ? const Color(0xFF25233A)
              : const Color(0xFFF1EDF9),
          surfaceContainerHighest: dark
              ? const Color(0xFF36324D)
              : const Color(0xFFEAE5F5),
          onSurface: dark ? const Color(0xFFF5F2FF) : const Color(0xFF16152B),
          onSurfaceVariant: dark
              ? const Color(0xFFBBB5CC)
              : const Color(0xFF686078),
          outlineVariant: dark
              ? const Color(0xFF39354E)
              : const Color(0xFFE6E0EF),
        );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      brightness: brightness,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
    return base.copyWith(
      extensions: [
        ShopColors(
          rating: dark ? const Color(0xFFFFCA62) : const Color(0xFF996000),
          imageForeground: const Color(0xFF59546C),
        ),
      ],
      scaffoldBackgroundColor: colors.surface,
      textTheme: base.textTheme.copyWith(
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
          height: 1.5,
        ),
        bodySmall: base.textTheme.bodySmall?.copyWith(
          color: colors.onSurfaceVariant,
          height: 1.4,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 72,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: colors.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colors.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 54),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: shape,
          textStyle: base.textTheme.labelLarge?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 50),
          shape: shape,
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(48, 48),
          backgroundColor: colors.surfaceContainer,
          foregroundColor: colors.primary,
          disabledForegroundColor: colors.onSurface.withValues(alpha: 0.30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: colors.secondary,
        textColor: colors.onSecondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceContainerLow,
        selectedColor: colors.secondaryContainer,
        checkmarkColor: colors.onSecondaryContainer,
        labelStyle: base.textTheme.labelMedium?.copyWith(
          color: colors.onSurface,
        ),
        side: BorderSide(color: colors.outlineVariant),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: 32,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: shape,
        backgroundColor: dark
            ? const Color(0xFFE8E0FF)
            : const Color(0xFF30234E),
        contentTextStyle: base.textTheme.bodyMedium?.copyWith(
          color: dark ? const Color(0xFF30234E) : Colors.white,
        ),
        actionTextColor: dark
            ? const Color(0xFF5130BD)
            : const Color(0xFFD5C9FF),
      ),
    );
  }
}
