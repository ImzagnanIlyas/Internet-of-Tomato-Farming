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

  @override
  String toString() {
    return 'DiseaseModel{state: $state, image: $image, dateInt: $dateInt}';
  }
}