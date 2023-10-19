import 'package:flutter/material.dart';
import 'package:marandacan/data/person.dart';
import 'package:marandacan/widgets/app_large_text.dart';

String getFont1() {
  return 'Hidayatullah DEMO';
}

bool isInteger(String input) {
  final RegExp integerRegExp = RegExp(r'^[-+]?[0-9]+$');
  return integerRegExp.hasMatch(input);
}

String validateName(String value) {
  return value == '_def' ? '' : value;
}

String validateBirthday(String value) {
  return value == '_def' ? '---' : value;
}

String validateLocation(String value) {
  return value == '_def' ? '---' : value;
}

String validateNickName(String value) {
  return value == '_def' ? '---' : value;
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
            nickname: '',
          ));

  String fullName = '${validateName(matchingPerson.firstName)} '
      '${validateName(matchingPerson.middleName)} '
      '${validateName(matchingPerson.lastName)}';

  if (fullName.trim() == '') {
    if (validateName(id) == '') return '---';
    return validateName(id);
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
        title: AppLargeText(text: 'Personal Info', color: Colors.brown, size: 25,),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Colors.brown,
              height: 1,
            ),
            buildInfoRow(context, 'Full Name',
                '${validateName(person.gender)} ${validateName(person.firstName)} ${validateName(person.middleName)} ${validateName(person.lastName)}'),
            buildInfoRow(context, 'Nickname', validateNickName(person.nickname)),
            buildInfoRow(context, 'Birthday', validateBirthday(person.birthday)),
            buildInfoRow(context, 'Location', validateLocation(person.location)),
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
            fontSize: 16,
            color: Colors.brown, // Set value color here
          ),
        ),
      ],
    ),
  );
}
