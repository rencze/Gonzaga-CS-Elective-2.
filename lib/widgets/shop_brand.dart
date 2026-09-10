import 'package:flutter/material.dart';

class ShopBrand extends StatelessWidget {
  const ShopBrand({super.key});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        'lib/images/logo.png',
        width: 32,
        height: 32,
        excludeFromSemantics: true,
      ),
      const SizedBox(width: 8),
      const Flexible(
        child: Text('Tech Shop', maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    ],
  );
}
