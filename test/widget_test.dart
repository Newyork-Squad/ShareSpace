// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:share_space/main.dart';
import 'package:share_space/presentation/routes/app_router.dart';

void main() {
  testWidgets('My Account screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(ShareSpaceApp(seenOnboarding: false, appRouter: AppRouter()));
    expect(find.text('My Account'), findsOneWidget);
    expect(find.text('Account informations'), findsOneWidget);
  });
}
