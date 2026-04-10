import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/services/session/session_manager.dart';
import 'package:pillpal/widgets/caregiver_card/caregiver_card.dart';
import 'package:pillpal/widgets/dashboard_header.dart';
import 'package:pillpal/widgets/fade_up_animation.dart';
import 'package:pillpal/widgets/medication_tracker/tracker_placeholder.dart';
import 'package:pillpal/widgets/scan_prescription_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SessionManager().hasHomeAnimationPlayed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldAnimate = !SessionManager().hasHomeAnimationPlayed;
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
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    shouldAnimate
                        ? const FadeUpAnimation(
                            delay: Duration(milliseconds: 100),
                            child: DashboardHeader(),
                          )
                        : const DashboardHeader(),
                    shouldAnimate
                        ? const FadeUpAnimation(
                            delay: Duration(milliseconds: 200),
                            child: ScanPrescriptionBar(),
                          )
                        : const ScanPrescriptionBar(),
                    shouldAnimate
                        ? const FadeUpAnimation(
                            delay: Duration(milliseconds: 300),
                            child: EmptyMedicationTracker(),
                          )
                        : const EmptyMedicationTracker(),
                    shouldAnimate
                        ? const FadeUpAnimation(
                            delay: Duration(milliseconds: 400),
                            child: CaregiverCard(),
                          )
                        : const CaregiverCard(),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 25,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.backgroundColor,
                          AppColors.backgroundColor.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                left: 0,
                right: 0,
                height: 110,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.0),
                          AppColors.primary.withValues(alpha: 0.5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
