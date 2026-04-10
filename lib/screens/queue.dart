import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';

class Queuepage extends StatefulWidget {
  const Queuepage({super.key});

  @override
  State<Queuepage> createState() => _QueuepageState();
}

class _QueuepageState extends State<Queuepage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: AppColors.primary,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text("My Queue"),
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 16,
                ),
                child: Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/vectors/queue_filled.svg'),
                      SizedBox(height: 8),
                      Text(
                        "No Active Queue",
                        style: TextStyle(
                          color: Color(0xFFC1C1C1),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "You don't have any active",
                        style: TextStyle(color: Color(0xFFC1C1C1)),
                      ),
                      Text(
                        "pharmacy queue right now",
                        style: TextStyle(color: Color(0xFFC1C1C1)),
                      ),
                      SizedBox(height: 24),
                      //TODO: Future System: Hospital Queue
                      ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.primary,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                        child: Text("Scan Queue QR Code"),
                      ),
                    ],
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
