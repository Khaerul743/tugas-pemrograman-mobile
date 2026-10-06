import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/otp_template.dart';

class NoHpOTPPage extends StatelessWidget {
  const NoHpOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OtpTemplate(
        to: "+629593599593",
        otherVerificationText: "Verifikasi menggunakan Email",
        otherVerificationRoute: "/verificationWithEmail",
      ),
    );
  }
}
