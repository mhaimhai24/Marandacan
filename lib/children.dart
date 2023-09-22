import 'package:flutter/material.dart';
import 'package:marandacan/utils.dart';

import 'data/person.dart';

class ChildrenPage extends StatelessWidget {
  final List<Person> peopleList;
  final Person person;
  final String subtitleText;

  const ChildrenPage({Key? key, required this.peopleList, required this.person, required this.subtitleText}) : super(key: key);

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
        title: Text('${person.firstName} FAMILY'),
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  newSubtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ),
              Container(
                height: 1.0, // Height of the line
                color: Colors.grey, // Color of the line
                width: double.infinity, // Make the line span the entire width
              ),
            ],
          ),
          Expanded(
            child: filteredChildren.isEmpty // Check if the list is empty
                ? const Center(
                    child: Text(
                      'No record found.',
                      style: TextStyle(
                        fontSize: 20, // Adjust the font size as needed
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
                              // Conditionally show the gender indicator if it's not "_DEF"
                              Visibility(
                                visible: childPerson.gender != '_DEF',
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: childPerson.gender == 'BAE' ? Colors.pink : Colors.blue,
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
                                //style: const TextStyle(fontFamily: 'Buree Chalk'),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 60, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
                            child: ElevatedButton(
                              onPressed: () {
                                showPersonInfo(context, childPerson, peopleList);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero, // Remove the padding inside the button
                              ),
                              child: const Text(
                                'Details',
                                style: TextStyle(fontSize: 12), // Adjust the font size as needed
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 0, // Set the divider height to zero to remove the extra padding
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
