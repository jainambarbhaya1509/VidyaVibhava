import 'dart:async';
import 'dart:convert';
import 'package:final_project/pages/common/books/books_modal.dart';
import 'package:final_project/style/themes.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EbooksScreen extends StatefulWidget {
  const EbooksScreen({super.key});

  @override
  State<EbooksScreen> createState() => _EbooksScreenState();
}

class _EbooksScreenState extends State<EbooksScreen> {
  List<dynamic> _bookCoverPage = [];
  List<dynamic> _bookTitle = [];

  Future<List<dynamic>> fetchBookData() async {
    List<String> imageUrls = [];
    List<String> bookTitles = [];

    final response = await http.get(Uri.parse('https://gutendex.com/books/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      List<dynamic> results = responseData['results'];

      for (var item in results) {
        if (item['formats'] != null && item['formats']['image/jpeg'] != null) {
          String imageUrl = item['formats']['image/jpeg'];
          imageUrls.add(imageUrl);

          String title = item['title'];
          bookTitles.add(title);
        }
      }
    } else {
      throw Exception('Failed to load data');
    }

    return [imageUrls, bookTitles];
  }

  @override
  void initState() {
    super.initState();
    fetchBookData().then((data) {
      if (mounted) {
        setState(() {
          _bookCoverPage = data.elementAt(0) as List<String>;
          _bookTitle = data.elementAt(1) as List<String>;
        });
      }
    }).catchError((error) {
      if (!mounted) {
        setState(() {
          _bookCoverPage = [];
          _bookTitle = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: 'Library',
          size: 22,
          weight: FontWeight.bold,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                onSubmitted: (value) {},
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Your Books',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _bookCoverPage.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: RefreshIndicator(
                      displacement: 20,
                      color: primaryColor,
                      onRefresh: () => fetchBookData().then((data) {
                        if (mounted) {
                          setState(() {
                            _bookCoverPage = data.elementAt(0) as List<String>;
                            _bookTitle = data.elementAt(1) as List<String>;
                          });
                        }
                      }).catchError((error) {
                        if (!mounted) {
                          setState(() {
                            _bookCoverPage = [];
                            _bookTitle = [];
                          });
                        }
                      }),
                      child: GridView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 4,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _bookCoverPage.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BooksModal(
                                      imageUrl: _bookCoverPage[index],
                                      bookTitle: _bookTitle[index],
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
                                          _bookCoverPage[index],
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
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
}
