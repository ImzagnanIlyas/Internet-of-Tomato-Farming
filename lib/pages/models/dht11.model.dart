class Dht11Model {
  double humidity;
  double temperature;
  int dateInt;

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


  Dht11Model(this.humidity, this.temperature, this.dateInt);

  factory Dht11Model.fromJson(Map<dynamic, dynamic> json) {
    final humidity = json['Humidity'] as double;
    final temperature = json['Temperature'] as double;
    final dateInt = json['Date'] as int;

    return Dht11Model(humidity.toDouble(), temperature.toDouble(), dateInt);
  }

  @override
  String toString() {
    return 'Dht11Model{humidity: $humidity, temperature: $temperature, , dateInt: $dateInt}';
  }
}