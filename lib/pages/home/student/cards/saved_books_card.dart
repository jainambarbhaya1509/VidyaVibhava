import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksCard extends ConsumerStatefulWidget {
  final String imageUrl;
  const BooksCard({
    super.key,
    required this.imageUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BooksCardState();
}

class _BooksCardState extends ConsumerState<BooksCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(widget.imageUrl, scale: 1.0),
        ),
      ),
    );
  }
}
