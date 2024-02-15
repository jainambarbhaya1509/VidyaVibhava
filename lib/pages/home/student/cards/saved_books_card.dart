import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksCard extends ConsumerStatefulWidget {
  const BooksCard({super.key});

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
        border: Border.all(
          color: Colors.grey.shade600,
        ),
      ),
      child: Text(
        "Books Card"
      ),
    );
  }
}
