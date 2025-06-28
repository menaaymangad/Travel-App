import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travelapp/features/places/presentation/pages/places_page.dart';

void main() {
  testWidgets('PlacesPage shows filter dropdown and grid',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PlacesPage()));
    expect(find.text('Explore Places'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    // The grid or prompt should be present
    expect(find.text('Select a category to filter places.'), findsOneWidget);
  });
}
