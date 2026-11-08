import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tca/main.dart';

void main() {
  testWidgets('App UI contains title, TextField, Dropdown, and Calculate/Convert button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify title in AppBar
    expect(find.text('Temperature Converter'), findsOneWidget);

    // Verify header in card
    expect(find.text('Temperature converter'), findsOneWidget);

    // Verify Degrees and Type labels
    expect(find.text('Degrees'), findsOneWidget);
    expect(find.text('Type'), findsOneWidget);

    // Verify TextField
    expect(find.byKey(const Key('temperature_input')), findsOneWidget);

    // Verify DropdownButton
    expect(find.byKey(const Key('conversion_dropdown')), findsOneWidget);

    // Verify Calculate / Convert button
    expect(find.byKey(const Key('calculate_button')), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
  });

  testWidgets('Dropdown contains both conversion options',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap dropdown to open menu
    await tester.tap(find.byKey(const Key('conversion_dropdown')));
    await tester.pumpAndSettle();

    // Verify both required options exist
    expect(find.text('Celsius to Fahrenheit (°C → °F)'), findsWidgets);
    expect(find.text('Fahrenheit to Celsius (°F → °C)'), findsWidgets);
  });

  testWidgets('Shows error message if TextField is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap Convert without entering any number
    await tester.tap(find.byKey(const Key('calculate_button')));
    await tester.pumpAndSettle();

    // Error message displayed
    expect(find.text('Please enter a temperature value'), findsOneWidget);
  });

  testWidgets('Shows error message if entered value is not a valid number',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Enter invalid non-numeric text
    await tester.enterText(find.byKey(const Key('temperature_input')), 'abc');
    await tester.tap(find.byKey(const Key('calculate_button')));
    await tester.pumpAndSettle();

    // Error message displayed
    expect(find.text('Please enter a valid number'), findsOneWidget);
  });

  testWidgets('Converts Celsius to Fahrenheit: F = (C * 9/5) + 32',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Default option is Celsius to Fahrenheit (°C → °F)
    // Test C = 100 -> F = (100 * 9/5) + 32 = 212.00 °F
    await tester.enterText(find.byKey(const Key('temperature_input')), '100');
    await tester.tap(find.byKey(const Key('calculate_button')));
    await tester.pumpAndSettle();

    expect(find.text('212.00 °F'), findsOneWidget);

    // Test C = 0 -> F = 32.00 °F
    await tester.enterText(find.byKey(const Key('temperature_input')), '0');
    await tester.tap(find.byKey(const Key('calculate_button')));
    await tester.pumpAndSettle();

    expect(find.text('32.00 °F'), findsOneWidget);
  });

  testWidgets(
      'Converts Fahrenheit to Celsius: C = (F - 32) * 5/9 and displays up to 2 decimal places',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Switch dropdown to Fahrenheit to Celsius (°F → °C)
    await tester.tap(find.byKey(const Key('conversion_dropdown')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Fahrenheit to Celsius (°F → °C)').last);
    await tester.pumpAndSettle();

    // Test 72 Fahrenheit (from Expected UI Layout mockup) -> 22.22 °C
    await tester.enterText(find.byKey(const Key('temperature_input')), '72');
    await tester.tap(find.byKey(const Key('calculate_button')));
    await tester.pumpAndSettle();

    expect(find.text('22.22 °C'), findsOneWidget);

    // Test 212 Fahrenheit -> 100.00 °C
    await tester.enterText(find.byKey(const Key('temperature_input')), '212');
    await tester.tap(find.byKey(const Key('calculate_button')));
    await tester.pumpAndSettle();

    expect(find.text('100.00 °C'), findsOneWidget);
  });
}
