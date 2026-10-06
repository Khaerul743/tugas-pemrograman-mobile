import 'package:flutter/material.dart';
import 'package:tugas_1/widgets/header_clipper.dart';
import 'package:tugas_1/widgets/logo.dart';

class OtpTemplate extends StatelessWidget {
  final String to;
  final String otherVerificationText;
  final String otherVerificationRoute;

  const OtpTemplate({
    super.key,
    required this.to,
    required this.otherVerificationText,
    required this.otherVerificationRoute,
  });

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
                    child: Center(child: LogoWidget()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // VERIFICATION
                  Row(
                    children: [
                      const Icon(Icons.check, size: 20),
                      const SizedBox(width: 8),
                      const Text('VERIFIKASI', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 12),
                  // INFO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone_android, size: 28),
                      const SizedBox(width: 8),
                      // const Expanded(
                      //   child: Text(
                      //     'Periksa dan ketik kode verifikasi '
                      //     'yang telah dikirimkan ke '
                      //     '+6212371923719238',
                      //     style: TextStyle(fontSize: 13.3),
                      //   ),
                      // ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "Periksa dan ketik kode verifikasi yang telah dikirimkan ke ",
                            style: TextStyle(
                              fontSize: 13.7,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: to,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.7,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  // OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_otpBox(), _otpBox(), _otpBox(), _otpBox()],
                  ),

                  const SizedBox(height: 28),

                  // EMAIL
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          otherVerificationRoute,
                        );
                      },
                      child: Text(
                        otherVerificationText,
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
                      onPressed: () {},
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
                  // RESEND
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Kirim Ulang Kode',
                      style: TextStyle(fontSize: 11, color: Color(0xFF1A6556)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _otpBox() {
  return SizedBox(
    width: 67,
    height: 65,
    child: TextFormField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
