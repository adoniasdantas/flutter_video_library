import 'package:flutter/material.dart';

import '../models/tv_show.dart';

class TvShowCard extends StatelessWidget {
  const TvShowCard({
    Key? key,
    required this.show,
    required this.isFavorite,
    required this.addToFavorites,
    required this.removeFromFavorites,
  }) : super(key: key);

  final TvShow show;
  final bool isFavorite;
  final Function addToFavorites;
  final Function removeFromFavorites;

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
                    IconButton(
                      onPressed: () async {
                        if (isFavorite) {
                          removeFromFavorites(show.id!);
                        } else {
                          addToFavorites(show);
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_outline,
                        color: Colors.black,
                      ),
                    ),
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
