import 'package:flutter/material.dart';
import 'package:marandacan/utils.dart';

import 'data/person.dart';

class ChildrenPage extends StatelessWidget {
  final List<Person> peopleList;
  final Person person;
  final String subtitleText;

  ChildrenPage({Key? key, required this.peopleList, required this.person, required this.subtitleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the filtered children list
    final List<Person> filteredChildren = filterListById(person.id, peopleList);

    String newSubtitle = '';
    if (subtitleText == '') {
      newSubtitle = '${person.firstName} / ';
    } else {
      newSubtitle = '$subtitleText ${person.firstName} /';
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.brown,
        elevation: 0,
        // title: Text(
        //   '${person.firstName}\'s Children',
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontFamily: font1,
        //   ),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              // Show the alert dialog when the info icon is clicked
              showPersonInfo(context, person, peopleList);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.brown, // Set the background color to white
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      newSubtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 2.0,
                    color: Colors.brown,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredChildren.isEmpty
                  ? const Center(
                      child: Text(
                        'No record found.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredChildren.length,
                      itemBuilder: (context, index) {
                        final childPerson = filteredChildren[index];

                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChildrenPage(
                                  peopleList: peopleList,
                                  person: childPerson,
                                  subtitleText: newSubtitle,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                // Conditionally show the gender indicator if it's not "_def"
                                Visibility(
                                  visible: childPerson.gender != '_def',
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: childPerson.gender == 'Bae' ? Colors.pink : Colors.blue,
                                    ),
                                    child: Text(
                                      childPerson.gender,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                // Add some space between the gender and the person's name
                                const SizedBox(width: 6),

                                // Text widget for your person's name
                                Text(
                                  childPerson.firstName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            trailing: SizedBox(
                              width: 60,
                              height: 24,
                              child: ElevatedButton(
                                onPressed: () {
                                  showPersonInfo(context, childPerson, peopleList);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  'Info',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.brown.shade300,
                        height: 1,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
