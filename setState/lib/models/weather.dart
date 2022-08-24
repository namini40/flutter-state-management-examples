// simplified model for Weather data just to work
class Weather {
  late double temperature;
  late String status;

  Weather(this.temperature, this.status);

  @override
  String toString() {
    return 'Weather\n{\ntemperature: $temperature, status: $status\n}';
  }
}
