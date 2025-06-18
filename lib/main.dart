import 'package:enhud/firebase_options.dart';
import 'package:enhud/core/core.dart';
import 'package:enhud/pages/authpages/loginpage.dart';
import 'package:enhud/pages/homescreen.dart';
import 'package:enhud/pages/notifications/notifications.dart';
import 'package:enhud/pages/rest.dart';
import 'package:enhud/pages/splachscreen.dart';
import 'package:enhud/pages/test.dart';
import 'package:enhud/test/hive.dart';
import 'package:enhud/test/noti.dart';
import 'package:enhud/widget/alertdialog/studytabeldialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  await requestNotificationPermission();

  // Init Hive early
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Init Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Init notifications
  await Notifications().initNotification();

  // Get current user synchronously
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    // Open Hive box for current user
    mybox = await openHiveBox(currentUser.uid);
    print('-------------User is signed in!');
    print('====================${currentUser.uid}');
  }

  // Run the app
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ُenhud',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: //
            FirebaseAuth.instance.currentUser != null
                ? const HomeScreen()
                : const LoginPage()

        // const HiveTestPage(),
        );
  }
}
