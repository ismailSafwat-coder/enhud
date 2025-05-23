// file: notifications_screen.dart

import 'package:enhud/pages/core/core.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.notifications, color: Colors.black),
            SizedBox(width: 8),
            Text("Notifications", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: mynotificationitmes.isEmpty
          ? const Center(child: Text("No notifications yet"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mynotificationitmes.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                    notification: mynotificationitmes[index]);
              },
            ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: getColorFromName(notification['color']),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("• ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                notification['title'] ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text("  •  "),
              Text(notification['category'] ?? '',
                  style: const TextStyle(fontSize: 14)),
              const Spacer(),
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Text(notification['time'] ?? '',
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            notification['description'] ?? '',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("Done",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {},
                child: const Text("Snooze",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'orange':
      return Colors.orange.shade300;
    case 'red':
      return Colors.red.shade300;
    case 'blue':
      return Colors.blue.shade300;
    case 'yellow':
      return Colors.yellow.shade300;
    default:
      return Colors.grey.shade300;
  }
}
