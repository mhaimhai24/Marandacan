import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marandacan/children.dart';
import 'package:marandacan/screens/detail_page.dart';
import 'package:marandacan/widgets/app_large_text.dart';
import 'package:marandacan/widgets/app_text.dart';
import 'package:marandacan/widgets/responsive_button.dart';

import '../data/person.dart';
import '../widgets/arrow_animation.dart';

class WelcomePage extends StatelessWidget {
  final List<Person> pList;

  const WelcomePage({super.key, required this.pList});

  @override
  Widget build(BuildContext context) {
    List images = [
      'welcome-one.png',
      'welcome-two.png',
    ];

    List titles = [
      'Marandacan',
      'Cherished',
    ];

    List subTexts = [
      'Ancestry',
      'Traditions',
    ];

    List descriptions = [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ];

    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/' + images[index]), fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter)),
              child: Container(
                margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: titles[index]),
                        AppText(text: subTexts[index], size: 30),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 250,
                          child: AppText(text: descriptions[index], size: 14),
                        ),
                        const SizedBox(height: 40),
                        if (index == 1)
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      peopleList: pList,
                                      person: pList.first,
                                      subtitleText: '',
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                  width: 150,
                                  child: ResponsiveButton(
                                    width: 150,
                                    content: 'Get Started',
                                  ))),
                      ],
                    ),
                    if (index == 0)
                      Positioned(
                          bottom: 20,
                          child: ArrowAnimation(
                            width: 50,
                            rotation: 90,
                          ))
                    else
                      Positioned(
                          bottom: 20,
                          child: ArrowAnimation(
                            width: 50,
                            rotation: -90,
                          )),
                    Column(
                      children: List.generate(2, (indexDot) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: 8,
                          height: index == indexDot ? 25 : 8,
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(8), color: index == indexDot ? Colors.brown : Colors.brown.shade100),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
