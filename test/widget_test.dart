import 'package:flutter_test/flutter_test.dart';
import 'package:gonzaga_activity_1/main.dart';

void main() {
  testWidgets('Shop app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ShopApp());

    expect(find.text('Tech Shop'), findsOneWidget);
  });
}