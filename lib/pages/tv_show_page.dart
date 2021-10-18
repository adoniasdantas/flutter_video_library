import 'dart:math';

import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../models/tv_show.dart';
import '../repositories/maze_repository.dart';
import '../widgets/tv_show_card.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _TvShowPageState createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  bool loading = false;
  TvShow? show;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadTvShowData();
  }

  Future<void> loadTvShowData() async {
    setState(() {
      loading = true;
    });
    try {
      show = await MazeRepository.loadTvShowData(widget.id);
    } catch (e) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to load data',
          ),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(show?.name ?? ""),
      ),
      body: Builder(builder: (context) {
        if (loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (show == null) {
          return const Center(
            child: Text(
              'Couldn\'t load Tv Show data. Try again later',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16,
              ),
              child: TvShowCard(show: show!),
            ),
            if (show?.episodes != null && show!.episodes!.isNotEmpty)
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    for (var i = 1;
                        i <= int.parse(show!.episodes!.last.season!);
                        i++) ...[
                      SliverHeader(
                        text: 'Season $i',
                        backgroundColor: Colors.grey.shade300,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          show == null
                              ? []
                              : show!.episodes!
                                  .where((episode) =>
                                      episode.season == i.toString())
                                  .map((episode) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.episodePage,
                                        arguments: episode.id,
                                      );
                                    },
                                    child: ListTile(
                                      leading: episode.image != null &&
                                              episode.image!.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                episode.image!,
                                              ),
                                            )
                                          : const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                'assets/images/unavailable.png',
                                              ),
                                            ),
                                      title: Text(episode.name!),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class SliverHeader extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const SliverHeader(
      {Key? key, required this.text, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 40,
        maxHeight: 70,
        child: Container(
          color: backgroundColor,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
