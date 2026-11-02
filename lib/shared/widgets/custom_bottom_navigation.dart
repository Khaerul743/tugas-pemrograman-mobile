import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  const CustomBottomNavigation({
    super.key,
    this.currentIndex = 0,
    this.onTabSelected,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  void _onTap(BuildContext context, int index) {
    if (index == 2) {
      _showChatbotDialog(context);
      return;
    }

    if (index == widget.currentIndex) return;

    if (widget.onTabSelected != null) {
      widget.onTabSelected!(index);
    } else {
      // Fallback for standalone page navigation
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/recommendation');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/profile');
      }
    }
  }

  void _showChatbotDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/images/icon_chatbot.png',
                width: 65,
                height: 65,
              ),
              const SizedBox(height: 12),
              const Text(
                'Ecowalk Assistant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A6556),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Halo! Ada yang bisa saya bantu untuk merencanakan rute atau liburan serumu hari ini?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5, color: Colors.black87),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A6556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Mulai Tanya',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    const barHeight = 62.0;
    const buttonDiameter = 72.0;

    final slotWidth = screenWidth / 4;
    final floatingOffset = (slotWidth - buttonDiameter) / 2;

    // Calculate dynamic left offset for sliding floating button
    double targetLeft;
    if (widget.currentIndex == 0) {
      targetLeft = floatingOffset.clamp(8.0, 32.0);
    } else if (widget.currentIndex == 1) {
      targetLeft = slotWidth + floatingOffset;
    } else if (widget.currentIndex == 3) {
      targetLeft = screenWidth - buttonDiameter - floatingOffset.clamp(8.0, 32.0);
    } else {
      targetLeft = widget.currentIndex * slotWidth + floatingOffset;
    }

    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: barHeight + 24 + bottomInset,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // 1. Green bottom bar background
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
                    Expanded(
                      child: InkWell(
                        onTap: () => _onTap(context, 0),
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 220),
                            opacity: widget.currentIndex == 0 ? 0.0 : 1.0,
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 220),
                              scale: widget.currentIndex == 0 ? 0.6 : 1.0,
                              child: _navIcon(Icons.home_outlined, size: 28),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Tab 1: Shield / Verified (Rekomendasi)
                    Expanded(
                      child: InkWell(
                        onTap: () => _onTap(context, 1),
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 220),
                            opacity: widget.currentIndex == 1 ? 0.0 : 1.0,
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 220),
                              scale: widget.currentIndex == 1 ? 0.6 : 1.0,
                              child: _shieldCheckIcon(color: Colors.white, size: 26),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Tab 2: Chat with heart (Konsultasi / Assistant)
                    Expanded(
                      child: InkWell(
                        onTap: () => _onTap(context, 2),
                        child: Center(
                          child: _chatWithHeartIcon(),
                        ),
                      ),
                    ),

                    // Tab 3: Akun / Profile
                    Expanded(
                      child: InkWell(
                        onTap: () => _onTap(context, 3),
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 220),
                            opacity: widget.currentIndex == 3 ? 0.0 : 1.0,
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 220),
                              scale: widget.currentIndex == 3 ? 0.6 : 1.0,
                              child: _navIcon(Icons.person, size: 28),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Sliding Active Floating Tab Button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeInOutCubic,
              left: targetLeft,
              bottom: bottomInset + 4,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.88, end: 1.0).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey<int>(widget.currentIndex),
                  child: _buildActiveFloatingTab(widget.currentIndex),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFloatingTab(int index) {
    if (index == 0) {
      return _floatingTabButton(
        icon: Icons.home_outlined,
        label: 'BERANDA',
      );
    } else if (index == 1) {
      return _floatingTabButton(
        customIcon: _shieldCheckIcon(color: const Color(0xFF1A6556), size: 28),
        label: 'REKOMENDASI',
      );
    } else if (index == 3) {
      return _floatingTabButton(
        icon: Icons.person,
        label: 'AKUN',
      );
    }
    return const SizedBox.shrink();
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
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
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
