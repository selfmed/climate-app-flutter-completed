import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clima_app/libraries/location.dart';
import 'package:clima_app/libraries/network.dart';

const double iconSize = 80;
const int cloudColor = 0xFFA7A0D3;
const int sunColor = 0xFFFFC17B;

const String appID = '6528556ef2703df0533eaa821c258160';

class WeatherModel {

  Future<dynamic> getCityWeatherData(String cityName) async {
    String weatheAPIUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appID&units=metric';

    NetwrokUtility netwrokUtility = NetwrokUtility(url: weatheAPIUrl);
    var jsonResponse = await netwrokUtility.getData();
    return jsonResponse;
  }

  Future<dynamic> getLocationWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    String weatheAPIUrl =
        'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appID&units=metric';

    NetwrokUtility netwrokUtility = NetwrokUtility(url: weatheAPIUrl);
    var jsonResponse = await netwrokUtility.getData();
    return jsonResponse;
  }

  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return Icon(
        FontAwesomeIcons.pooStorm,
        color: Color(sunColor),
        size: iconSize,
      );
    } else if (condition < 400) {
      return Icon(
        FontAwesomeIcons.cloudRain,
        color: Color(sunColor),
        size: iconSize,
      );
    } else if (condition < 600) {
      return Icon(
        FontAwesomeIcons.cloudShowersHeavy,
        color: Color(sunColor),
        size: iconSize,
      );
    } else if (condition < 700) {
      return Icon(
        FontAwesomeIcons.snowman,
        color: Color(sunColor),
        size: iconSize,
      );
    } else if (condition < 800) {
      return Icon(
        FontAwesomeIcons.smog,
        color: Color(sunColor),
        size: iconSize,
      );
    } else if (condition == 800) {
      return Icon(
        FontAwesomeIcons.solidSun,
        color: Color(sunColor),
        size: iconSize,
      );
    } else if (condition <= 804) {
      return Icon(
        FontAwesomeIcons.cloud,
        color: Color(sunColor),
        size: iconSize,
      );
    } else {
      return Icon(
        FontAwesomeIcons.exclamationTriangle,
        color: Colors.yellow,
        size: iconSize,
      );
    }
  }

  String getConditionString(String condition) {
    if (condition == 'Clouds') {
      return 'Cloudy';
    } else if (condition == 'Rain') {
      return 'Rainy';
    } else {
      return condition;
    }
  }
}
