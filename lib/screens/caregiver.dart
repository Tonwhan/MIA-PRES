import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/features/caregiver/widgets/caregiver_header.dart';
import 'package:pillpal/widgets/caregiver_seacrbar.dart';

class Caregiverpage extends StatefulWidget {
  const Caregiverpage({super.key});

  @override
  State<Caregiverpage> createState() => _CaregiverpageState();
}

class _CaregiverpageState extends State<Caregiverpage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 40,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Caregiver',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CaregiverSearchbar(),
                    CaregiverHeader(
                      imgUrl:
                          'https://i.pinimg.com/736x/0b/52/16/0b521669e36adda9c3b2bf8d507bdba5.jpg',
                      name: 'Mrs. Duladee',
                    ),
                    CaregiverHeader(
                      imgUrl:
                          'https://i.pinimg.com/736x/10/77/85/1077858b57c0f377a3553cac4a436d45.jpg',
                      name: 'Mr. Aojaisai',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
