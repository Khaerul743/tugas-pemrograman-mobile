import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with SingleTickerProviderStateMixin {
  bool _isFrontCamera = true;
  bool _isFlashing = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _capturePhoto() async {
    setState(() {
      _isFlashing = true;
    });

    await Future.delayed(const Duration(milliseconds: 150));

    if (!mounted) return;
    setState(() {
      _isFlashing = false;
    });

    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    // Return the captured photo asset from the camera viewfinder
    Navigator.pop(context, {
      'type': 'asset',
      'path': 'lib/assets/images/camera_avatar.png',
    });
  }

  Future<void> _openDeviceCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null && mounted) {
        Navigator.pop(context, {
          'type': 'file',
          'path': photo.path,
        });
      }
    } catch (e) {
      // If camera hardware not available (e.g. on Windows without camera support),
      // capture photo via the on-screen simulated camera
      _capturePhoto();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Camera Viewfinder Preview Image
            Image.asset(
              'lib/assets/images/camera_sample.png',
              fit: BoxFit.cover,
            ),

            // Top Control Bar (Back button and Flip camera button)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 12,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Flip Camera Switch Button (as in Image 3)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFrontCamera = !_isFrontCamera;
                      });
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Shutter Button (as in Image 3)
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom + 24,
              child: Center(
                child: GestureDetector(
                  onTap: _capturePhoto,
                  onLongPress: _openDeviceCamera,
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A6556),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ),

            // Flash effect animation overlay
            if (_isFlashing)
              Container(
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
