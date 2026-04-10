import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CaregiverSearchbar extends StatefulWidget {
  const CaregiverSearchbar({super.key});

  @override
  State<CaregiverSearchbar> createState() => _CaregiverSearchbarState();
}

class _CaregiverSearchbarState extends State<CaregiverSearchbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          //TODO: Enhanced caregiver SEO system
          child: CupertinoTextField(
            cursorColor: Colors.black,
            cursorRadius: const Radius.circular(100),

            placeholder: 'Find Caregiver...',
            padding: const EdgeInsets.all(12),
            prefix: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: SvgPicture.asset('assets/vectors/search.svg'),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        SizedBox(width: 14),
        GestureDetector(
          //TODO: add caregiver system
          onTap: () {},
          child: SvgPicture.asset('assets/vectors/add_caregiver.svg'),
        ),
      ],
    );
  }
}
