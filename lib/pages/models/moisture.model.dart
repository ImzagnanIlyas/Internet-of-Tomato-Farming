class MoistureModel {
  int value;
  int Date;


  MoistureModel(this.value, this.Date);

  factory MoistureModel.fromJson(Map<dynamic, dynamic> json) {
    final value = json['value'] as int;
    final Date = json['Date'] as int;
    return MoistureModel(value, Date);
  }

  @override
  String toString() {
    return 'MoistureModela{value: $value, Date: $Date}';
  }
}