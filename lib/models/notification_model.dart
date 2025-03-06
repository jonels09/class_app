
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool read;
  final String type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.read,
    required this.type,
  });
}