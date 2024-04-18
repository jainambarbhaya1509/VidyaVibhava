import 'dart:async';
import 'dart:convert';
import 'package:final_project/pages/common/books/books_modal.dart';
import 'package:final_project/pages/home/student/student_home_screen_pages/saved_books.dart';
import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final booksData = [];

class EbooksScreen extends ConsumerStatefulWidget {
  const EbooksScreen({super.key});

  @override
  ConsumerState<EbooksScreen> createState() => _EbooksScreenState();
}

class _EbooksScreenState extends ConsumerState<EbooksScreen> {
  Future<List<dynamic>> fetchBookData() async {
    final response = await http.get(Uri.parse('https://gutendex.com/books/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      List<dynamic> results = responseData['results'];

      for (var item in results) {
        if (item['formats'] != null && item['formats']['image/jpeg'] != null) {
          Map<String, dynamic> book = {
            'title': item['title'],
            'imageUrl': item['formats']['image/jpeg'],
          };

          if (mounted) {
            setState(() {
              booksData.add(book);
            });
          }
        }
      }
    } else {
      throw Exception('Failed to load data');
    }

    return booksData;
  }

  @override
  void initState() {
    super.initState();
    fetchBookData().then((data) {
      if (mounted) {
        booksData.addAll(data);
      }
    }).catchError((error) {
      if (!mounted) {
        setState(() {
          booksData.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final theme = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'Library',
          size: 20,
          weight: FontWeight.bold,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) => const SavedBooks()));
            },
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: GeneralAppText(
                  text: "Collection",
                  size: 15,
                  weight: FontWeight.bold,
                )),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
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
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "search your books",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            booksData.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: RefreshIndicator(
                      displacement: 20,
                      color: primaryColor,
                      onRefresh: () {
                        booksData.clear();
                        return fetchBookData().catchError((error) {
                          return [];
                        });
                      },
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 4,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: booksData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BooksModal(
                                      imageUrl: booksData[index]["imageUrl"],
                                      bookTitle: booksData[index]["title"],
                                    );
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 10, right: 10),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor,
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          booksData[index]["imageUrl"],
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }

  @override
  void dispose() {
    booksData.clear();
    super.dispose();
  }
}
