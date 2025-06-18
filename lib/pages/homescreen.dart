import 'package:enhud/core/recivedate.dart';
import 'package:enhud/pages/exampage.dart';
import 'package:enhud/pages/homepage.dart';
import 'package:enhud/pages/notificationscreen.dart';
import 'package:enhud/pages/settingsscreen.dart';
import 'package:enhud/pages/studeytablepage.dart';
import 'package:enhud/pages/timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final int? homeindex;

  const HomeScreen({super.key, this.homeindex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> pages = ['Home', 'Timetable', 'Add', 'Exam', 'Settings'];
  int index = 0;
  List<Widget> screens = [
    const Homepage(),
    const Studeytablepage(),
    const StudyTimetable(),
    const Exampage(),
    const SettingsScreen()
  ];
  @override
  @override
  void initState() {
    index = widget.homeindex ?? index;
    // Initialize the Hive box to retrieve data

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[index],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFbfbfbf)),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                if (index == 0) {
                } else {
                  setState(() {
                    index = 0;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('images/Home.svg'),
                  if (pages[index] == 'Home')
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF5f8cf8),
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (index == 1) {
                } else {
                  setState(() {
                    index = 1;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('images/Timetable.svg'),
                  if (pages[index] == 'Timetable')
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF5f8cf8),
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (index == 2) {
                } else {
                  setState(() {
                    index = 2;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('images/Add.svg'),
                  if (pages[index] == 'Add')
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF5f8cf8),
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (index == 3) {
                } else {
                  setState(() {
                    index = 3;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('images/Exam.svg'),
                  if (pages[index] == 'Exam')
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF5f8cf8),
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (index == 4) {
                } else {
                  setState(() {
                    index = 4;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('images/Settings.svg'),
                  if (pages[index] == 'Settings')
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF5f8cf8),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
