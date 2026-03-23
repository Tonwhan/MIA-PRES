import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/screens/caregiver.dart';
import 'package:pillpal/screens/home.dart';
import 'package:pillpal/screens/more.dart';
import 'package:pillpal/screens/queue.dart';
import 'package:pillpal/screens/scan_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  late final List<Widget> _screenOptions = [
    const Home(),
    const Queuepage(),
    ScanPage(
      onBack: () {
        setState(() {
          _selectedIndex = _previousIndex;
        });
      },
    ),
    const Caregiverpage(),
    const Morepage(),
  ];

  void _onIemTapped(int index) {
    setState(() {
      if (_selectedIndex != 2) {
        _previousIndex = _selectedIndex;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isScanPage = _selectedIndex == 2;

    return Scaffold(
      body: Stack(
        children: [
          _screenOptions[_selectedIndex],
          if (!isScanPage) ...[
            // Nav menu
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 10,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      currentIndex: _selectedIndex,
                      onTap: _onIemTapped,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: AppColors.primary,
                      unselectedItemColor: const Color(0xFF838383),
                      selectedFontSize: 12,
                      unselectedFontSize: 12,
                      enableFeedback: false,
                      items: [
                        _buildNavItem('assets/vectors/home.svg', 'Home', 0),
                        _buildNavItem('assets/vectors/queue.svg', 'Queue', 1),
                        const BottomNavigationBarItem(
                          icon: SizedBox(height: 24),
                          label: 'Scanner',
                        ),
                        _buildNavItem(
                          'assets/vectors/care.svg',
                          'Caregiver',
                          3,
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.more_horiz_rounded),
                          label: 'More',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Scan Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 75),
                child: GestureDetector(
                  onTap: () => _onIemTapped(2),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF000000), Color(0xFF666666)],
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/vectors/scan.svg',
                      width: 32,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String assetPath,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          _selectedIndex == index ? AppColors.primary : const Color(0xFF838383),
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
