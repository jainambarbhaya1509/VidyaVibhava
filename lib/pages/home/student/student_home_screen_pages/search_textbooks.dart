import 'package:final_project/pages/home/student/student_home_screen_pages/home_screen.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).width * 0.5,
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  margin: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 144, 178, 237),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image:
                              NetworkImage("https://picsum.photos/250?image=9"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GeneralAppText(
                  text: "The Brief History Of Modern India",
                  weight: FontWeight.bold,
                  size: 19,
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    """India's civilization is one of the oldest in the world, with evidence of cave paintings and stone tools indicating that the first signs of human activity date back to 400,000–200,000 BC. The Harappan people, who lived along the Indus River, were one of the first sophisticated societies to inhabit India, with their own writing system, social and economic system, and urban cities and architecture. """,
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryAppText(text: "Download Textbook", size: 15, color: primaryColor, weight: FontWeight.bold,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// filter parameter list
List grades = [
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
