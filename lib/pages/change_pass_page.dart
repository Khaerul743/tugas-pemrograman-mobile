import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/header_clipper.dart';
import 'package:tugas_1/widgets/logo.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            HeaderClipperWidget(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    LogoWidget(),
                    SizedBox(height: 6),
                    Text(
                      "LUPA KATA SANDI",
                      style: TextStyle(
                        color: Color(0xFF1A6556),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CONTENT
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label
                      const Text(
                        'Masukan Kata Sandi Baru',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // PASSWORD
                      _passwordField(
                        controller: _passwordController,
                        hintText: 'Kata Sandi Baru',
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata sandi baru tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Kata sandi minimal 6 karakter';
                          }
                          return null;
                        },
                        onToggle: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),

                      const SizedBox(height: 23),

                      // CONFIRM PASSWORD
                      _passwordField(
                        controller: _confirmPasswordController,
                        hintText: 'Konfirmasi Kata Sandi',
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi kata sandi tidak boleh kosong';
                          }
                          if (value != _passwordController.text) {
                            return 'Konfirmasi kata sandi tidak cocok';
                          }
                          return null;
                        },
                        onToggle: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),

                      const SizedBox(height: 43),

                      // BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            _changePassword();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A6556),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'UBAH KATA SANDI',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 13,
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),

        prefixIcon: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(Icons.lock, size: 18, color: Colors.grey),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 26,
          minHeight: 24,
        ),

        suffixIcon: IconButton(
          onPressed: onToggle,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            size: 18,
            color: Colors.grey,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
        ),

        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1A6556), width: 1.5),
        ),
      ),
    );
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi berhasil diubah!'),
          backgroundColor: Color(0xFF1A6556),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }
  }
}
