import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * 0.45);

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HeaderClipperWidget extends StatelessWidget {
  final Widget? child;
  final double height;
  final Color color;

  const HeaderClipperWidget({
    super.key,
    this.child,
    this.height = 220,
    this.color = const Color(0xFFDCE9E8),
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final totalHeight = height + topPadding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          children: [
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: totalHeight,
                width: double.infinity,
                color: color,
              ),
            ),
            if (child != null)
              Positioned(
                top: topPadding,
                left: 0,
                right: 0,
                bottom: 0,
                child: child!,
              ),
          ],
        ),
      ),
    );
  }
}
