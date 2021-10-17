import 'package:flutter/material.dart';
import 'package:flutter_video_library/models/episode.dart';

import '../models/episode.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.episode,
  }) : super(key: key);
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: IntrinsicHeight(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  image: episode.image != null && episode.image!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                            episode.image!,
                          ),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/unavailable.png'),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${episode.name!}'),
                Text('Season: ${episode.season!}'),
                Text('Number: ${episode.number!}'),
              ],
            ),
          ),
        ],
      ),
      elevation: 2,
    );
  }
}
