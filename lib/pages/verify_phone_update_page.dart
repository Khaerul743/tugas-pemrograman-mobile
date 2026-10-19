import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/otp_template.dart';

class VerifyPhoneUpdatePage extends StatelessWidget {
  final String? phone;

  const VerifyPhoneUpdatePage({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final displayPhone = phone ?? (args is String ? args : '+6212371923719238');

    return Scaffold(
      backgroundColor: Colors.white,
      body: OtpTemplate(
        to: displayPhone,
        infoIcon: Icons.phone_android,
        otherVerificationText: "Verifikasi menggunakan Email",
        otherVerificationRoute: "/changeEmail",
        onVerified: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nomor HP berhasil diperbarui!'),
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
