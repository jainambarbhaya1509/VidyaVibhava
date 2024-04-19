import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveVideoCard extends ConsumerStatefulWidget {
  final String videoId,
      videoTitle,
      videoDescription,
      videoDuration,
      videoCreator,
      videoUrl;
  final bool isSaved;
  const SaveVideoCard({
    super.key,
    required this.videoId,
    required this.videoTitle,
    required this.videoDescription,
    required this.videoDuration,
    required this.videoCreator,
    required this.videoUrl,
    required this.isSaved,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveVideoCardState();
}

class _SaveVideoCardState extends ConsumerState<SaveVideoCard> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    return Container(
      margin: const  EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.isLightMode
            ? const Color.fromARGB(211, 228, 228, 228)
            : const Color.fromARGB(255, 54, 54, 54),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.videoUrl, scale: 1.0),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GeneralAppText(
                  text: widget.videoTitle,
                  size: 17,
                  weight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralAppText(text: "By: ${widget.videoCreator}", size: 15),
                  const SizedBox(width: 10),
                  GeneralAppText(
                      text: "Duration: ${widget.videoDuration}", size: 15),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  widget.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // setState(() {
                  //   widget.isSaved = !widget.isSaved;
                  // });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
