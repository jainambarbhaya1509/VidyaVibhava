import 'package:final_project/pages/home/student/cards/saved_videos_card.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final savedVideos = [
  {
    'videoId': '0',
    'videoTitle': 'The brief history of time',
    'videoDescription': 'This is a video',
    'videoDuration': '10:00',
    'videoCreator': 'Jainam Dakshesh Barbhaya',
    'videoUrl': 'https://via.placeholder.com/150',
    'isSaved': false
  },
  {
    'videoId': '1',
    'videoTitle': 'The brief history of time',
    'videoDescription': 'This is a video',
    'videoDuration': '10:00',
    'videoCreator': 'Jain Barbhaya',
    'videoUrl': 'https://via.placeholder.com/150',
    'isSaved': false
  },
  {
    'videoId': '2',
    'videoTitle': 'The brief history of time',
    'videoDescription': 'This is a video',
    'videoDuration': '10:00',
    'videoCreator': 'Jai Barbhaya',
    'videoUrl': 'https://via.placeholder.com/150',
    'isSaved': false
  },
];

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
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: savedVideos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: SaveVideoCard(
                  videoId: savedVideos[index]['videoId'] as String,
                  videoTitle: savedVideos[index]['videoTitle'] as String,
                  videoDescription:
                      savedVideos[index]['videoDescription'] as String,
                  videoDuration: savedVideos[index]['videoDuration'] as String,
                  videoCreator: savedVideos[index]['videoCreator'] as String,
                  videoUrl: savedVideos[index]['videoUrl'] as String,
                  isSaved: savedVideos[index]['isSaved'] as bool,
                ),
              );
            }),
      ),
    );
  }
}
