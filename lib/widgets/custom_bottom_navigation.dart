import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({
    super.key,
    this.currentIndex = 0,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/recommendation');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    const barHeight = 62.0;
    const buttonDiameter = 72.0;

    final isHomeActive = currentIndex == 0;
    final isRecommendationActive = currentIndex == 1;
    final isProfileActive = currentIndex == 3;

    final slotWidth = screenWidth / 4;
    final floatingOffset = (slotWidth - buttonDiameter) / 2;

    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: barHeight + 24 + bottomInset,
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
                    // Tab 0: Home / Beranda
                    if (isHomeActive)
                      const Expanded(child: SizedBox())
                    else
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTap(context, 0),
                          child: Center(
                            child: _navIcon(Icons.home_outlined, size: 28),
                          ),
                        ),
                      ),

                    // Tab 1: Shield / Verified (Rekomendasi)
                    if (isRecommendationActive)
                      const Expanded(child: SizedBox())
                    else
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTap(context, 1),
                          child: Center(
                            child: _shieldCheckIcon(color: Colors.white, size: 26),
                          ),
                        ),
                      ),

                    // Tab 2: Chat with heart
                    Expanded(
                      child: Center(
                        child: _chatWithHeartIcon(),
                      ),
                    ),

                    // Tab 3: Akun / Profile
                    if (isProfileActive)
                      const Expanded(child: SizedBox())
                    else
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTap(context, 3),
                          child: Center(
                            child: _navIcon(Icons.person, size: 28),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Floating BERANDA tab button (Left - Slot 0)
            if (isHomeActive)
              Positioned(
                left: floatingOffset.clamp(8.0, 32.0),
                bottom: bottomInset + 4,
                child: _floatingTabButton(
                  icon: Icons.home_outlined,
                  label: 'BERANDA',
                ),
              ),

            // Floating REKOMENDASI tab button (Slot 1)
            if (isRecommendationActive)
              Positioned(
                left: slotWidth + floatingOffset,
                bottom: bottomInset + 4,
                child: _floatingTabButton(
                  customIcon: _shieldCheckIcon(color: const Color(0xFF1A6556), size: 28),
                  label: 'REKOMENDASI',
                ),
              ),

            // Floating AKUN tab button (Right - Slot 3)
            if (isProfileActive)
              Positioned(
                right: floatingOffset.clamp(8.0, 32.0),
                bottom: bottomInset + 4,
                child: _floatingTabButton(
                  icon: Icons.person,
                  label: 'AKUN',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _floatingTabButton({
    IconData? icon,
    Widget? customIcon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: Color(0xFF1A6556),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: customIcon ??
                    Icon(
                      icon,
                      color: const Color(0xFF1A6556),
                      size: 30,
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }

  Widget _shieldCheckIcon({required Color color, double size = 26}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.shield_outlined, color: color, size: size),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(Icons.check, color: color, size: size * 0.52),
        ),
      ],
    );
  }

  Widget _navIcon(IconData icon, {double size = 26}) {
    return Icon(icon, color: Colors.white, size: size);
  }

  Widget _chatWithHeartIcon() {
    return Stack(
      alignment: Alignment.center,
      children: const [
        Icon(Icons.chat_bubble, color: Colors.white, size: 27),
        Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(Icons.favorite, color: Color(0xFF1A6556), size: 11),
        ),
      ],
    );
  }
}
