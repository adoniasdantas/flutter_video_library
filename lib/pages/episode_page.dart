import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/episode.dart';
import '../repositories/maze_repository.dart';
import '../widgets/episode_card.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  bool loading = false;
  Episode? episode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadEpisodeData();
  }

  Future<void> loadEpisodeData() async {
    setState(() {
      loading = true;
    });
    try {
      episode = await MazeRepository.loadEpisodeData(widget.id);
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(episode?.name ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16,
        ),
        child: Builder(
          builder: (context) {
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (episode == null) {
              return const Center(
                child: Text(
                  'Couldn\'t load episode data. Try again later',
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
                  margin: const EdgeInsets.only(bottom: 12),
                  child: EpisodeCard(episode: episode!),
                ),
                Text(
                  episode?.name ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Season ${episode?.season}, Number ${episode?.number}",
                ),
                Html(
                  data: episode?.getSummary(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
