import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/signup_providers.dart';
import 'package:final_project/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class OrganizatonInformationSection extends ConsumerStatefulWidget {
  const OrganizatonInformationSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrganizatonInformationSection();
}

TextEditingController organizationController = TextEditingController();

class _OrganizatonInformationSection
    extends ConsumerState<OrganizatonInformationSection>
    with AutomaticKeepAliveClientMixin {
  bool isMentor = false;
  bool isCddaAffiliated = false;

  @override
  bool get wantKeepAlive => true;

  static final List<String> _subjects = [
    'Language',
    'Maths',
    'Physics',
    'Chemistry',
    'Biology',
    'Geography',
    'History',
  ];

  List<String> selectedSubjects = [];

  @override
  void initState() {
    selectedSubjects = _subjects;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = ref.watch(settingsProvider);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppText(
              text: "Organization Information",
              size: 20,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: organizationController,
              decoration: InputDecoration(
                labelText: "School/College/Organization",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                ref
                    .read(teacherOganizationInfoProvider.notifier)
                    .state['organization'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GeneralAppText(
              text: "Is your organization affiliated with CDDA?",
              size: 15,
            ),
            Switch(
              value: isCddaAffiliated,
              onChanged: (value) {
                setState(() {
                  isCddaAffiliated = value;
                });

                ref
                    .read(teacherOganizationInfoProvider.notifier)
                    .state['cddaAffiliated'] = value;
              },
              activeColor: primaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.isLightMode == true ? textColor1 : textColor2,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MultiSelectDialogField(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                buttonText: const Text(
                  "Subject Preference",
                  style: TextStyle(height: 3),
                ),
                selectedColor:
                    theme.isLightMode == true ? textColor1 : textColor2,
                separateSelectedItems: true,
                itemsTextStyle: TextStyle(
                  color: theme.isLightMode == true ? textColor1 : textColor2,
                ),
                title: GeneralAppText(
                  text: "Select Subjects",
                  size: 15,
                ),
                autovalidateMode: AutovalidateMode.always,
                items: _subjects.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  setState(() {
                    selectedSubjects = values;
                    ref
                        .read(teacherOganizationInfoProvider.notifier)
                        .state['subjects'] = values;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GeneralAppText(
              text: "Apply as mentor",
              size: 15,
            ),
            Switch(
              value: isMentor,
              onChanged: (value) {
                setState(() {
                  isMentor = value;
                  ref
                      .read(teacherOganizationInfoProvider.notifier)
                      .state['isMentor'] = value;
                });
              },
              activeColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
