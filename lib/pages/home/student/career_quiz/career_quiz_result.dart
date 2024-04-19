import 'package:final_project/models/backend_model.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/api_service.dart';

class CareerQuizResult extends ConsumerStatefulWidget {
  final List<int> selectedValues;
  const CareerQuizResult(this.selectedValues, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CareerQuizResultState();
}

class _CareerQuizResultState extends ConsumerState<CareerQuizResult> {
  @override
  Widget build(BuildContext context) {
    APIService apiService = APIService();
    final theme = ref.watch(settingsProvider);
    return FutureBuilder(
      future: apiService.getCareerRecommendation(widget.selectedValues),
        builder:(context, snapshot) {
          late Career career;
          try {
            if (snapshot.data != null) {
              career = snapshot.data as Career;
            }
          } on Exception catch (e) {
            return const Center(
                child: CircularProgressIndicator());
          }
          if (snapshot.connectionState ==
              ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GeneralAppText(
                        text: "Congratulations on completing the test!",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      GeneralAppText(
                        text: "Let's see what career suits you best!",
                        size: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Your Results",
                        style: GoogleFonts.lato(
                          color: theme.isLightMode == true ? textColor1 : textColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // height: 500,
                        width: double.infinity,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 5,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: theme.isLightMode == true
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.grey[800],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryAppText(
                                      text: career.careerCategory,
                                      size: 23,
                                      color: primaryColor,
                                      weight: FontWeight.bold),
                                  GeneralAppText(
                                      text: career.careerDescription,
                                      size: 16),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GeneralAppText(
                                    text: "Recommended Path",
                                    size: 19,
                                    weight: FontWeight.bold,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0; i < career.possibleCareers.length; i++)
                                        Row(
                                          children: [
                                            GeneralAppIcon(
                                              icon: Icons.arrow_right_rounded,
                                              color: primaryColor,
                                            ),
                                            GeneralAppText(
                                              text: career.possibleCareers[i],
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GeneralAppText(
                                    text: "Related Pathway",
                                    size: 19,
                                    weight: FontWeight.bold,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0; i < career.relatedPathway.length; i++)
                                        Row(
                                          children: [
                                            GeneralAppIcon(
                                              icon: Icons.arrow_right_rounded,
                                              color: primaryColor,
                                            ),
                                            GeneralAppText(
                                              text: career.relatedPathway[i],
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: GeneralAppIcon(
                                  icon: Icons.home_outlined,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GeneralAppText(
                              text: "Contact Expert",
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
