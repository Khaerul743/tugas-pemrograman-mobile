import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_1/widgets/otp_template.dart';

void main() {
  testWidgets('OtpTemplate auto focuses next box when filled', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OtpTemplate(
            to: "test@example.com",
            otherVerificationText: "Other",
            otherVerificationRoute: "/other",
          ),
        ),
      ),
    );

    final textFields = find.byType(TextFormField);
    expect(textFields, findsNWidgets(4));

    await tester.enterText(textFields.at(0), '1');
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.enterText(textFields.at(1), '2');
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.enterText(textFields.at(2), '3');
    await tester.pump();
    expect(find.text('3'), findsOneWidget);

    await tester.enterText(textFields.at(3), '4');
    await tester.pump();
    expect(find.text('4'), findsOneWidget);
  });
}
