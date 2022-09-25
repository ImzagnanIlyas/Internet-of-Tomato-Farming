class PhModel {
  int value;
  int Date;


  PhModel(this.value, this.Date);

  factory PhModel.fromJson(Map<dynamic, dynamic> json) {
    final value = json['value'] as int;
    final Date = json['Date'] as int;
    return PhModel(value, Date);
  }

  @override
  String toString() {
    return 'PhModel{value: $value, Date: $Date}';
  }
}