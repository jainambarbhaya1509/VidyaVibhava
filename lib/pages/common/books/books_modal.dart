// ignore_for_file: must_be_immutable

import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/providers/books_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

class BooksModal extends ConsumerStatefulWidget {
  BooksModal({
    super.key,
    required this.imageUrl,
    required this.bookTitle,
  });
  String imageUrl, bookTitle;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BooksModalState();
}

class _BooksModalState extends ConsumerState<BooksModal> {
  double baseFontSize = 26.0;

  @override
  Widget build(BuildContext context) {
    double fontSize = widget.bookTitle.length > baseFontSize
        ? baseFontSize - (widget.bookTitle.length * 0.1)
        : baseFontSize - (widget.bookTitle.length * 0.4);
    final appBarState = ref.read(settingsProvider.notifier);
    final savedBooks = ref.watch(savedBooksProvider);
    Logger().e(savedBooks);

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
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
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
                        Flexible(
                          child: GeneralAppText(
                            text: widget.bookTitle,
                            size: fontSize - 5,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (savedBooks
                                    .map((e) => e["title"])
                                    .contains(widget.bookTitle.toString())) {
                                  setState(() {
                                    ref.read(savedBooksProvider).removeWhere(
                                          (element) =>
                                              element["title"] ==
                                              widget.bookTitle,
                                        );
                                  });
                                } else {
                                  setState(() {
                                    ref.read(savedBooksProvider).add({
                                      "title": widget.bookTitle,
                                      "imageUrl": widget.imageUrl,
                                    });
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GeneralAppIcon(
                                        icon: savedBooks
                                                .map((e) => e["title"])
                                                .contains(
                                                    widget.bookTitle.toString())
                                            ? Icons.check
                                            : Icons.add_circle_outline,
                                        color: appBarState.isLightMode
                                            ? textColor1
                                            : textColor2,
                                        size: 17,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GeneralAppText(
                                        text: savedBooks
                                                .map((e) => e["title"])
                                                .contains(
                                                    widget.bookTitle.toString())
                                            ? "Saved"
                                            : "Save",
                                        size: 17,
                                        color: Theme.of(context).primaryColor,
                                        weight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
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
                              child: GestureDetector(
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GeneralAppIcon(
                                        icon: Icons.save_alt_outlined,
                                        color: appBarState.isLightMode
                                            ? textColor1
                                            : textColor2,
                                        size: 17,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GeneralAppText(
                                        text: "Download",
                                        size: 17,
                                        color: Theme.of(context).primaryColor,
                                        weight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
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
                alignment: Alignment.topLeft,
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
                      text: widget.bookTitle,
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
