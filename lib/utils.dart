import 'package:flutter/material.dart';
import 'package:marandacan/data/person.dart';

bool isInteger(String input) {
  final RegExp integerRegExp = RegExp(r'^[-+]?[0-9]+$');
  return integerRegExp.hasMatch(input);
}

String validateString(String value) {
  return value == '_def' ? '' : value;
}

String findFullNameById(String id, List<Person> personList) {
  final matchingPerson = personList.firstWhere((person) => person.id == id,
      orElse: () => Person(
            id: '',
            gender: '',
            firstName: '',
            middleName: '',
            lastName: '',
            fatherId: '',
            motherId: '',
            location: '',
            birthday: '',
            spouse: '',
          ));

  String fullName = '${validateString(matchingPerson.firstName)} '
      '${validateString(matchingPerson.middleName)} '
      '${validateString(matchingPerson.lastName)}';

  if (fullName.trim() == '') {
    if (validateString(id) == '') return 'NO RECORD';
    return validateString(id);
  } else {
    return fullName;
  }
}

List<Person> filterListById(String id, List<Person> peopleList) {
  return peopleList
      .where((person) => person.fatherId == id || person.motherId == id)
      .toSet() // Convert to a set to remove duplicates
      .toList(); // Convert back to a list
}

//Widgets
void showPersonInfo(BuildContext context, Person person, List<Person> people) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.green, // Set the text color to green
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildInfoRow(context, 'Full Name',
                '${validateString(person.gender)} ${validateString(person.firstName)} ${validateString(person.middleName)} ${validateString(person.lastName)}'),
            buildInfoRow(context, 'Birthday', validateString(person.birthday)),
            buildInfoRow(context, 'Location', validateString(person.location)),
            buildInfoRow(context, 'Father\'s Name', findFullNameById(person.fatherId, people)),
            buildInfoRow(context, 'Mother\'s Name', findFullNameById(person.motherId, people)),
            buildInfoRow(context, 'Spouse\'s Name', findFullNameById(person.spouse, people)),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget buildInfoRow(BuildContext context, String label, String value) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '\n$label\n',
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.grey, // Set label color here
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black, // Set value color here
          ),
        ),
      ],
    ),
  );
}
