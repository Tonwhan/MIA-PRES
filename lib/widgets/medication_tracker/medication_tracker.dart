import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/widgets/medication_tracker/timeline_item.dart';

class MedicationTracker extends StatefulWidget {
  const MedicationTracker({super.key});

  @override
  State<MedicationTracker> createState() => _MedicationTrackerState();
}

class TimelineData {
  final String time;
  final String svgPath;
  final bool isActive;

  TimelineData({
    required this.time,
    required this.svgPath,
    this.isActive = false,
  });
}

class _MedicationTrackerState extends State<MedicationTracker> {
  @override
  Widget build(BuildContext context) {
    final List<TimelineData> steps = [
      TimelineData(
        time: "8:00",
        svgPath: "assets/vectors/day.svg",
        isActive: true,
      ),
      TimelineData(time: "12:00", svgPath: "assets/vectors/day.svg"),
      TimelineData(time: "18:00", svgPath: "assets/vectors/day.svg"),
      TimelineData(time: "21:00", svgPath: "assets/vectors/night.svg"),
    ];

    //Todo Medication tracked
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/vectors/medication.svg"),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today’s Medications",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TODO: Implement medication intake tracking
                      Text(
                        "0 of 4 doses completed",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 10,
                  left: 40,
                  right: 40,
                  child: Container(height: 2, color: Colors.grey.shade300),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: steps
                      .map((data) => timeLineStepItem(data))
                      .toList(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0),
              child: Divider(
                height: 0,
                thickness: 0.5,
                indent: 18,
                endIndent: 18,
              ),
            ),

            // TODO: show medicine from AI prescription scan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amlodipine 5mg - 1 tablets",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "8:00",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.circle, size: 6),
                          SizedBox(width: 8),
                          Text(
                            "After meal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TODO: AI Medicine Guide: Usage and alerts
                    Text(
                      "Used to lower blood pressure.",
                      style: TextStyle(color: Color(0xFF528600)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Never stop taking the medicine yourself.",
                      style: TextStyle(color: Color(0xFFF4405F)),
                    ),
                  ],
                ),
              ),
            ),
            // TODO: Mark medication as taken button
            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                left: 18.0,
                right: 18.0,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: Text(
                  "Mark as Taken",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
