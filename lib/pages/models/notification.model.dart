import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';

class NotificationModel {
  int id;
  SensorType type;
  dynamic status;
  dynamic value;
  String title;
  String body;
  bool seen;
  DateTime time;

  NotificationModel(this.id, this.type, this.status, this.value, this.title, this.body, this.seen, this.time);

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    final id = json['id'] as int;
    final type = SensorType.values[json['type'] as int];
    final status = (type == SensorType.dht11)
      ? StatusTemp.values[json['status'] as int]
      : (type == SensorType.pH)
        ? StatusPh.values[json['status'] as int]
        : (type == SensorType.moisture)
          ? MoistureStatus.values[json['status'] as int]
          : json['status'];
    final value = json['value'];
    final title = json['title'] as String;
    final body = json['body'] as String;
    final seen = json['seen'] as bool;
    final time = DateTime.parse((json['time'] as String));
    return NotificationModel(id, type, status, value, title, body, seen, time);
  }

  Map toJson() {
    final s = (type == SensorType.npk)
        ? status
        : status.index;
    return {
      'id': id,
      'type': type.index,
      'status': s,
      'value': value,
      'title': title,
      'body': body,
      'seen': seen,
      'time': time.toString(),
    };
  }

  void markAsSeen(){
    seen = true;
  }

  @override
  String toString() {
    return 'NotificationModel{id: $id, type: $type, status: $status, title: $title, body: $body, seen: $seen, time: $time}';
  }
}