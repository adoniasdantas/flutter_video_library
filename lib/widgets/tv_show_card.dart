import 'package:flutter/material.dart';
import 'package:flutter_video_library/models/favorite_list.dart';
import 'package:provider/provider.dart';

import '../models/tv_show.dart';

class TvShowCard extends StatelessWidget {
  const TvShowCard({
    Key? key,
    required this.show,
  }) : super(key: key);

  final TvShow show;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: IntrinsicHeight(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    image: show.poster != null && show.poster!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              show.poster!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                              'assets/images/unavailable.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Name: ${show.name!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Consumer<FavoriteList>(builder: (context, list, child) {
                      final isFavorite = list.tvShows.containsKey(show.id);
                      return IconButton(
                        onPressed: () async {
                          if (isFavorite) {
                            list.removeFromFavorites(show.id!);
                          } else {
                            list.addToFavorites(show);
                          }
                        },
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_outline,
                          color: Colors.black,
                        ),
                      );
                    }),
                  ],
                ),
                Text('Genres: ${show.genres!.join(', ')}'),
                Text('Days: ${show.days!.join(', ')}'),
                Text('Time ${show.time}'),
                Text('Summary: ${show.getSummary()}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
