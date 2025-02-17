import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Forex button triggers data fetch', (tester) async {
    bool isDataFetching = false;

    // Mock the button tap action to simulate data fetching
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForexButton(
            onPressed: () {
              isDataFetching = true;
            },
          ),
        ),
      ),
    );

    // Verify the button is rendered
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the button and verify if isDataFetching is set to true
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(isDataFetching, true);
  });
}
