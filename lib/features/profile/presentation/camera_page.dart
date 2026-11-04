import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  bool _isOpeningCamera = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openDeviceCamera());
  }

  Future<void> _openDeviceCamera() async {
    if (_isOpeningCamera) return;

    setState(() {
      _isOpeningCamera = true;
      _errorMessage = null;
    });

    try {
      final photo = await _picker.pickImage(source: ImageSource.camera);
      if (!mounted) return;

      if (photo == null) {
        Navigator.pop(context);
        return;
      }

      Navigator.pop(context, {'type': 'file', 'path': photo.path});
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isOpeningCamera = false;
        _errorMessage =
            'Kamera tidak dapat dibuka. Periksa izin kamera perangkat Anda.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Kamera'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _errorMessage == null
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Membuka kamera perangkat...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.no_photography, color: Colors.white70, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: _openDeviceCamera,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Coba lagi'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
