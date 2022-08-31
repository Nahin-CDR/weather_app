
import 'model_class.dart';
import 'package:http/http.dart' as http;

class Services{
   Future getWeatherData(String cityName) async {
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=50978f07fb55fae4d2bca33d21cc1912");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return weatherModelFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

}