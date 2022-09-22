class PlantModel {
  String state;
  String image;
  int dateInt;


  PlantModel(this.state, this.image, this.dateInt);

  factory PlantModel.fromJson(Map<dynamic, dynamic> json) {
    final state = json['state'] as String;
    final image = json['image'] as String;
    final dateInt = json['dateInt'] as int;
    return PlantModel(state, image, dateInt);
  }

  @override
  String toString() {
    return 'PlantModel{state: $state, image: $image, , dateInt: $dateInt}';
  }
}