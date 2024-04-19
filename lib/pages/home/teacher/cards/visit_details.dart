import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/scheduled_visits.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisitDetails extends ConsumerStatefulWidget {
  final int visitId;
  const VisitDetails({super.key, required this.visitId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VisitDetailsState();
}

class _VisitDetailsState extends ConsumerState<VisitDetails> {
  @override
  Widget build(BuildContext context) {
    final visitData = ref.watch(visitProvider.notifier).state;
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: GeneralAppText(
                  text: vists[widget.visitId]['title'],
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(2),
                width: 100,
                decoration: BoxDecoration(
                    color: vists[widget.visitId]["status"]
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: GeneralAppText(
                    text: vists[widget.visitId]["status"]
                        ? "Completed"
                        : "Pending",
                    size: 15,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GeneralAppText(
            text: "Venue: ${vists[widget.visitId]["fullLocation"]}",
            size: 17,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              GeneralAppText(
                text: "Date: ${vists[widget.visitId]["date"]}",
                size: 17,
              ),
              const Spacer(),
              GeneralAppText(
                text: "Time: ${vists[widget.visitId]["time"]}",
                size: 17,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GeneralAppText(
            text: "About the visit",
            size: 17,
            weight: FontWeight.bold,
          ),
          GeneralAppText(
            text: vists[widget.visitId]['description'],
            size: 15,
          ),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(bottom: 90),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    visitData[widget.visitId]["status"] = true;
                  });
                  Navigator.pop(context);
                },
                child: PrimaryAppText(
                  text: visitData[widget.visitId]["status"]
                      ? "Completed"
                      : "Complete Visit",
                  size: 17,
                  color: primaryColor,
                  weight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
