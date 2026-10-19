import 'package:deen_step/app.dart';
import 'package:deen_step/core/constants/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders splash screen branding and actions test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DeenStepApp());

    // Verify initial brand identity presence
    expect(find.text(AppStrings.appNameUpper), findsOneWidget);
    expect(find.text(AppStrings.splashTagline), findsOneWidget);

    // Advance animation controller to completion (1800ms)
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    // Verify that the action buttons appeared after the progressive animation
    expect(find.text(AppStrings.createAccount), findsOneWidget);
    expect(find.text(AppStrings.alreadyRegisteredLogIn), findsOneWidget);
    expect(find.text(AppStrings.continueAsGuest), findsOneWidget);
  });
}
