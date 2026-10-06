import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/forpass_template.dart';

class ForpassEmailPage extends StatelessWidget {
  const ForpassEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForpassTemplate(
        formLabelText: "Alamat Email",
        otherVerificationText: "Gunakan No Hp",
        otherVerificationRoute: "/forpassNoHp",
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Email tidak boleh kosong';
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value.trim())) {
            return 'Format email tidak valid';
          }
          return null;
        },
      ),
    );
  }
}
