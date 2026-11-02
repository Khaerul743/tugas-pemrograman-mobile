import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/header_clipper.dart';
import 'package:tugas_1/widgets/logo.dart';

class OtpTemplate extends StatefulWidget {
  final String to;
  final String otherVerificationText;
  final String otherVerificationRoute;
  final IconData? infoIcon;
  final VoidCallback? onVerified;

  const OtpTemplate({
    super.key,
    required this.to,
    required this.otherVerificationText,
    required this.otherVerificationRoute,
    this.infoIcon,
    this.onVerified,
  });

  @override
  State<OtpTemplate> createState() => _OtpTemplateState();
}

class _OtpTemplateState extends State<OtpTemplate> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(
      4,
      (index) => FocusNode(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (_controllers[index].text.isEmpty && index > 0) {
              _controllers[index - 1].clear();
              _focusNodes[index - 1].requestFocus();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    // If multiple digits were pasted (e.g. 4-digit OTP)
    if (value.length >= 4) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < digits.length && (index + i) < 4; i++) {
        _controllers[index + i].text = digits[i];
      }
      final nextIndex = index + digits.length;
      if (nextIndex < 4) {
        _focusNodes[nextIndex].requestFocus();
      } else {
        _focusNodes[3].unfocus();
      }
      return;
    }

    // If replacement character was typed into an already filled box
    if (value.length > 1) {
      final newChar = value.substring(value.length - 1);
      _controllers[index].text = newChar;
      _controllers[index].selection = const TextSelection.collapsed(offset: 1);
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
      return;
    }

    // Single digit entered
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      // Digit deleted
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  Widget _buildOtpBox(int index) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A6556),
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFD8D8D8), width: 1.4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFD8D8D8), width: 1.4),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF1A6556), width: 2),
            ),
          ),
          onChanged: (value) => _onOtpChanged(value, index),
        ),
      ),
    );
  }

  Widget _buildInfoIcon() {
    if (widget.infoIcon != null && widget.infoIcon != Icons.phone_android) {
      return Icon(widget.infoIcon, size: 32, color: Colors.black);
    }
    return const _PhoneSmsIcon();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderClipperWidget(
            height: 220,
            child: Center(
              child: LogoWidget(height: 50),
            ),
          ),
          const SizedBox(height: 16),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  // VERIFICATION
                  Row(
                    children: const [
                      Icon(Icons.check, size: 22, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'VERIFIKASI',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  // INFO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: _buildInfoIcon(),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text:
                                "Periksa dan ketik kode verifikasi yang telah dikirimkan ke ",
                            style: const TextStyle(
                              fontSize: 14.5,
                              color: Colors.black,
                              height: 1.35,
                            ),
                            children: [
                              TextSpan(
                                text: widget.to,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.5,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 38),
                  // OTP
                  Row(
                    children: [
                      _buildOtpBox(0),
                      const SizedBox(width: 14),
                      _buildOtpBox(1),
                      const SizedBox(width: 14),
                      _buildOtpBox(2),
                      const SizedBox(width: 14),
                      _buildOtpBox(3),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // EMAIL / PHONE ALTERNATIVE
                  if (widget.otherVerificationText.isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.otherVerificationRoute.isNotEmpty) {
                            Navigator.pushReplacementNamed(
                              context,
                              widget.otherVerificationRoute,
                            );
                          }
                        },
                        child: Text(
                          widget.otherVerificationText,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF02B8E0),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 34),
                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        final otp = _controllers.map((c) => c.text).join();
                        if (otp.length < 4) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Silakan masukkan 4 digit kode verifikasi'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        if (widget.onVerified != null) {
                          widget.onVerified!();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A6556),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'KIRIM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  // RESEND
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Kirim Ulang Kode',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A6556),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneSmsIcon extends StatelessWidget {
  const _PhoneSmsIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 33,
      height: 38,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 2,
            child: Container(
              width: 23,
              height: 34,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.6),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(1.5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 7,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
