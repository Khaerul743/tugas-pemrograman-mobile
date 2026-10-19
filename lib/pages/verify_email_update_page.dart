import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/otp_template.dart';

class VerifyEmailUpdatePage extends StatelessWidget {
  final String? email;

  const VerifyEmailUpdatePage({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final displayEmail = email ?? (args is String ? args : 'kayimail@gmail.com');

    return Scaffold(
      backgroundColor: Colors.white,
      body: OtpTemplate(
        to: displayEmail,
        infoIcon: Icons.email,
        otherVerificationText: "Verifikasi menggunakan Nomor Hp",
        otherVerificationRoute: "/changePhone",
        onVerified: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email berhasil diperbarui!'),
              backgroundColor: Color(0xFF1A6556),
            ),
          );
          Navigator.popUntil(
            context,
            (route) => route.settings.name == '/settings' || route.isFirst,
          );
        },
      ),
    );
  }
}
