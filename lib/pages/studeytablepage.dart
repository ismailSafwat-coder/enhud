// ... (keep your existing imports)
import 'package:enhud/main.dart';
import 'package:enhud/pages/notifications/notifications.dart';
import 'package:enhud/widget/alertdialog/activity.dart';
import 'package:enhud/widget/alertdialog/anthorclass.dart';
import 'package:enhud/widget/alertdialog/assginmentdialog.dart';
import 'package:enhud/widget/alertdialog/exam.dart';
import 'package:enhud/widget/alertdialog/freetime.dart';
import 'package:enhud/widget/alertdialog/sleep.dart';
import 'package:enhud/widget/alertdialog/taskdilog.dart';
import 'package:flutter/material.dart';

const commonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

class Studeytablepage extends StatefulWidget {
  const Studeytablepage({super.key});

  @override
  State<Studeytablepage> createState() => _StudeytablepageState();
}

class _StudeytablepageState extends State<Studeytablepage> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late double height;
  late double width;
  String? priority;

  int _currentWeekOffset = 0; // Track current week offset
  List<List<List<Widget>>> allWeeksContent = []; // Store content for all weeks

  List<String> timeSlots = [
    '08:00 am - 09:00 am',
    '09:00 am - 10:00 am',
    '10:00 am - 11:00 am',
  ];

  final List<String> categories = [
    "Material",
    "Task",
    "Assignment",
    "Exam",
    "Activity",
    "sleep",
    "freetime",
    "Another Class"
  ];

  void _initializeWeeksContent() {
    if (allWeeksContent.isEmpty) {
      allWeeksContent.add(_createNewWeekContent());
    }
  }

  List<List<Widget>> _createNewWeekContent() {
    return List.generate(
      timeSlots.length,
      (_) => List.filled(8, const Text('')),
    );
  }

  List<List<Widget>> get _currentWeekContent {
    while (_currentWeekOffset >= allWeeksContent.length) {
      allWeeksContent.add(_createNewWeekContent());
    }
    return allWeeksContent[_currentWeekOffset];
  }

  void _goToPreviousWeek() {
    setState(() {
      _currentWeekOffset--;
      if (_currentWeekOffset < 0) _currentWeekOffset = 0;
    });
  }

  void _goToNextWeek() {
    setState(() {
      _currentWeekOffset++;
    });
  }

  String _getWeekTitle() {
    if (_currentWeekOffset == 0) {
      return 'Current Week';
    } else if (_currentWeekOffset == 1) {
      return 'Next Week';
    } else if (_currentWeekOffset == -1) {
      return 'Last Week';
    } else if (_currentWeekOffset > 1) {
      return 'In $_currentWeekOffset Weeks';
    } else {
      return '${-_currentWeekOffset} Weeks Ago';
    }
  }

  Future<void> retriveDateFromhive() async {
    try {
      if (!mybox!.isOpen) {
        print('Hive box is not open');
        return;
      }

      if (!mybox!.containsKey('noti')) {
        print('No notifications stored');
        return;
      }

      late List<Map<String, dynamic>> noti;
      var data = mybox!.get('noti');
      if (data is List) {
        noti = List<Map<String, dynamic>>.from(data.map((item) {
          if (item is Map) {
            return Map<String, dynamic>.from(item);
          } else {
            // يمكنك هنا التعامل مع الحالة الغير متوقعة
            return {};
          }
        }));
      } else {
        noti = [];
      }
      final double height = MediaQuery.of(context).size.height;

      final List<Map<String, dynamic>> dataList = noti;

      for (final data in dataList) {
        final int week = data['week'] ?? 0;
        final int row = data['row'] ?? 1;
        final int col = data['column'] ?? 1;
        final String title = data['title'] ?? '';
        final String description = data['description'] ?? '';
        final String category = data['category'] ?? '';

        while (allWeeksContent.length <= week) {
          allWeeksContent.add(List.generate(
              timeSlots.length, (_) => List.filled(8, const Text(''))));
        }

        // Ensure week exists
        while (week >= allWeeksContent.length) {
          allWeeksContent.add(_createNewWeekContent());
        }

        // Ensure row exists
        while (row >= allWeeksContent[week].length) {
          allWeeksContent[week].add(List.filled(8, const Text('')));
        }

        // Ensure column exists
        if (col >= allWeeksContent[week][row].length) continue;

        // Recreate the original widget structure
        allWeeksContent[week][row][col] = Container(
          padding: const EdgeInsets.all(0),
          height: height * 0.13,
          width: double.infinity,
          color: _getCategoryColor(category),
          child: description.isEmpty
              ? Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
        );

        // Schedule notification if time exists
        // if (title.isNotEmpty) {
        //   Notifications().scheduleNotification(
        //     id: DateTime.now().millisecondsSinceEpoch % 100000,
        //     title: title,
        //     body: description,
        //     hour: time.hour,
        //     minute: time.minute,
        //   );
        // }
      }

      setState(() {}); // Update UI after loading all data
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Task':
      case 'Assignment':
        return const Color(0xffffa45b);
      case 'Exam':
        return const Color(0xffff6b6b);
      case 'Material':
        return const Color(0xff5f8cf8);
      case 'Activity':
        return const Color(0xffffe66d);
      default:
        return const Color(0xff9bb7fa);
    }
  }

  Future<void> _loadTimeSlots() async {
    if (!mybox!.isOpen || !mybox!.containsKey('timeSlots')) return;
    final List<String> savedSlots = mybox!.get('timeSlots');
    setState(() {
      timeSlots = savedSlots;
      for (var weekContent in allWeeksContent) {
        while (weekContent.length < timeSlots.length) {
          weekContent.add(List.filled(8, const Text('')));
        }
      }
    });
  }

  String _extractFirstTime(String timeSlot) {
    return timeSlot.split(' - ').first.trim();
  }

  @override
  void initState() {
    super.initState();

    _initializeWeeksContent();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadTimeSlots();
      await retriveDateFromhive();
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          decoration: BoxDecoration(
              // border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(20)),
          height: height * 0.1,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                    height: height * 0.02,
                    width: height * 0.02,
                  ),
                  const Text(
                    ' Empty',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.yellow,
                    ),
                    height: height * 0.02,
                    width: height * 0.02,
                  ),
                  const Text(
                    ' Activity',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.orange,
                    ),
                    height: height * 0.02,
                    width: height * 0.02,
                  ),
                  const Text(
                    ' Assignment / Task',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                    height: height * 0.02,
                    width: height * 0.02,
                  ),
                  const Text(
                    ' Exam',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue,
                    ),
                    height: height * 0.02,
                    width: height * 0.02,
                  ),
                  const Text(
                    ' Material',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          )),
      appBar: AppBar(
        leading:
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _goToPreviousWeek),
            Text(_getWeekTitle()),
            IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: _goToNextWeek),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color(0xffE4E4E4),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Colors.white, width: 2),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(1),
                    },
                    children: [
                      _buildTableHeader(),
                      for (int i = 0; i < timeSlots.length; i++)
                        _buildTableRow(timeSlots[i], rowIndex: i),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(children: [
      _buildTableCell('Day / Time', isHeader: true),
      _buildTableCell('Sat', isHeader: true, addpadding: true),
      _buildTableCell('Sun', isHeader: true, addpadding: true),
      _buildTableCell('Mon', isHeader: true, addpadding: true),
      _buildTableCell('Tue', isHeader: true, addpadding: true),
      _buildTableCell('Wed', isHeader: true, addpadding: true),
      _buildTableCell('Thu', isHeader: true, addpadding: true),
      _buildTableCell('Fri', isHeader: true, addpadding: true),
    ]);
  }

  TableRow _buildTableRow(String time, {required int rowIndex}) {
    return TableRow(
      children: [
        _buildTableCell(time, isrowheder: true),
        for (int colIndex = 1; colIndex < 8; colIndex++)
          _buildTableCellWithGesture(rowIndex, colIndex),
      ],
    );
  }

  Widget _buildTableCell(String text,
      {bool isHeader = false,
      bool isrowheder = false,
      bool addpadding = false}) {
    return Container(
      height: height * 0.12,
      color:
          isHeader || isrowheder ? Colors.blue[100] : const Color(0xffE4E4E4),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTableCellWithGesture(int rowIndex, int colIndex) {
    return GestureDetector(
      onTap: () {
        // _showAddItemDialog(rowIndex, colIndex);
      },
      child: Container(
        color: const Color(0xffE4E4E4),
        child: Center(
          child: _currentWeekContent.isNotEmpty &&
                  rowIndex < _currentWeekContent.length &&
                  colIndex < _currentWeekContent[rowIndex].length
              ? _currentWeekContent[rowIndex][colIndex]
              : const Text(''),
        ),
      ),
    );
  }
}
