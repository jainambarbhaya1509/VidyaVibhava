import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CareerQuiz extends ConsumerStatefulWidget {
  const CareerQuiz({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CareerQuizState();
}

class _CareerQuizState extends ConsumerState<CareerQuiz> {
  int _currentPage = 0;

  List<int?> selectedValues = List.filled(7 * 6, null);
  final questions = [
    {
      'I like to work on cars': ['Yes', 'No']
    },
    {
      'I like to do puzzles': ['Yes', 'No']
    },
    {
      'I am good at working independently': ['Yes', 'No']
    },
    {
      'I like to work in teams': ['Yes', 'No']
    },
    {
      'I am an ambitious person, I set goals for myself': ['Yes', 'No']
    },
    {
      'I like to organize things, like files, desks, etc': ['Yes', 'No']
    },
    {
      'I like to build things': ['Yes', 'No']
    },
    {
      'I like to do experiments': ['Yes', 'No']
    },
    {
      'I like to read about art and music': ['Yes', 'No']
    },
    {
      'I like to teach or train people': ['Yes', 'No']
    },
    {
      'I like to try to influence or persuade people': ['Yes', 'No']
    },
    {
      'I have clear instructions to follow': ['Yes', 'No']
    },
    {
      'I like to take care of animals': ['Yes', 'No']
    },
    {
      'I enjoy science': ['Yes', 'No']
    },
    {
      'I enjoy creative writing': ['Yes', 'No']
    },
    {
      'I like trying to help people solve their problems': ['Yes', 'No']
    },
    {
      'I like selling things': ['Yes', 'No']
    },
    {
      "I wouldn't mind working 8 hours a day in an office": ['Yes', 'No']
    },
    {
      'I like putting things together or assembling things': ['Yes', 'No']
    },
    {
      'I enjoy trying to figure out how things work': ['Yes', 'No']
    },
    {
      'I am a creative person': ['Yes', 'No']
    },
    {
      'I am interested in healing people': ['Yes', 'No']
    },
    {
      'I am quick to take on new responsibilities': ['Yes', 'No']
    },
    {
      'I pay attention to details': ['Yes', 'No']
    },
    {
      'I like to cook': ['Yes', 'No']
    },
    {
      'I like to analyze things(problems, situations, etc)': ['Yes', 'No']
    },
    {
      'I like to play instruments or sing': ['Yes', 'No']
    },
    {
      'I enjoy learning about other cultures': ['Yes', 'No']
    },
    {
      'I would like to start my own business': ['Yes', 'No']
    },
    {
      'I like to do filing or typing': ['Yes', 'No']
    },
    {
      'I am a practical person': ['Yes', 'No']
    },
    {
      'I like working with numbers or charts': ['Yes', 'No']
    },
    {
      'I like acting in plays': ['Yes', 'No']
    },
    {
      'I like to get into discussions about issues': ['Yes', 'No']
    },
    {
      'I like to lead': ['Yes', 'No']
    },
    {
      'I am good at keeping records of my work': ['Yes', 'No']
    },
    {
      'I like working outdoors': ['Yes', 'No']
    },
    {
      'I am good at math': ['Yes', 'No']
    },
    {
      'I like to draw': ['Yes', 'No']
    },
    {
      'I like helping people': ['Yes', 'No']
    },
    {
      'I like to give speeches': ['Yes', 'No']
    },
    {
      'I would like to work in an office': ['Yes', 'No']
    }
  ];

  @override
  Widget build(BuildContext context) {
    final careerQuizController =
        PageController(initialPage: _currentPage, keepPage: true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: const CustomAppBar(),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: careerQuizController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: 7,
        itemBuilder: (context, index) {
          final startIndex = index * 6;
          final pageQuestions = questions.sublist(startIndex, startIndex + 6);
          return SingleChildScrollView(
            
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: GeneralAppText(
                      text: '${index + 1}/7',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ),
                  ...pageQuestions.asMap().entries.map((entry) {
                    final questionText = entry.value.keys.first;
                    final options = entry.value.values.first;
                    final questionIndex = startIndex + entry.key;
                    return Container(
                      height: 190,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.8),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: GeneralAppText(
                              text: questionText,
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<int?>(
                                    value: 1,
                                    groupValue: selectedValues[questionIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValues[questionIndex] = value;
                                      });
                                    },
                                  ),
                                  GeneralAppText(
                                    text: options[0],
                                    size: 15,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              // const SizedBox(he: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<int?>(
                                    value: 2,
                                    groupValue: selectedValues[questionIndex],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValues[questionIndex] = value;
                                      });
                                    },
                                  ),
                                  GeneralAppText(
                                    text: options[1],
                                    size: 15,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (_currentPage > 0) {
                  careerQuizController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: PrimaryAppText(
                text: 'Back',
                size: 20,
                weight: FontWeight.bold,
                color: _currentPage > 0
                    ? primaryColor
                    : Colors.grey.withOpacity(0.5),
              ),
            ),
            InkWell(
              onTap: () {
                if (_currentPage < 6) {
                  careerQuizController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: PrimaryAppText(
                text: _currentPage == 6 ? 'Submit' : 'Next',
                size: 20,
                color: _currentPage == 6
                    ? Colors.green
                    : primaryColor,
                    weight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
