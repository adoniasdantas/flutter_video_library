import 'package:flutter/material.dart';
import 'package:flutter_video_library/models/person.dart';

import '../repositories/maze_repository.dart';
import '../widgets/person_card.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  bool loading = false;
  Person? person;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadPersonData();
  }

  Future<void> loadPersonData() async {
    setState(() {
      loading = true;
    });
    try {
      person = await MazeRepository.loadPersonData(widget.id);
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
        title: Text(person?.name ?? ""),
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
            if (person == null) {
              return const Center(
                child: Text(
                  'Couldn\'t load person\'s data. Try again later',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return PersonCard(person: person!);
          },
        ),
      ),
    );
  }
}
