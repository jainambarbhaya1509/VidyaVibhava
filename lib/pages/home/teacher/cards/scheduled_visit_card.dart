import 'package:final_project/pages/home/teacher/teacher_home_screen_pages/scheduled_visits.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ScheduleVisitCard extends ConsumerStatefulWidget {
  final String visitId, title, location, fullLocation, date, time, description;
  final bool status;
  const ScheduleVisitCard({
    super.key,
    required this.visitId,
    required this.title,
    required this.location,
    required this.fullLocation,
    required this.date,
    required this.time,
    required this.description,
    required this.status,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduleVisitCardState();
}

class _ScheduleVisitCardState extends ConsumerState<ScheduleVisitCard> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier);
    final visitData = ref.read(visitProvider.notifier).state[int.parse(widget.visitId)];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.isLightMode
            ? const Color.fromARGB(255, 230, 230, 230)
            : const Color.fromARGB(255, 64, 64, 64),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SecondaryAppText(
                text: visitData["location"],
                size: 15,
                weight: FontWeight.bold,
              ),
              const Spacer(),
              Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: visitData['status'] ? Colors.green : Colors.red,
                  ))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondaryAppText(
                text: visitData["date"],
                size: 15,
              ),
              SecondaryAppText(
                text: visitData["time"],
                size: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GeneralAppText(text: visitData['title'], size: 15),
          const Spacer(),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return Container(
                      padding:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
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
                                  text: visitData['title'],
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(2),
                                width: 100,
                                decoration: BoxDecoration(
                                    color: widget.status
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: GeneralAppText(
                                    text: widget.status
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
                            text: "Venue: ${visitData["fullLocation"]}",
                            size: 17,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              GeneralAppText(
                                text: "Date: ${visitData["date"]}",
                                size: 17,
                              ),
                              const Spacer(),
                              GeneralAppText(
                                text: "Time: ${visitData["time"]}",
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
                            text: visitData['description'],
                            size: 15,
                          ),
                          const Spacer(),
                          Container(
                              margin: const EdgeInsets.only(bottom: 90),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    visitData[widget.status] = true;
                                  });
                                },
                                child: PrimaryAppText(
                                  text: widget.status
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
                  });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: PrimaryAppText(
                text: "Check Details",
                size: 15,
                color: primaryColor,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
