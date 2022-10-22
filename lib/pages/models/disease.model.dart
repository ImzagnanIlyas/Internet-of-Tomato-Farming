class DiseaseModel {

  String state;
  String image;
  int dateInt;

  DiseaseModel(this.state, this.image, this.dateInt);

  factory DiseaseModel.fromJson(Map<dynamic, dynamic> json) {
    final state = json['state'] as String;
    final image = json['image'] as String;
    final dateInt = json['dateInt'] as int;
    return DiseaseModel(state, image, dateInt);
  }

  DateTime get date {
    final dateString = dateInt.toString();
    final year = int.parse(dateString.substring(0,4));
    final month = int.parse(dateString.substring(4,6));
    final day = int.parse(dateString.substring(6,8));
    final hour = int.parse(dateString.substring(8,10));
    final minute = int.parse(dateString.substring(10,12));
    final second = int.parse(dateString.substring(12,14));
    DateTime date = DateTime(year,month,day,hour,minute,second);

    return date;
  }

  @override
  String toString() {
    return 'DiseaseModel{state: $state, image: $image, dateInt: $dateInt}';
  }
}