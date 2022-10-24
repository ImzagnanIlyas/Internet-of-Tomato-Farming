class MoistureModel {
  double value;
  int Date;


  MoistureModel(this.value, this.Date);

  factory MoistureModel.fromJson(Map<dynamic, dynamic> json) {
    final value = json['value'];
    final Date = json['Date'] as int;
    return MoistureModel(value.toDouble(), Date);
  }

  @override
  String toString() {
    return 'MoistureModela{value: $value, Date: $Date}';
  }
}