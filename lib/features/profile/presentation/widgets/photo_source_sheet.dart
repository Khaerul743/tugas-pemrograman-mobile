import 'package:flutter/material.dart';

class PhotoSourceSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const PhotoSourceSheet({
    super.key,
    required this.onCamera,
    required this.onGallery,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onCamera,
    required VoidCallback onGallery,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => PhotoSourceSheet(
        onCamera: onCamera,
        onGallery: onGallery,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle bar
            Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 28),

            // Two options: Kamera & Galeri
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOption(
                  icon: Icons.camera,
                  label: 'Kamera',
                  hasCard: true,
                  onTap: () {
                    Navigator.pop(context);
                    onCamera();
                  },
                ),
                const SizedBox(width: 40),
                _buildOption(
                  icon: Icons.image,
                  label: 'Galeri',
                  hasCard: false,
                  onTap: () {
                    Navigator.pop(context);
                    onGallery();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required bool hasCard,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: hasCard ? const Color(0xFFECECEC) : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              icon,
              size: 38,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
