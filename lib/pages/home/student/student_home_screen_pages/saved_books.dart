import 'package:final_project/pages/common/books/books_modal.dart';
import 'package:final_project/pages/common/books/ebooks_screen.dart';
import 'package:final_project/pages/home/student/cards/saved_books_card.dart';
import 'package:final_project/providers/books_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_icon.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedBooks extends ConsumerStatefulWidget {
  const SavedBooks({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedBooksState();
}

class _SavedBooksState extends ConsumerState<SavedBooks> {
  @override
  Widget build(BuildContext context) {
    final savedBooks = ref.watch(savedBooksProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          forceMaterialTransparency: true,
          title: GeneralAppText(
            text: 'Saved Books',
            size: 20,
            weight: FontWeight.bold,
          )),
      body: savedBooks.isEmpty
          ? Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralAppIcon(
                    icon: Icons.bookmark_border_rounded,
                    color: Colors.grey,
                    size: 50,
                  ),
                  GeneralAppText(
                    text: "Your book collection is empty",
                    size: 23,
                    weight: FontWeight.bold,
                  ),
                  GeneralAppText(
                    text: "Start your collection now!",
                    size: 16,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EbooksScreen()));
                    },
                    child: PrimaryAppText(
                      text: "Library",
                      size: 15,
                      color: primaryColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.464,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.4 / 0.6,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: savedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return BooksModal(
                              imageUrl: savedBooks[index]['imageUrl'],
                              bookTitle: savedBooks[index]['title'],
                            );
                          },
                        );
                      },
                      child: BooksCard(
                        imageUrl: savedBooks[index]['imageUrl'],
                      ));
                },
              ),
            ),
    );
  }
}
