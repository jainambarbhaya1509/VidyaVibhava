import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksModal extends ConsumerStatefulWidget {
  const BooksModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BooksModalState();
}

class _BooksModalState extends ConsumerState<BooksModal> {
  String bookTitle =
      'The Merchant Of Venice';
  double baseFontSize = 26.0;

  @override
  Widget build(BuildContext context) {
    double fontSize = bookTitle.length > baseFontSize
        ? baseFontSize - (bookTitle.length * 0.1)
        : baseFontSize - (bookTitle.length * 0.4);
    final appBarState = ref.read(settingsProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
              ),
              height: MediaQuery.of(context).size.height * 0.22,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_640.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GeneralAppText(
                          text: bookTitle,
                          size: fontSize,
                          weight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GeneralAppIcon(
                                      icon: Icons.bookmark_border,
                                      color: appBarState.isLightMode
                                          ? textColor1
                                          : textColor2,
                                      size: 17,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GeneralAppText(
                                      text: "Save",
                                      size: 17,
                                      color: Theme.of(context).primaryColor,
                                      weight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GeneralAppIcon(
                                      icon: Icons.chrome_reader_mode_outlined,
                                      color: appBarState.isLightMode
                                          ? textColor1
                                          : textColor2,
                                      size: 17,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GeneralAppText(
                                      text: "Read",
                                      size: 17,
                                      color: Theme.of(context).primaryColor,
                                      weight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralAppText(
                      text: "Description",
                      size: 17,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GeneralAppText(
                      text:
                          "The Merchant of Venice is a 16th-century play written by William Shakespeare in which a merchant in Venice named Antonio defaults on a large loan provided by a Jewish moneylender, Shylock. It is believed to have been written between 1596 and 1599.",
                      size: 14,
                      weight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
