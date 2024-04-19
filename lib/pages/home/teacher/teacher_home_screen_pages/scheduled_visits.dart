import 'package:final_project/pages/home/teacher/cards/visit_details.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final visitProvider = StateProvider((ref) => vists);

// diffferent topic visits
List vists = [
  {
    "title": "To Educate Children in Rural Areas",
    "location": "Mumbai",
    'fullLocation': 'Mumbai, Maharashtra, India',
    "date": "12/12/2021",
    "time": "9:00 AM",
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc.",
    "status": false
  },
  {
    "title": "To Educate Children in Rural Areas",
    "location": "Mumbai",
    'fullLocation': 'Mumbai, Maharashtra, India',
    "date": "12/12/2021",
    "time": "9:00 AM",
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc.",
    "status": true
  },
  {
    "title": "To Educate Children in Rural Areas",
    "location": "Mumbai",
    'fullLocation': 'Mumbai, Maharashtra, India',
    "date": "12/12/2021",
    "time": "9:00 AM",
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc.",
    "status": false
  },
];

final visit = {};

class ScheduledVisits extends ConsumerStatefulWidget {
  const ScheduledVisits({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduledVisitsState();
}

class _ScheduledVisitsState extends ConsumerState<ScheduledVisits> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider.notifier);
    final visitData = ref.watch(visitProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        forceMaterialTransparency: true,
        title: GeneralAppText(
          text: "Schedule Visits",
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
            itemCount: visitData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
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
                          text: visitData[index]["location"],
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                        const Spacer(),
                        Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: visitData[index]["status"]
                                  ? Colors.green
                                  : Colors.red,
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
                          text: visitData[index]["date"],
                          size: 15,
                        ),
                        SecondaryAppText(
                          text: visitData[index]["time"],
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GeneralAppText(text: visitData[index]['title'], size: 15),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return VisitDetails(visitId: index);
                            });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        child: PrimaryAppText(
                          text: visitData[index]['status']
                              ? "Completed"
                              : "Complete Visit",
                          size: 15,
                          color: primaryColor,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
