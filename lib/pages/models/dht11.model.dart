class Dht11Model {
  int humidity;
  int temperature;
  int dateInt;


  Dht11Model(this.humidity, this.temperature, this.dateInt);

  factory Dht11Model.fromJson(Map<dynamic, dynamic> json) {
    final humidity = json['Humidity'] as int;
    final temperature = json['Temperature'] as int;
    final dateInt = json['Date'] as int;
    return Dht11Model(humidity, temperature, dateInt);
  }

  @override
  String toString() {
    return 'Dht11Model{humidity: $humidity, temperature: $temperature, , dateInt: $dateInt}';
  }
}