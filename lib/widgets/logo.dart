import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;

  const LogoWidget({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/images/full_logo.png',
      width: width,
      height: height ?? (width != null ? null : 45),
      fit: fit,
    );
  }
}

