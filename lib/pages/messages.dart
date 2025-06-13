import 'package:enhud/main.dart';
import 'package:flutter/material.dart';

class WeeklyReport extends StatefulWidget {
  const WeeklyReport({super.key});

  @override
  State<WeeklyReport> createState() => _WeeklyReportState();
}

class _WeeklyReportState extends State<WeeklyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Weekly Report',
          style: commonTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //text welcom
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'You\'re doing great, keep it up!',
                  style: commonTextStyle,
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              //anthor text
              const Text(
                textAlign: TextAlign.center,
                'Here\'s a look at what you covered & not covered this week.',
                style: midTextStyle,
              ),

              const SizedBox(
                height: 16,
              ),
              //text subject studed
              const Text(
                'Subjects Studied',
                style: commonTextStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8,
              ),
              //subject studed
              Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFe6e6e6)),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Image.asset(
                      'images/cr7.png',
                      height: 50,
                      width: 50,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Math',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text('2h 30m')
                      ],
                    )
                  ],
                ),
              ),
              //text subject not studed
              const Text(
                'Subjects Not Studied',
                style: commonTextStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8,
              ),

              Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFe6e6e6)),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Image.asset(
                      'images/cr7.png',
                      height: 50,
                      width: 50,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chemistry',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text('2h 30m')
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),
              const Text(
                  textAlign: TextAlign.center,
                  style: midTextStyle,
                  'Based on your availability, we have some suggestions for when you could study the subjects you missed this week.'),

              //suggested stydey times
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Suggested Study Times',
                style: commonTextStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              //stydey times
              Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFe6e6e6))),
                child: Row(
                  children: [
                    Image.asset(
                      'images/calenderweeklyreport.png',
                      height: 50,
                      width: 60,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: midTextStyle,
                        ),
                        Text('Biology'),
                        Text('4:00 PM - 5:00 PM'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
