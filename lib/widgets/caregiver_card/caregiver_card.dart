import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/features/caregiver/widgets/caregiver_header.dart';

class CaregiverCard extends StatefulWidget {
  const CaregiverCard({super.key});

  @override
  State<CaregiverCard> createState() => _CaregiverCardState();
}

class _CaregiverCardState extends State<CaregiverCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [AppColors.primary, Color(0xFF4D6630)],
              stops: [0,0.04]
            ),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/vectors/care.svg',
                    width: 42,
                    height: 42,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "My Caregivers",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
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
    );
  }
}
