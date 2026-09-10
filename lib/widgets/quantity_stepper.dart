import 'package:flutter/material.dart';
import '../state/cart_controller.dart';

class QuantityStepper extends StatefulWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.maximum = CartController.maxQuantity,
    this.enabled = true,
  });
  final int quantity;
  final int maximum;
  final bool enabled;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late int _quantity;
  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _quantity = widget.quantity;
  }

  void _adjust(int delta) {
    final next = (_quantity + delta).clamp(1, widget.maximum);
    if (!widget.enabled || next == _quantity) return;
    setState(() => _quantity = next);
    delta > 0 ? widget.onIncrement() : widget.onDecrement();
  }

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        tooltip: 'Decrease quantity',
        onPressed: widget.enabled && _quantity > 1 ? () => _adjust(-1) : null,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        icon: const Icon(Icons.remove),
      ),
      Semantics(
        label: 'Quantity',
        value: '$_quantity',
        liveRegion: true,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: Text('$_quantity', textAlign: TextAlign.center),
        ),
      ),
      IconButton(
        tooltip: 'Increase quantity',
        onPressed: widget.enabled && _quantity < widget.maximum
            ? () => _adjust(1)
            : null,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        icon: const Icon(Icons.add),
      ),
    ],
  );
}
