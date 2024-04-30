import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initNotifications(Function(String, String) notificationRec) async {
    final notificationSettings =
    await _firebaseMessaging.requestPermission(provisional: true);
    print(notificationSettings.alert);
    final fCMToken = await _firebaseMessaging.getToken();
    print('token : $fCMToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      notificationRec(message.notification?.title ?? "", message.notification?.body ?? "");
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
