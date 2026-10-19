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
    return SizedBox(
      width: 67,
      height: 65,
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A6556),
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1A6556), width: 2),
          ),
        ),
        onChanged: (value) => _onOtpChanged(value, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderClipperWidget(
            child: Center(
              child: LogoWidget(),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // VERIFICATION
                  Row(
                    children: const [
                      Icon(Icons.check, size: 20),
                      SizedBox(width: 8),
                      Text('VERIFIKASI', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // INFO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(widget.infoIcon ?? Icons.phone_android, size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text:
                                "Periksa dan ketik kode verifikasi yang telah dikirimkan ke ",
                            style: const TextStyle(
                              fontSize: 13.7,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: widget.to,
                                style: const TextStyle(
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
                  const SizedBox(height: 35),
                  // OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOtpBox(0),
                      _buildOtpBox(1),
                      _buildOtpBox(2),
                      _buildOtpBox(3),
                    ],
                  ),

                  const SizedBox(height: 28),

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
                          style:
                              const TextStyle(fontSize: 13.7, color: Colors.cyan),
                        ),
                      ),
                    ),
                  const SizedBox(height: 27),
                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 40,
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
                  const SizedBox(height: 20),
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
          ),
        ],
      ),
    );
  }
}
