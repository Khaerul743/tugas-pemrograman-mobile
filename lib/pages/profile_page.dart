import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(),
            SizedBox(height: 40),
            Expanded(child: ProfileMenu()),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // GREEN HEADER
          Container(
            width: double.infinity,
            height: 96,
            color: const Color(0xFF1A6556),
          ),

          // PROFILE IMAGE
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/images/kucing.jpg'),
                ),
              ),
            ),
          ),

          // USERNAME
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'KAYI NYAP NYAP',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // EMAIL
          Positioned(
            top: 195,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 160,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A6556),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  'kayimail@gmail.com',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
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

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(icon, size: 28, color: Colors.black),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const Icon(Icons.chevron_right, size: 26, color: Colors.black),
              ],
            ),
          ),
        ),

        Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            onTap: () {},
          ),

          ProfileMenuItem(
            icon: Icons.edit_outlined,
            title: 'Edit Profil',
            onTap: () {},
          ),

          ProfileMenuItem(
            icon: Icons.lock_outline,
            title: 'Kebijakan Privasi',
            onTap: () {},
          ),

          ProfileMenuItem(
            icon: Icons.info_outline,
            title: 'Tentang Kami',
            onTap: () {},
          ),

          ProfileMenuItem(
            icon: Icons.description_outlined,
            title: 'Ketentuan Layanan',
            onTap: () {},
          ),

          ProfileMenuItem(icon: Icons.logout, title: 'Keluar', onTap: () {}),
        ],
      ),
    );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 62,
              color: const Color(0xFF1A6556),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navIcon(Icons.home_outlined),
                  _navIcon(Icons.verified_user_outlined),
                  _navIcon(Icons.chat_bubble_outline),

                  // Space untuk tombol account
                  const SizedBox(width: 55),
                ],
              ),
            ),
          ),

          // Account
          Positioned(
            right: 23,
            bottom: 30,
            child: Column(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1A6556),
                      width: 9,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF1A6556),
                    size: 30,
                  ),
                ),

                const SizedBox(height: 1),

                const Text(
                  'AKUN',
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon) {
    return Icon(icon, color: Colors.white, size: 23);
  }
}
