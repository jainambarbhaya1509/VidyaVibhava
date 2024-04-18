import 'package:final_project/widgets/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SavedVideos extends ConsumerStatefulWidget {
  const SavedVideos({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedVideosState();
}

class _SavedVideosState extends ConsumerState<SavedVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: GeneralAppText(
          text: "Saved Videos",
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
