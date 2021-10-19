import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../models/favorite_list.dart';
import '../models/tv_show.dart';
import '../repositories/maze_repository.dart';
import '../widgets/tv_show_card.dart';

enum SearchType {
  pagination,
  search,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  var shows = <TvShow>[];
  var loading = false;
  int page = 1;
  SearchType searchType = SearchType.pagination;

  @override
  void initState() {
    super.initState();
    loadFavoritesTvShows();
    loadTvShowsPage(page);
  }

  Future<void> loadFavoritesTvShows() async {
    await FavoriteList.loadFavoritesTvShows();
  }

  Future<void> loadTvShowsPage(int index) async {
    setState(() {
      loading = true;
    });
    final newShowList = await MazeRepository.loadTvShowsPage(
      index,
    );
    setState(() {
      if (index > 1) {
        shows += newShowList;
      } else {
        shows = newShowList;
      }
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Show'),
        leading: InkWell(
          child: const Icon(Icons.star),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.favoritesPage);
          },
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchPeoplePage);
                },
                child: const Text('Search People'),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 55,
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          hintText: 'What series are you looking for?',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Icon(Icons.search),
                            Text('Search'),
                          ],
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                            searchType = SearchType.search;
                            shows.clear();
                          });
                          final newShowList =
                              await MazeRepository.searchTvShows(
                            searchController.text,
                          );
                          setState(() {
                            shows = newShowList;
                            loading = false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (!loading && shows.isEmpty) const Text('No items found'),
              if (loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Expanded(
                child: ListView.separated(
                  itemCount: shows.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final show = shows[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.tvShowPage,
                          arguments: show.id,
                        );
                      },
                      child: TvShowCard(show: show),
                    );
                  },
                ),
              ),
              if (searchType == SearchType.pagination)
                ElevatedButton(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Text('Load more'),
                    ],
                  ),
                  onPressed: () async {
                    await loadTvShowsPage(++page);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
