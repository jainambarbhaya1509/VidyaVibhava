import 'package:final_project/pages/home/teacher/cards/scheduled_visit_card.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

final visitProvider = StateProvider((ref) => visits);
// diffferent topic visits
List visits = [
  {
    "visitId": "0",
    "title": "A",
    "location": "Mumbai",
    'fullLocation': 'Mumbai, Maharashtra, India',
    "date": "12/12/2021",
    "time": "9:00 AM",
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc.",
    "status": false
  },
  {
    "visitId": "1",
    "title": "B",
    "location": "Mumbai",
    'fullLocation': 'Mumbai, Maharashtra, India',
    "date": "12/12/2021",
    "time": "9:00 AM",
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc.",
    "status": true
  },
  {
    "visitId": "2",
    "title": "C",
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
    final visitData = ref.read(visitProvider);

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
              return ScheduleVisitCard(
                visitId: index.toString(),
                title: visitData[index]['title'] as String,
                location: visitData[index]['location'] as String,
                fullLocation: visitData[index]['fullLocation'] as String,
                date: visitData[index]['date'] as String,
                time: visitData[index]['time'] as String,
                description: visitData[index]['description'] as String,
                status: visitData[index]['status'] as bool,
              );
            }),
      ),
    );
  }
}
