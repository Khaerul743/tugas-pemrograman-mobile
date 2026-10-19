import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_1/pages/camera_page.dart';
import 'package:tugas_1/widgets/photo_source_sheet.dart';
import 'package:tugas_1/widgets/profile_avatar_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String? initialUsername;
  final String? initialAvatarAsset;
  final File? initialAvatarFile;

  const EditProfilePage({
    super.key,
    this.initialUsername,
    this.initialAvatarAsset,
    this.initialAvatarFile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  String? _avatarAssetPath;
  File? _avatarFile;
  final ImagePicker _picker = ImagePicker();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialUsername ?? '');
    _avatarAssetPath = widget.initialAvatarAsset;
    _avatarFile = widget.initialAvatarFile;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        if (args['username'] != null && _nameController.text.isEmpty) {
          _nameController.text = args['username'];
        }
        if (args['avatarAssetPath'] != null && _avatarAssetPath == null) {
          _avatarAssetPath = args['avatarAssetPath'];
        }
        if (args['avatarFile'] != null && _avatarFile == null) {
          _avatarFile = args['avatarFile'];
        }
      }

      if (_nameController.text.isEmpty) {
        _nameController.text = 'KAYI NYAP NYAP';
      }
      if (_avatarAssetPath == null && _avatarFile == null) {
        _avatarAssetPath = 'lib/assets/images/kucing.jpg';
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  ImageProvider _getImageProvider() {
    if (_avatarFile != null) {
      return FileImage(_avatarFile!);
    }
    return AssetImage(_avatarAssetPath ?? 'lib/assets/images/kucing.jpg');
  }

  void _showPhotoOptions() {
    PhotoSourceSheet.show(
      context,
      onCamera: _openCamera,
      onGallery: _pickFromGallery,
    );
  }

  Future<void> _openCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );

    if (result != null && result is Map<String, dynamic> && mounted) {
      setState(() {
        if (result['type'] == 'file') {
          _avatarFile = File(result['path']);
          _avatarAssetPath = null;
        } else if (result['type'] == 'asset') {
          _avatarAssetPath = result['path'];
          _avatarFile = null;
        }
      });
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        setState(() {
          _avatarFile = File(image.path);
          _avatarAssetPath = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih foto: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'username': _nameController.text.trim(),
        'avatarAssetPath': _avatarAssetPath,
        'avatarFile': _avatarFile,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui!'),
          backgroundColor: Color(0xFF1A6556),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1A6556),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A6556),
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Edit Profil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 38),

                // Avatar Picker with Edit Button (matching Image 1)
                ProfileAvatarPicker(
                  imageProvider: _getImageProvider(),
                  onEditTap: _showPhotoOptions,
                  size: 130,
                ),

                const SizedBox(height: 48),

                // Underline Text Field for Username (matching Image 1)
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.person, color: Colors.grey, size: 22),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    hintText: 'Nama Pengguna',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                      fontSize: 13.5,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1A6556), width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama pengguna tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 52),

                // Green SIMPAN Button (matching Image 1)
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A6556),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'SIMPAN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
