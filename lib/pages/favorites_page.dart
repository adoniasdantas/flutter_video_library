import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_video_library/config/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/favorite_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My favorites"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16,
        ),
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My favorites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Consumer<FavoriteList>(
                    builder: (context, list, child) {
                      return ListView(
                        shrinkWrap: true,
                        children: list.tvShows.keys.map((key) {
                          final show = jsonDecode(list.tvShows[key]!);
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.tvShowPage,
                                arguments: show['id'],
                              );
                            },
                            child: ListTile(
                              leading: show['poster'] != null &&
                                      show['poster'].isNotEmpty
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        show['poster'],
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/unavailable.png',
                                      ),
                                    ),
                              title: Text(show['name']),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
