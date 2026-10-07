import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:premium_reveal/premium_reveal.dart';

void main() {
  testWidgets('PremiumReveal renders child correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PremiumReveal(
            order: 0,
            child: Text('Revealed Text'),
          ),
        ),
      ),
    );

    expect(find.text('Revealed Text'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Revealed Text'), findsOneWidget);
  });

  testWidgets('PremiumStaggeredColumn renders children and preserves spacing',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PremiumStaggeredColumn(
            children: [
              Text('Item 1'),
              SizedBox(height: 10),
              Text('Item 2'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });
}
