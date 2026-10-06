import 'package:flutter/material.dart';
import 'package:tugas_1/pages/change_pass_page.dart';
import 'package:tugas_1/pages/email_otp_page.dart';
import 'package:tugas_1/pages/forpass_email_page.dart';
import 'package:tugas_1/pages/forpass_noHp_page.dart';
import 'package:tugas_1/pages/login_page.dart';
import 'package:tugas_1/pages/noHp_otp_page.dart';
import 'package:tugas_1/pages/profile_page.dart';
import 'package:tugas_1/pages/register_page.dart';
import 'package:tugas_1/pages/splash_page.dart';

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
        "/profile": (context) => ProfilePage(),
      },
    );
  }
}
