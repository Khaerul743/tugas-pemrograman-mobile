import 'dart:ui';
import 'package:flutter/material.dart';

// Features - Auth
import 'package:tugas_1/features/auth/presentation/change_email_page.dart';
import 'package:tugas_1/features/auth/presentation/change_pass_page.dart';
import 'package:tugas_1/features/auth/presentation/change_phone_page.dart';
import 'package:tugas_1/features/auth/presentation/email_otp_page.dart';
import 'package:tugas_1/features/auth/presentation/forpass_email_page.dart';
import 'package:tugas_1/features/auth/presentation/forpass_no_hp_page.dart';
import 'package:tugas_1/features/auth/presentation/login_page.dart';
import 'package:tugas_1/features/auth/presentation/no_hp_otp_page.dart';
import 'package:tugas_1/features/auth/presentation/register_page.dart';
import 'package:tugas_1/features/auth/presentation/update_password_page.dart';
import 'package:tugas_1/features/auth/presentation/verify_email_update_page.dart';
import 'package:tugas_1/features/auth/presentation/verify_phone_update_page.dart';

// Features - Home & Exploration
import 'package:tugas_1/features/home/presentation/add_review_page.dart';
import 'package:tugas_1/features/home/presentation/category_detail_page.dart';
import 'package:tugas_1/features/home/presentation/destination_detail_page.dart';
import 'package:tugas_1/features/home/presentation/ratings_reviews_page.dart';
import 'package:tugas_1/features/home/presentation/recently_viewed_page.dart';

// Features - Weather
import 'package:tugas_1/features/weather/presentation/weather_detail_page.dart';

// Features - Recommendation & Transit
import 'package:tugas_1/features/recommendation/presentation/departure_schedule_page.dart';
import 'package:tugas_1/features/recommendation/presentation/public_transport_detail_page.dart';
import 'package:tugas_1/features/recommendation/presentation/route_recommendation_page.dart';
import 'package:tugas_1/features/recommendation/presentation/trip_recap_page.dart';
import 'package:tugas_1/features/recommendation/presentation/vehicle_analysis_page.dart';

// Features - Profile & Settings
import 'package:tugas_1/features/profile/presentation/camera_page.dart';
import 'package:tugas_1/features/profile/presentation/edit_profile_page.dart';
import 'package:tugas_1/features/profile/presentation/settings_page.dart';

// Features - Notifications
import 'package:tugas_1/features/notifications/presentation/notifications_page.dart';

// Shared Shell Navigation
import 'package:tugas_1/shared/widgets/main_navigation_wrapper.dart';

// Features - Static Pages
import 'package:tugas_1/features/static_pages/presentation/about_us_page.dart';
import 'package:tugas_1/features/static_pages/presentation/privacy_policy_page.dart';
import 'package:tugas_1/features/static_pages/presentation/splash_page.dart';
import 'package:tugas_1/features/static_pages/presentation/terms_of_service_page.dart';

void main() {
  runApp(MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecowalk",
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/verificationWithNoHP": (context) => NoHpOTPPage(),
        "/verificationWithEmail": (context) => EmailOtpPage(),
        "/forpassNoHp": (context) => ForpassNohpPage(),
        "/forpassEmail": (context) => ForpassEmailPage(),
        "/changePass": (context) => ChangePassPage(),
        "/home": (context) => const MainNavigationWrapper(initialIndex: 0),
        "/detailDestination": (context) => const DestinationDetailPage(),
        "/reviews": (context) => const RatingsReviewsPage(),
        "/addReview": (context) => const AddReviewPage(),
        "/profile": (context) => const MainNavigationWrapper(initialIndex: 3),
        "/editProfile": (context) => const EditProfilePage(),
        "/camera": (context) => const CameraPage(),
        "/settings": (context) => const SettingsPage(),
        "/changePhone": (context) => const ChangePhonePage(),
        "/changeEmail": (context) => const ChangeEmailPage(),
        "/updatePassword": (context) => const UpdatePasswordPage(),
        "/verifyPhoneUpdate": (context) => const VerifyPhoneUpdatePage(),
        "/verifyEmailUpdate": (context) => const VerifyEmailUpdatePage(),
        "/privacyPolicy": (context) => const PrivacyPolicyPage(),
        "/aboutUs": (context) => const AboutUsPage(),
        "/termsOfService": (context) => const TermsOfServicePage(),
        "/categoryDetail": (context) => const CategoryDetailPage(),
        "/weatherDetail": (context) => const WeatherDetailPage(),
        "/notifications": (context) => const NotificationsPage(),
        "/tripRecap": (context) => const TripRecapPage(),
        "/recentlyViewed": (context) => const RecentlyViewedPage(),
        "/recommendation": (context) => const MainNavigationWrapper(initialIndex: 1),
        "/routeRecommendation": (context) => const RouteRecommendationPage(),
        "/vehicleAnalysis": (context) => const VehicleAnalysisPage(),
        "/publicTransportDetail": (context) => const PublicTransportDetailPage(),
        "/departureSchedule": (context) => const DepartureSchedulePage(),
      },
    );
  }
}
