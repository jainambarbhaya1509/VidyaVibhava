

import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/keep/v1.dart';

class SearchTextBooks extends ConsumerStatefulWidget {
  const SearchTextBooks({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchTextBooksState();
}

class _SearchTextBooksState extends ConsumerState<SearchTextBooks> {
  bool textBookFilter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        forceMaterialTransparency: true,
        title: GeneralAppText(
          text: "Search Textbooks",
          size: 20,
          weight: FontWeight.bold,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                textBookFilter = !textBookFilter;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: GeneralAppIcon(
                icon: textBookFilter == true
                    ? Icons.filter_alt_rounded
                    : Icons.filter_alt_outlined,
                size: 25,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: textBookFilter,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GradeDropdown(),
                SubjectDropdown(),
                LanguageDropdown()
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 144, 178, 237),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage("https://picsum.photos/250?image=9"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

// filter parameter list
List grades = [
  "All",
  'Grade 1',
  'Grade 2',
  'Grade 3',
  'Grade 4',
  'Grade 5',
  'Grade 6',
  'Grade 7',
  'Grade 8',
  'Grade 9',
  'Grade 10',
  'Grade 11',
  'Grade 12'
];
List subjects = [
  "All",
  'Math',
  'Science',
  'English',
  'History',
  'Geography',
  'Art',
  'Music',
  'Physical Education'
];

List language = [
  "All",
  'English',
  'Hindi',
  'Bengali',
  'Telugu',
  'Marathi',
  'Tamil',
  'Urdu',
  'Gujarati',
  'Malayalam',
  'Kannada',
  'Oriya',
  'Punjabi',
  'Assamese',
  'Maithili',
  'Santali',
  'Kashmiri',
  'Nepali',
  'Konkani',
  'Sindhi',
  'Dogri',
  'Manipuri',
];

class GradeDropdown extends StatefulWidget {
  const GradeDropdown({super.key});

  @override
  State<GradeDropdown> createState() => _GradeDropdownState();
}

class _GradeDropdownState extends State<GradeDropdown> {
  String? selectedGrade = grades.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: selectedGrade,
      items: grades
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (String? value) {
        setState(() {
          selectedGrade = value;
        });
      },
    );
  }
}

class SubjectDropdown extends StatefulWidget {
  const SubjectDropdown({super.key});

  @override
  State<SubjectDropdown> createState() => _SubjectDropdownState();
}

class _SubjectDropdownState extends State<SubjectDropdown> {
  String selectedSubject = subjects.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: selectedSubject,
      items: subjects
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (String? value) {
        setState(() {
          selectedSubject = value!;
        });
      },
    );
  }
}

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = language.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      value: selectedLanguage,
      items: language
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (String? value) {
        setState(() {
          selectedLanguage = value!;
        });
      },
    );
  }
}
