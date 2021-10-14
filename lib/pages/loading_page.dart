import 'package:clima_app/libraries/weather.dart';
import 'package:flutter/material.dart';

import 'location_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var weatherData = await weatherModel.getLocationWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationPage(weatherData: weatherData,);
    }));
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
