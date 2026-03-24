import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'dart:math' as math;

class OnboardingLastPage extends StatelessWidget {
  const OnboardingLastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkBackground =
        ThemeData.estimateBrightnessForColor(AppColors.backgroundColor) ==
        Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: isDarkBackground
            ? Brightness.dark
            : Brightness.light,
        statusBarIconBrightness: isDarkBackground
            ? Brightness.dark
            : Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor1,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 42.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 220.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: OverflowBox(
                          maxWidth: double.infinity,
                          //Second Row
                          child: Row(
                            children: [
                              Container(
                                height: 200,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6A6A6A),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildTextBar(135, height: 12),
                                      _buildTextBar(105, height: 12),
                                      const Spacer(),
                                      _buildTextBar(105),
                                      _buildTextBar(79),
                                      _buildTextBar(100),
                                      _buildTextBar(65),
                                      _buildTextBar(72),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 18),
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/vectors/chart.svg',
                                      ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          SvgPicture.asset(
                                            'assets/vectors/medicines.svg',
                                            width: 90,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Meet our\nspecial feature',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: OverflowBox(
                        maxWidth: double.infinity,
                        //First Row
                        child: Row(
                          children: [
                            Transform.rotate(
                              angle: -12 * (math.pi / 180),
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 32,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/vectors/check_circle.svg',
                                      ),
                                    ),
                                    SizedBox(height: 52),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 18.0,
                                      ),
                                      child: Text(
                                        'Your medications,\nExplained\nSimplify',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 18),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: const BoxDecoration(
                                color: Color(0xFF6A6A6A),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/vectors/medi_board.svg',
                                    ),
                                    SizedBox(height: 18),
                                    Text(
                                      'Scan your \nprescription \ninstantly, \nno medical \nknowledge needed',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Text(
                      "Never miss a dose,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "never feel confused again",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextBar(double width, {double height = 8}) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFD9D9D9).withValues(alpha: 0.3),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
    ),
  );
}
