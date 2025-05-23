import 'package:enhud/pages/notifications/notifications.dart';
import 'package:flutter/material.dart';

class Noti extends StatelessWidget {
  const Noti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Notifications().showNotification(
                  title: 'Title',
                  body: 'body',
                );
              },
              child: const Text('show notification'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Show the time picker
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                // Schedule the notification with picked time
                Notifications().scheduleNotification(
                  id: 2,
                  title: 'Scheduled Notification',
                  body: 'This is a scheduled notification',
                  hour: pickedTime.hour,
                  minute: pickedTime.minute,
                );
              }
            },
            child: const Text('schedule notification'),
          ),
        ],
      ),
    );
  }
}
