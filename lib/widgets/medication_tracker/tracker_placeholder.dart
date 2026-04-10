import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pillpal/core/animations/no_animation_page_route.dart';
import 'package:pillpal/screens/scan_screen.dart';

class EmptyMedicationTracker extends StatefulWidget {
  const EmptyMedicationTracker({super.key});

  @override
  State<EmptyMedicationTracker> createState() => _EmptyMedicationTrackerState();
}

class _EmptyMedicationTrackerState extends State<EmptyMedicationTracker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/vectors/medication.svg"),
                  SizedBox(width: 8),
                  Text(
                    "Today’s Medications",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No medications yet",
                    style: TextStyle(color: Color(0xFFA9A9A9)),
                  ),
                  Text(
                    "Add to get started",
                    style: TextStyle(color: Color(0xFFA9A9A9)),
                  ),
                ],
              ),
            ),
            Divider(height: 0, thickness: 0.5, indent: 18, endIndent: 18),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          NoAnimationRoute(page: ScanPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        overlayColor: Colors.transparent,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Scan Prescription",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  //TODO: Route to add medications manual page
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        overlayColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Add manually",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
