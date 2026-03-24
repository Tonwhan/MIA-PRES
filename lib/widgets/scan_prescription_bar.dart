import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ScanPrescriptionBar extends StatefulWidget {
  const ScanPrescriptionBar({super.key});

  @override
  State<ScanPrescriptionBar> createState() => _ScanPrescriptionBarState();
}

class _ScanPrescriptionBarState extends State<ScanPrescriptionBar>
    with TickerProviderStateMixin {
  late AnimationController _actionController;
  late AnimationController _waveController;
  late Animation<double> _glowAnimation;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    _actionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Continuous 6-second cycle for the glowing border edge
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat(); // Continues infinitely from 0.0 to 1.0

    _spinAnimation = CurvedAnimation(
      parent: _actionController,
      curve: Curves.easeInOutCubic,
    );

    _glowAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_actionController);

    _startAnimationLoop();
  }

  void _startAnimationLoop() async {
    while (mounted) {
      await _actionController.forward(from: 0.0);
      if (!mounted) break;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  void dispose() {
    _actionController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: Navigate to scan prescription page
      onTap: () {},
      child: AnimatedBuilder(
        animation: Listenable.merge([_actionController, _waveController]),
        builder: (context, child) {
          final actionGlow = _glowAnimation.value;
          // Progress of the rotation (0 to 1)
          final waveProgress = _waveController.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Container(
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: [
                    Color(0XFF4D6630),
                    Color(0XFF4D6630),
                    Color(0XFF99CC5F).withValues(alpha: 0.3),
                    Color(0XFFc1e19d), // Brightest highlight color
                    Color(0XFF99CC5F).withValues(alpha: 0.3),
                    Color(0XFF4D6630),
                    Color(0XFF4D6630),
                  ],
                  // Wrap stops so the very beginning and end are the same color for a seamless rotation
                  stops: [0.0, 0.4, 0.47, 0.5, 0.53, 0.6, 1.0],
                  // Spin 360 degrees linearly
                  transform: GradientRotation(waveProgress * 2 * math.pi),
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  2.0,
                ), // 2.0 exposes the edge of the Container to look like a stroke
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.variant2,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RotationTransition(
                          turns: _spinAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Opacity(
                                opacity: 0.5 + (0.5 * actionGlow),
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 10 + (5 * actionGlow),
                                    sigmaY: 10 + (5 * actionGlow),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/vectors/gemini.svg",
                                    colorFilter: ColorFilter.mode(
                                      Color(0XFF85CC17),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset("assets/vectors/gemini.svg"),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        GradientText(
                          "Start Scan Your Prescription",
                          colors: [Color(0XFF989898), Color(0XFF323232)],
                          stops: [0.6, 1],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
