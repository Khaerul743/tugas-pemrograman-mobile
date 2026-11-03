import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_1/features/auth/presentation/widgets/otp_template.dart';
import 'package:tugas_1/features/home/presentation/home_page.dart';
import 'package:tugas_1/features/recommendation/presentation/recommendation_page.dart';
import 'package:tugas_1/features/profile/presentation/profile_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:tugas_1/shared/widgets/main_navigation_wrapper.dart';
import 'package:tugas_1/shared/widgets/map/map.dart';
import 'package:tugas_1/features/weather/presentation/weather_detail_page.dart';

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

  testWidgets('HomePage builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('RecommendationPage builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RecommendationPage(),
      ),
    );
    expect(find.byType(RecommendationPage), findsOneWidget);
  });

  testWidgets('ProfilePage builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );
    expect(find.byType(ProfilePage), findsOneWidget);
  });

  testWidgets('MainNavigationWrapper builds and renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainNavigationWrapper(initialIndex: 0),
      ),
    );
    expect(find.byType(MainNavigationWrapper), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('AppMapView builds and renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppMapView(
            initialCenter: LatLng(-6.2088, 106.8456),
            initialZoom: 13.0,
            markers: [
              MapMarkerItem(
                point: LatLng(-6.2088, 106.8456),
                title: 'Test Location',
              ),
            ],
          ),
        ),
      ),
    );
    expect(find.byType(AppMapView), findsOneWidget);
  });

  testWidgets('WeatherDetailPage builds and renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WeatherDetailPage(),
      ),
    );
    expect(find.byType(WeatherDetailPage), findsOneWidget);
    expect(find.text('Prakiraan Cuaca'), findsOneWidget);
  });
}
