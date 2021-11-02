// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app_livres/screens/pre_comunidade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestable(Widget widget) => MaterialApp(home: widget);

void main() {
  testWidgets('Clique Botão de Logar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(PreComunidadeScreen());

    // Verify that our counter starts at 0.
    final Finder buttonFinder = find.byType(FlatButton);

    expect(buttonFinder, findsOneWidget);

    final FlatButton button = tester.widget(buttonFinder);
    final gestureFinder = find.byType(GestureDetector);

    await tester.tap(gestureFinder);

    await tester.pumpAndSettle();
  });
}
