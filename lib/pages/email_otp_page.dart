import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/otp_template.dart';

class EmailOtpPage extends StatelessWidget {
  const EmailOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OtpTemplate(
        to: "test@gmail.com",
        infoIcon: Icons.email_outlined,
        otherVerificationText: "Verifikasi menggunakan No. HP",
        otherVerificationRoute: "/verificationWithNoHP",
      ),
    );
  }
}
