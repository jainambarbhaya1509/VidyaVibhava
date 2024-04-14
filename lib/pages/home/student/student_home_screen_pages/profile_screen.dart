import 'package:final_project/pages/common/books/books_modal.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/edit_student_profile.dart';
import 'package:final_project/pages/home/student/cards/lecture_details.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/pages/home/student/cards/saved_lecture_card.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/explore_schemes.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/student_stats.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/enrolled_courses.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/student_screen_provider.dart';
import 'package:final_project/repository/authentication_repository.dart';
import 'package:final_project/style/painter.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:googleapis/appengine/v1.dart';

import '../../../common/start_screen.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<StudentProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    final appBarNotifier = ref.watch(settingsProvider.notifier);
    final theme = ref.watch(settingsProvider);
    final appBarState = ref.watch(settingsProvider);

    final savedBooks = ref.watch(savedBooksProvider.notifier).state;
    final imageUrl = savedBooks["imageUrl"];
    final bookTitle = savedBooks["bookTitle"];

    final savedLectures = ref.watch(savedLecturesProvidrer);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'My Profile',
          size: 23,
          weight: FontWeight.bold,
        ),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                padding: const EdgeInsets.only(right: 30),
                icon: GeneralAppIcon(
                  icon: Icons.settings,
                  color: theme.isLightMode == true ? textColor1 : textColor2,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        foregroundColor: Colors.white,
                        radius: 35,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: CircleAvatar(
                          radius: 50,

                          // Image from firebase
                          backgroundImage: Image.network(
                            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ).image,
                        ),
                      ),
                    ),
                    // username from firebase
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: GeneralAppText(
                        text: 'User Name',
                        size: 20,
                        weight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              ListBody(
                children: [
                  ListTile(
                    leading: GeneralAppIcon(
                      icon: appBarState.isLightMode
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: GeneralAppText(
                      text: 'Change Theme',
                      size: 16,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      appBarNotifier.isLightMode = !appBarNotifier.isLightMode;
                      appBarNotifier.savePreferences();
                    },
                  ),
                  ListTile(
                    leading: GeneralAppIcon(
                      icon: Icons.language,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 400,
                        onChanged: (String? value) {
                          setState(() {
                            appBarNotifier.selectedLang = value!;
                            appBarNotifier.savePreferences();
                          });
                        },
                        value: appBarState.selectedLang,
                        items: langs.keys.map<DropdownMenuItem<String>>(
                          (e) {
                            return DropdownMenuItem(
                              value: e,
                              child: DropdownText(
                                text: e,
                                size: 16,
                                weight: FontWeight.bold,
                                color: theme.isLightMode == true
                                    ? textColor1
                                    : textColor2,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: GeneralAppIcon(
                      icon: Icons.play_circle,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: GeneralAppText(
                      text: 'Enrolled Courses',
                      size: 16,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EnrolledCourses();
                      }));
                    },
                  ),
                  ListTile(
                    leading: GeneralAppIcon(
                      icon: Icons.explore,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: GeneralAppText(
                      text: 'Explore Schemes',
                      size: 16,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ExploreSchemes();
                      }));
                    },
                  ),
                  ListTile(
                    leading: GeneralAppIcon(
                      icon: Icons.person,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: GeneralAppText(
                      text: 'Edit Profile',
                      size: 16,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: GeneralAppIcon(
                      icon: Icons.logout,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    title: PrimaryAppText(
                      text: 'Log Out',
                      size: 16,
                      weight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                    onTap: () {
                      AuthenticationRepository.instance.signOut();
                      Navigator.push(context,MaterialPageRoute(builder: (context) {return StartScreen();}));},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                      ),
                      height: 100,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SecondaryAppText(
                          text: "Jainam Barbhaya",
                          size: 22,
                          color: theme.isLightMode == true
                              ? textColor1
                              : textColor2,
                          weight: FontWeight.bold,
                        ),
                        SecondaryAppText(
                          text: "jainambarbhaya",
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (builder) {
                              return EditStudentProfile();
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        child: FittedBox(
                          child: GeneralAppText(
                            text: "Edit Profile",
                            size: 15,
                            color: Theme.of(context).primaryColor,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (builder) {
                              return StudentStats();
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        child: FittedBox(
                          child: GeneralAppText(
                            text: "Analysis",
                            size: 15,
                            color: Theme.of(context).primaryColor,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: TabBar(
                labelColor: theme.isLightMode == true ? textColor1 : textColor2,
                dividerColor: Theme.of(context).primaryColor,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                unselectedLabelColor:
                    theme.isLightMode == true ? textColor1 : textColor2,
                indicator: const CutomTabIndicator(
                  color: primaryColor,
                  radius: 3,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                controller: tabController,
                tabs: const [
                  Tab(
                    text: "Saved Books",
                  ),
                  Tab(
                    text: "Saved Lectures",
                  ),
                ],
              ),
            ),

            // saved books
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.464,
              width: double.maxFinite,
              child: TabBarView(
                controller: tabController,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.464,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.4 / 0.6,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: savedBooks["imageUrl"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                context: context,
                                builder: (context) {
                                  return BooksModal(
                                    imageUrl: imageUrl[index],
                                    bookTitle: bookTitle[index],
                                  );
                                },
                              );
                            },
                            child: BooksCard(
                              imageUrl: imageUrl[index],
                            ));
                      },
                    ),
                  ),

                  // lectures
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.464,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.4 / 0.6,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: savedLectures.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                context: context,
                                builder: (context) {
                                  return LectureCard();
                                },
                              );
                            },
                            child: BooksCard(
                              imageUrl: imageUrl[index],
                            ));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          // getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          primaryColor.withOpacity(0.8),
          primaryColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
