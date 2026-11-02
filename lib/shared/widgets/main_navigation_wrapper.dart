import 'package:flutter/material.dart';
import 'package:tugas_1/features/home/presentation/home_page.dart';
import 'package:tugas_1/features/recommendation/presentation/recommendation_page.dart';
import 'package:tugas_1/features/profile/presentation/profile_page.dart';
import 'package:tugas_1/shared/widgets/custom_bottom_navigation.dart';

class MainNavigationWrapper extends StatefulWidget {
  final int initialIndex;

  const MainNavigationWrapper({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  late int _currentSlotIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentSlotIndex = widget.initialIndex;
    final initialPage = _slotToPage(_currentSlotIndex);
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _slotToPage(int slotIndex) {
    if (slotIndex == 3) return 2;
    if (slotIndex == 1) return 1;
    return 0;
  }

  void _onTabSelected(int slotIndex) {
    if (slotIndex == 2) return; // Handled as modal in bottom nav
    if (slotIndex == _currentSlotIndex) return;

    setState(() {
      _currentSlotIndex = slotIndex;
    });

    final targetPage = _slotToPage(slotIndex);
    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Only navigate through bottom tabs
        children: const [
          HomePage(showBottomNav: false),
          RecommendationPage(showBottomNav: false),
          ProfilePage(showBottomNav: false),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentSlotIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
