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
          : ((type == SensorType.disease))
            ? json['status']
            :{
              'nitrogenCondition': ConditionNpk.values[json['status']['nitrogenCondition']],
              'phosphorusCondition': ConditionNpk.values[json['status']['phosphorusCondition']],
              'potassiumCondition': ConditionNpk.values[json['status']['potassiumCondition']],
              'plantGrowthStage': PlantGrowthStage.values[json['status']['plantGrowthStage']]
            };
    final value = json['value'];
    final title = json['title'] as String;
    final body = json['body'] as String;
    final seen = json['seen'] as bool;
    final time = DateTime.parse((json['time'] as String));
    return NotificationModel(id, type, status, value, title, body, seen, time);
  }

  Map toJson() {
    var s;
    if(type == SensorType.npk){
      s = {
        'nitrogenCondition': status['nitrogenCondition'].index,
        'phosphorusCondition': status['phosphorusCondition'].index,
        'potassiumCondition': status['potassiumCondition'].index,
        'plantGrowthStage': status['plantGrowthStage'].index
      };
    }else if(type == SensorType.disease){
      s = status;
    }else{
      s = status.index;
    }
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
    return 'NotificationModel{\n'
        'id: $id,\n'
        'type: $type,\n'
        'status: $status,\n'
        'value: $value,\n'
        'title: $title,\n'
        'body: $body,\n'
        'seen: $seen,\n'
        'time: $time\n'
        '}';
  }
}