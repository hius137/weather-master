import 'package:weather_cubit/model/entity/current.dart';
import 'package:weather_cubit/model/entity/forecast.dart';
import 'package:weather_cubit/model/entity/location.dart';

class WeatherResponse {
  WeatherResponse({
      this.location, 
      this.current, 
      this.forecast,});

  WeatherResponse.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
  }
  Location? location;
  Current? current;
  Forecast? forecast;
WeatherResponse copyWith({  Location? location,
  Current? current,
  Forecast? forecast,
}) => WeatherResponse(  location: location ?? this.location,
  current: current ?? this.current,
  forecast: forecast ?? this.forecast,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (current != null) {
      map['current'] = current?.toJson();
    }
    if (forecast != null) {
      map['forecast'] = forecast?.toJson();
    }
    return map;
  }

}





