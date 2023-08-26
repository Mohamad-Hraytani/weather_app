import 'package:flutter/material.dart';
import '../services/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  Map<String, dynamic> currentWeather = {};
  Map<String, dynamic> forecastData = {};
  String City_name = "";
    late int  id  ;
    var mainWeather = "" ;
    var description = "" ;
    double  temperature = 0 ;
    int     humidity= 0 ;
    double  windSpeed= 0 ;

  Future<void> fetchWeather(String query) async {
    City_name = query;
    currentWeather = await apiService.fetchWeatherData(query);
    fetchelements();
    forecastData = await apiService.fetchForecastData(query);
    notifyListeners();
  }

  Future<void> fetchelements() async {
     id = currentWeather['id'];
   mainWeather = currentWeather['weather'][0]['main'];
     description = currentWeather['weather'][0]['description'];
     temperature = currentWeather['main']['temp'];
     humidity =  currentWeather['main']['humidity'];
     windSpeed = currentWeather['wind']['speed'];
    notifyListeners();
  }

TemperatureUnit _temperatureUnit = TemperatureUnit.celsius;
void toggleTemperatureUnit() {
 
    if (_temperatureUnit == TemperatureUnit.celsius) {
      _temperatureUnit = TemperatureUnit.fahrenheit;
      notifyListeners();
    } else {
      _temperatureUnit = TemperatureUnit.celsius;
       notifyListeners();
    }
  
}
String getFormattedTemperature(double temperature) {
  if (_temperatureUnit == TemperatureUnit.fahrenheit) {
    double fahrenheitTemp = (temperature * 9 / 5) + 32;
    return '${fahrenheitTemp.toStringAsFixed(1)}°F';
  } else {
    return '${temperature.toStringAsFixed(1)}°C';
  }
}


}
enum TemperatureUnit {
  celsius,
  fahrenheit,
}