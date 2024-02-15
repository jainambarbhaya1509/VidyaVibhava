import 'package:final_project/pages/home/student/cards/books_modal.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/painter.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_bar.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    final appBarNotifier = ref.watch(settingsProvider.notifier);
    final theme = ref.watch(settingsProvider);
    final appBarState = ref.watch(settingsProvider);
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
                      icon: Icons.rocket_outlined,
                      color:
                          theme.isLightMode == true ? textColor1 : textColor2,
                      size: 20,
                    ),
                    title: GeneralAppText(
                      text: 'Chat Bot',
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
                      Navigator.pop(context);
                    },
                  )
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                  ),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.23,
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
                  children: [
                    GeneralAppText(
                      text: "Jainam Barbhaya",
                      size: 20,
                    ),
                    GeneralAppText(
                      text: "jainambarbhaya",
                      size: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.3,
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
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.3,
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
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              isDismissible: true,
                              context: context,
                              builder: (context) {
                                return const BooksModal();
                              },
                            );
                          },
                          child: BooksCard(),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.464,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8 / 0.25,
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              isDismissible: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    index.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            child: Text(
                              index.toString(),
                            ),
                          ),
                        );
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
