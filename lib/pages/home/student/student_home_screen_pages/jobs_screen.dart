import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Future fetchJobs() async {
//   String url = "https://jobs.github.com/positions.json?description=python&location=new+york";
// }

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: GeneralAppText(
            text: "Search Jobs",
            size: 23,
            weight: FontWeight.bold,
          )),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 13),
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/img/teacher2.png"),
                            // scale: 1.0
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GeneralAppText(
                                  text: "Frontend Developer",
                                  size: 18,
                                  weight: FontWeight.bold),
                              GeneralAppText(
                                text: "Meta",
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              GeneralAppText(
                                text:
                                    "Thiruvananthapuram, Maharashtra, India (On-Site)",
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Container();
                          });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: PrimaryAppText(
                        text: "Check Details",
                        size: 15,
                        color: primaryColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
