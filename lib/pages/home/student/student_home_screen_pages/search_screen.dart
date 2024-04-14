import 'dart:io';

import 'package:final_project/controllers/video_controller.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:final_project/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../models/backend_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String? searchId;
  final String? instructorName;
  const SearchScreen({super.key, this.searchId, this.instructorName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchQuery = TextEditingController();
  final controller = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);

    if (widget.instructorName != null) {
      searchQuery.text = (widget.instructorName)!;
    }
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: GeneralAppText(
              text: "Search",
              size: 23,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.isLightMode
                  ? const Color.fromARGB(211, 228, 228, 228)
                  : const Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: null,
              decoration: InputDecoration(
                hintText: "search a video/course",
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showFilterDialog(context);
                  },
                  child: GeneralAppIcon(
                      icon: Icons.filter_alt_sharp, color: Colors.grey),
                ),
                prefixIcon: GestureDetector(
                    onTap: () {
                      print("Search Clicked");
                      _performSearch();
                    },
                    child: const Icon(Icons.search)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (builder) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 5,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 190,
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: GeneralAppIcon(
                                          icon: Icons.bookmark_border,
                                          color: theme == true
                                              ? textColor1
                                              : textColor2,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GeneralAppIcon(
                                                icon: Icons.play_arrow_rounded,
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2,
                                                size: 30,
                                              ),
                                              PrimaryAppText(
                                                text: "Start Learning",
                                                size: 20,
                                                color: theme == true
                                                    ? textColor1
                                                    : textColor2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: GeneralAppText(
                                            text: "Description",
                                            size: 20,
                                            weight: FontWeight.bold,
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GeneralAppText(
                                        text:
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia. Nullam nec purus feugiat, molestie ipsum et, eleifend nunc. Ut in nulla ut nisl ultricies lacinia.",
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: GeneralAppText(
                                text: "The brief history of modern india",
                                size: 16,
                                weight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog();
      },
    );
  }

  void _performSearch() {
    print("Search Clicked");
    setState(() {
      _buildFutureBuilder(searchQuery.text);
    });
  }

  Widget _buildFutureBuilder(String searchQuery) {
    print("Entered Function");
    return FutureBuilder(
        future:
            searchQuery.isNotEmpty ? controller.getVideos(searchQuery) : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Waiting");
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final videoList = snapshot.data;
              print(videoList);
              return Container();
            } else {
              print("No data");
              return Container();
            }
          } else {
            print("Else encountered");
            return Container();
          }
        });
  }
}
