import 'package:enhud/firebase_options.dart';
import 'package:enhud/pages/authpages/loginpage.dart';
import 'package:enhud/pages/homescreen.dart';
import 'package:enhud/pages/notifications/notifications.dart';
import 'package:enhud/pages/splachscreen.dart';
import 'package:enhud/pages/test.dart';
import 'package:enhud/test/hive.dart';
import 'package:enhud/test/noti.dart';
import 'package:enhud/widget/alertdialog/studytabeldialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pages/text.dart';

Box? mybox;

Future<Box?> openHiveBox(String boxname) async {
  if (!Hive.isBoxOpen(boxname)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxname);
}

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  requestNotificationPermission();

  // Get current device timezone

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //init notifications
  await Notifications().initNotification();
  mybox = await openHiveBox('ismail');

  runApp(const MyApp());
}

const TextStyle midTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
const TextStyle commonTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ُenhud',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const HomeScreen()
        //  const HiveTestPage(),
        );
  }
}
