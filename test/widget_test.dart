import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_proof_lab/main.dart';

void main() {
  testWidgets('All shows the three seeded places', (tester) async {
    await tester.pumpWidget(const SavedPlacesApp());
    await tester.pumpAndSettle();
    for (final place in ['Park', 'Museum', 'Cafe']) {
      expect(find.byKey(ValueKey('place-$place')), findsOneWidget);
    }
    expect(find.text('Showing 3 places'), findsOneWidget);
  });
}
