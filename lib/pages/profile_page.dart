import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigation(),
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
    final greenHeight = topPadding + 75.0;
    const avatarDiameter = 110.0;

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
                      border: Border.all(color: Colors.white, width: 4),
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

        const SizedBox(height: 12),

        // USERNAME
        Text(
          username,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 8),

        // EMAIL BADGE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.5),
          decoration: BoxDecoration(
            color: const Color(0xFF1A6556),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'kayimail@gmail.com',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 24),
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
      padding: const EdgeInsets.symmetric(horizontal: 18),
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
            icon: Icons.assignment_outlined,
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
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItem({
    super.key,
    required this.icon,
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
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 4.0),
            child: Row(
              children: [
                Icon(icon, size: 25, color: const Color(0xFF1A1A1A)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 24,
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
            color: Color(0xFFEEEEEE),
          ),
      ],
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const barHeight = 56.0;

    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: barHeight + 22 + bottomInset,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Green bottom bar background (covers bottom navigation and safe inset)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: barHeight + bottomInset,
                color: const Color(0xFF1A6556),
                padding: EdgeInsets.only(bottom: bottomInset),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _navIcon(Icons.home_outlined),
                          _navIcon(Icons.verified_user_outlined),
                          _chatWithHeartIcon(),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(), // Space allocated for floating AKUN button
                    ),
                  ],
                ),
              ),
            ),

            // Floating AKUN tab button
            Positioned(
              right: 18,
              bottom: bottomInset + 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A6556),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF1A6556),
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'AKUN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon) {
    return Icon(icon, color: Colors.white, size: 24);
  }

  Widget _chatWithHeartIcon() {
    return Stack(
      alignment: Alignment.center,
      children: const [
        Icon(Icons.chat_bubble, color: Colors.white, size: 24),
        Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(Icons.favorite, color: Color(0xFF1A6556), size: 10),
        ),
      ],
    );
  }
}
