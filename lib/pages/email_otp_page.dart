import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/otp_template.dart';

class EmailOtpPage extends StatelessWidget {
  const EmailOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpTemplate(
        to: "test@gmail.com",
        otherVerificationText: "Verifikasi menggunakan No. HP",
        otherVerificationRoute: "/verificationWithNoHP",
      ),
    );
  }
}
