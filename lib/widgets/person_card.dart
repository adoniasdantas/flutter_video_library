import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.person,
  }) : super(key: key);
  final Person person;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  image: person.image != null && person.image!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                            person.image!,
                          ),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/unavailable.png'),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${person.name!}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Country: ${person.getCountry()}'),
                  Text('Birthday: ${person.getBirthday()}'),
                ],
              ),
            ),
          ],
        ),
      ),
      elevation: 2,
    );
  }
}
