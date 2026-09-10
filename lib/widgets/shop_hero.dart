import 'package:flutter/material.dart';

class ShopHero extends StatelessWidget {
  const ShopHero({super.key, required this.onShop});
  final VoidCallback onShop;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 600;
      final dark = Theme.of(context).brightness == Brightness.dark;
      final text = Theme.of(context).textTheme;
      final colors = Theme.of(context).colorScheme;
      final foreground = colors.onSurface;
      final surface = colors.surface;
      final accent = colors.primary;
      final padding = compact ? 20.0 : 36.0;
      return ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/images/hero.png',
                fit: BoxFit.cover,
                alignment: compact
                    ? const Alignment(.5, 0)
                    : Alignment.centerRight,
                excludeFromSemantics: true,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      surface.withValues(alpha: .97),
                      surface.withValues(alpha: .92),
                      surface.withValues(alpha: dark ? .45 : .02),
                    ],
                    stops: const [0, .42, 1],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: SizedBox(
                width: compact
                    ? constraints.maxWidth * .72
                    : constraints.maxWidth * .53,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'EVERYDAY, UPGRADED',
                        style: text.labelSmall?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Small upgrades.',
                      style: text.headlineMedium?.copyWith(
                        fontSize: compact ? 28 : 42,
                        height: 1.06,
                        color: foreground,
                      ),
                    ),
                    Text(
                      'Better days.',
                      style: text.headlineMedium?.copyWith(
                        fontSize: compact ? 28 : 42,
                        height: 1.06,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Good tech. Less effort. Essentials for work, study, and everything in between.',
                      style: text.bodyLarge?.copyWith(
                        fontSize: compact ? 14 : 17,
                        height: 1.45,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: onShop,
                      style: FilledButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 16,
                        ),
                      ),
                      child: Wrap(
                        spacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text('Shop Essentials'),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
