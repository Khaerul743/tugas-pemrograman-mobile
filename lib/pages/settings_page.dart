import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/pages/change_email_page.dart';
import 'package:tugas_1/pages/change_phone_page.dart';
import 'package:tugas_1/pages/update_password_page.dart';
import 'package:tugas_1/widgets/delete_account_dialog.dart';
import 'package:tugas_1/widgets/settings_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1A6556),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A6556),
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // 1. Ubah Nomor Hp (Image 1)
            SettingsItem(
              icon: Icons.phone_outlined,
              title: 'Ubah Nomor Hp',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePhonePage()),
                );
              },
            ),

            // 2. Ubah Email (Image 1)
            SettingsItem(
              icon: Icons.mail_outline,
              title: 'Ubah Email',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangeEmailPage()),
                );
              },
            ),

            // 3. Ubah Kata Sandi (Image 2)
            SettingsItem(
              icon: null,
              title: 'Ubah Kata Sandi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdatePasswordPage(),
                  ),
                );
              },
            ),

            // 4. Hapus Akun (Image 1 - Delete Account Dialog)
            SettingsItem(
              icon: Icons.delete_outline,
              title: 'Hapus Akun',
              showDivider: false,
              onTap: () => DeleteAccountDialog.show(context),
            ),
          ],
        ),
      ),
    );
  }
}
