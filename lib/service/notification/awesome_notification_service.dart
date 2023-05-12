import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:kisan_facility/service/notification/awesome_notification_controller.dart';

Future<void> createAppNotification(
    {required final String title,
    final String? body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButton,
    final bool scheduled = false,
    final int? interval}) async {
  assert(!scheduled || (scheduled && interval != null));
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(1),
          channelKey: "basic_channel",
          title: title,
          body: body,
          bigPicture: "assets://assets/images/signup_top.png",
          payload: payload,
          category: category,
          summary: summary,
          actionType: actionType,
          notificationLayout: notificationLayout),
      actionButtons: actionButton,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true)
          : null);
}

class AwesomeNotificationService {
  static Future<void> initializedNotification() async {
    // call this method in void main for the initialization
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              importance: NotificationImportance.High,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true,
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white),
          NotificationChannel(
              channelGroupKey: 'scheduled_channel_group',
              channelKey: 'scheduled_channel',
              channelName: 'Scheduled notifications',
              importance: NotificationImportance.High,
              channelShowBadge: true,
              channelDescription: 'Notification channel for scheduled tests',
              defaultColor: const Color.fromARGB(255, 47, 207, 65),
              ledColor: const Color.fromARGB(255, 233, 165, 165)),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod:
            AwesomeNotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            AwesomeNotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            AwesomeNotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            AwesomeNotificationController.onDismissActionReceivedMethod);
  }
}
