import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../models/person.dart';
import '../repositories/maze_repository.dart';

class SearchPeoplePage extends StatefulWidget {
  const SearchPeoplePage({Key? key}) : super(key: key);

  @override
  _SearchPeoplePageState createState() => _SearchPeoplePageState();
}

class _SearchPeoplePageState extends State<SearchPeoplePage> {
  final searchController = TextEditingController();
  var people = <Person>[];
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search People'),
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
                          hintText: 'Who are you looking for?',
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
                            people.clear();
                          });
                          final newShowList = await MazeRepository.searchPeople(
                            searchController.text,
                          );
                          setState(() {
                            people = newShowList;
                            loading = false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (!loading && people.isEmpty) const Text('No items found'),
              if (loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Expanded(
                child: ListView.separated(
                  itemCount: people.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final person = people[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.personPage,
                          arguments: person.id,
                        );
                      },
                      child: ListTile(
                        leading:
                            person.image != null && person.image!.isNotEmpty
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      person.image!,
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/unavailable.png',
                                    ),
                                  ),
                        title: Text(person.name!),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
