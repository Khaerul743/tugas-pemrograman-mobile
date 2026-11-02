import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_1/widgets/custom_bottom_navigation.dart';
import 'package:tugas_1/widgets/logout_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = 'KAYI NYAP NYAP';
  String? _avatarAssetPath = 'lib/assets/images/kucing.jpg';
  File? _avatarFile;

  Future<void> _handleEditProfile() async {
    final result = await Navigator.pushNamed(
      context,
      '/editProfile',
      arguments: {
        'username': _username,
        'avatarAssetPath': _avatarAssetPath,
        'avatarFile': _avatarFile,
      },
    );

    if (result != null && result is Map<String, dynamic> && mounted) {
      setState(() {
        if (result['username'] != null) {
          _username = result['username'];
        }
        if (result.containsKey('avatarAssetPath')) {
          _avatarAssetPath = result['avatarAssetPath'];
        }
        if (result.containsKey('avatarFile')) {
          _avatarFile = result['avatarFile'];
        }
      });
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(
                username: _username,
                avatarAssetPath: _avatarAssetPath,
                avatarFile: _avatarFile,
              ),
              ProfileMenu(
                onEditProfile: _handleEditProfile,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigation(currentIndex: 3),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String username;
  final String? avatarAssetPath;
  final File? avatarFile;

  const ProfileHeader({
    super.key,
    required this.username,
    this.avatarAssetPath,
    this.avatarFile,
  });

  ImageProvider _getImageProvider() {
    if (avatarFile != null) {
      return FileImage(avatarFile!);
    }
    return AssetImage(avatarAssetPath ?? 'lib/assets/images/kucing.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final greenHeight = topPadding + 90.0;
    const avatarDiameter = 136.0;

    return Column(
      children: [
        SizedBox(
          height: greenHeight + (avatarDiameter / 2),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // GREEN HEADER (reaches very top through status bar)
              Container(
                width: double.infinity,
                height: greenHeight,
                color: const Color(0xFF1A6556),
              ),

              // PROFILE IMAGE (centered at the boundary between green and white)
              Positioned(
                top: greenHeight - (avatarDiameter / 2),
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: avatarDiameter,
                    height: avatarDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                      image: DecorationImage(
                        image: _getImageProvider(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // USERNAME
        Text(
          username,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 8),

        // EMAIL BADGE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1A6556),
            borderRadius: BorderRadius.circular(4.5),
          ),
          child: const Text(
            'kayimail@gmail.com',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 28),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final VoidCallback onEditProfile;

  const ProfileMenu({
    super.key,
    required this.onEditProfile,
  });

  void _logout(BuildContext context) {
    LogoutDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ProfileMenuItem(
            icon: Icons.edit_outlined,
            title: 'Edit Profil',
            onTap: onEditProfile,
          ),
          ProfileMenuItem(
            icon: Icons.lock_outline,
            title: 'Kebijakan Privasi',
            onTap: () => Navigator.pushNamed(context, '/privacyPolicy'),
          ),
          ProfileMenuItem(
            icon: Icons.info_outline,
            title: 'Tentang Kami',
            onTap: () => Navigator.pushNamed(context, '/aboutUs'),
          ),
          ProfileMenuItem(
            title: 'Ketentuan Layanan',
            onTap: () => Navigator.pushNamed(context, '/termsOfService'),
          ),
          ProfileMenuItem(
            icon: Icons.logout,
            title: 'Keluar',
            showDivider: false,
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItem({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 2.0),
            child: Row(
              children: [
                if (icon != null)
                  Icon(icon, size: 28, color: const Color(0xFF1A1A1A))
                else
                  const SizedBox(width: 28),
                const SizedBox(width: 22),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 28,
                  color: Color(0xFF1A1A1A),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E5E5),
          ),
      ],
    );
  }
}

