import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_proof_lab/main.dart';

void main() {
  testWidgets(
    'Saved filters, removes the last item and keeps selection across tabs',
    (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      addTearDown(tester.view.resetPhysicalSize);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const SavedPlacesApp());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('saved-filter')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('place-Museum')), findsOneWidget);
      expect(find.byKey(const ValueKey('place-Park')), findsNothing);
      expect(find.byKey(const ValueKey('place-Cafe')), findsNothing);
      expect(find.text('Showing 1 places'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('toggle-Museum')));
      await tester.pumpAndSettle();
      expect(find.text('No saved places'), findsOneWidget);
      expect(find.text('Showing 0 places'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('all-filter')));
      await tester.pumpAndSettle();
      expect(find.text('Showing 3 places'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('toggle-Park')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('saved-filter')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('place-Park')), findsOneWidget);
      expect(find.byKey(const ValueKey('place-Museum')), findsNothing);
      expect(find.byKey(const ValueKey('place-Cafe')), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
