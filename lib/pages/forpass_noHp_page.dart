import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/forpass_template.dart';

class ForpassNohpPage extends StatelessWidget {
  const ForpassNohpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForpassTemplate(
        formLabelText: "Nomor Hp",
        otherVerificationText: "Gunakan Email",
        otherVerificationRoute: "/forpassEmail",
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Nomor HP tidak boleh kosong';
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
            return 'Nomor HP hanya boleh berisi angka';
          }
          if (value.trim().length < 10) {
            return 'Nomor HP minimal 10 digit';
          }
          return null;
        },
      ),
    );
  }
}
