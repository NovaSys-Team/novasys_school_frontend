import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novasys_school_frontend/app/app.dart';
import 'package:novasys_school_frontend/app/router.dart';
import 'package:novasys_school_frontend/features/auth/controllers/demo_auth_controller.dart';

void main() {
  setUp(() {
    demoAuth.reset();
    appRouter.go(AppRoutes.root);
  });

  Future<void> start(WidgetTester tester) async {
    await tester.pumpWidget(const StarterApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    final target = find.text(text);
    await tester.ensureVisible(target);
    await tester.tap(target);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Signup validates fields, verifies, navigates tabs and ends session',
    (tester) async {
      await start(tester);
      expect(find.text('Welcome'), findsOneWidget);
      await tapText(tester, 'Create account');
      await tapText(tester, 'Continue to verification');
      expect(find.text('Enter a name'), findsOneWidget);
      expect(find.text('Enter a valid email'), findsOneWidget);
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Demo Parent');
      await tester.enterText(fields.at(1), 'parent@example.test');
      await tester.enterText(fields.at(2), 'demo123');
      await tester.enterText(fields.at(3), 'different');
      await tapText(tester, 'Continue to verification');
      expect(find.text('Passwords must match'), findsOneWidget);
      await tester.enterText(fields.at(3), 'demo123');
      await tapText(tester, 'Continue to verification');
      await tester.enterText(find.byType(TextField), '000000');
      await tapText(tester, 'Verify and continue');
      expect(find.text('Use the demo code 123456'), findsOneWidget);
      await tapText(tester, 'Resend code (demo)');
      expect(
        find.text('Demo only: no message sent. Code: 123456'),
        findsOneWidget,
      );
      await tester.enterText(find.byType(TextField), '123456');
      await tapText(tester, 'Verify and continue');
      expect(find.text('Hello, Demo Parent'), findsOneWidget);
      expect(demoAuth.verified, isTrue);
      await tester.tap(find.byIcon(Icons.route_outlined).last);
      await tester.pumpAndSettle();
      expect(find.text('No demo trips yet'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.notifications_none).last);
      await tester.pumpAndSettle();
      expect(find.text('No notifications'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();
      await tapText(tester, 'End demo session');
      expect(find.text('Welcome'), findsOneWidget);
      expect(demoAuth.email, isEmpty);
      expect(demoAuth.verified, isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Login works on a small screen with keyboard inset', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    await start(tester);
    await tapText(tester, 'Log in');
    tester.view.viewInsets = const FakeViewPadding(bottom: 240);
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'parent@example.test');
    await tester.enterText(fields.at(1), 'demo123');
    await tapText(tester, 'Continue to verification');
    await tester.enterText(find.byType(TextField), '123456');
    await tapText(tester, 'Verify and continue');
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();
    expect(find.text('Hello, parent'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Direct verification route explains missing demo session', (
    tester,
  ) async {
    await start(tester);
    appRouter.go(AppRoutes.verify);
    await tester.pumpAndSettle();
    expect(
      find.text('Start with sign up or login to try verification.'),
      findsOneWidget,
    );
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Verify and continue'),
    );
    expect(button.onPressed, isNull);
    await tapText(tester, 'Back to welcome');
    expect(find.text('Welcome'), findsOneWidget);
  });
}
