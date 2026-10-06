import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/logo.dart';
import 'package:tugas_1/widgets/header_clipper.dart';

class ForpassTemplate extends StatefulWidget {
  final String formLabelText;
  final String otherVerificationText;
  final String otherVerificationRoute;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const ForpassTemplate({
    required this.formLabelText,
    required this.otherVerificationText,
    required this.otherVerificationRoute,
    this.keyboardType,
    this.validator,
    super.key,
  });

  @override
  State<ForpassTemplate> createState() => _ForpassTemplateState();
}

class _ForpassTemplateState extends State<ForpassTemplate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(color: const Color(0xFFDCE9E8)),
                  ),

                  Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          LogoWidget(),
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // VERIFICATION
                  SizedBox(height: 12),
                  // INFO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.notifications, size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text:
                                "Periksa dan masukan alamat Email untuk mendapatkan kode verifikasi",
                            style: TextStyle(
                              fontSize: 12.7,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: widget.keyboardType,
                      decoration: InputDecoration(
                        labelText: widget.formLabelText,
                      ),
                      validator: widget.validator ??
                          (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '${widget.formLabelText} tidak boleh kosong';
                            }
                            return null;
                          },
                    ),
                  ),
                  SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          widget.otherVerificationRoute,
                        );
                      },
                      child: Text(
                        widget.otherVerificationText,
                        style: TextStyle(fontSize: 13.7, color: Colors.cyan),
                      ),
                    ),
                  ),
                  SizedBox(height: 27),
                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, "/changePass");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1A6556),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'KIRIM',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
