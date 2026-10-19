import 'package:flutter/material.dart';
import 'package:tugas_1/pages/camera_page.dart';
import 'package:tugas_1/pages/change_email_page.dart';
import 'package:tugas_1/pages/change_pass_page.dart';
import 'package:tugas_1/pages/change_phone_page.dart';
import 'package:tugas_1/pages/edit_profile_page.dart';
import 'package:tugas_1/pages/email_otp_page.dart';
import 'package:tugas_1/pages/forpass_email_page.dart';
import 'package:tugas_1/pages/forpass_noHp_page.dart';
import 'package:tugas_1/pages/login_page.dart';
import 'package:tugas_1/pages/noHp_otp_page.dart';
import 'package:tugas_1/pages/profile_page.dart';
import 'package:tugas_1/pages/register_page.dart';
import 'package:tugas_1/pages/about_us_page.dart';
import 'package:tugas_1/pages/privacy_policy_page.dart';
import 'package:tugas_1/pages/settings_page.dart';
import 'package:tugas_1/pages/splash_page.dart';
import 'package:tugas_1/pages/terms_of_service_page.dart';
import 'package:tugas_1/pages/update_password_page.dart';
import 'package:tugas_1/pages/verify_email_update_page.dart';
import 'package:tugas_1/pages/verify_phone_update_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecowalk",
      debugShowCheckedModeBanner: false,
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
        "/profile": (context) => const ProfilePage(),
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
      },
    );
  }
}
