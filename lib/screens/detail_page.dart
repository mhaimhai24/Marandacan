import 'package:flutter/material.dart';
import 'package:marandacan/widgets/app_large_text.dart';
import 'package:marandacan/widgets/app_text.dart';

import '../data/person.dart';
import '../utils.dart';

class DetailPage extends StatelessWidget {
  final List<Person> peopleList;
  final Person person;
  final String subtitleText;

  const DetailPage({Key? key, required this.peopleList, required this.person, required this.subtitleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Person> filteredChildren = filterListById(person.id, peopleList);

    String newSubtitle = '';
    if (subtitleText == '') {
      newSubtitle = '${person.firstName} / ';
    } else {
      newSubtitle = '$subtitleText ${person.firstName} /';
    }

    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/header.jpg'), fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: findFullNameById(person.id, peopleList),
                          color: Colors.white,
                          size: 22,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          text: validateLocation(person.location),
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 30,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 30,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showPersonInfo(context, person, peopleList);
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                  color: Colors.white,
                )
              ],
            ),
          ),
          Positioned(
            top: 170,
            child: Container(
              height: MediaQuery.of(context).size.height - 170,
              // Match the bottom of the screen
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(
                        text: 'Children',
                        color: Colors.brown,
                        size: 18,
                      ),
                      const Divider(
                        color: Colors.brown,
                        height: 1,
                      ),
                      // Rest of your content
                    ],
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
                            padding: const EdgeInsets.all(0),
                            itemCount: filteredChildren.length,
                            itemBuilder: (context, index) {
                              final childPerson = filteredChildren[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        peopleList: peopleList,
                                        person: childPerson,
                                        subtitleText: newSubtitle,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 2.0,
                        color: Colors.brown,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 5),
                      AppText(
                        text: newSubtitle,
                        color: Colors.grey.shade400,
                        size: 12,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
