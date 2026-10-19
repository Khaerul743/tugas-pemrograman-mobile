import 'package:flutter/material.dart';

class ProfileAvatarPicker extends StatelessWidget {
  final ImageProvider imageProvider;
  final VoidCallback onEditTap;
  final double size;

  const ProfileAvatarPicker({
    super.key,
    required this.imageProvider,
    required this.onEditTap,
    this.size = 130.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Circular Avatar Image
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Green Edit Badge at Bottom-Right
          Positioned(
            right: 2,
            bottom: 4,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A6556),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
