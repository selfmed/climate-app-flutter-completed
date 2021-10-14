import 'package:clima_app/libraries/weather.dart';
import 'package:clima_app/pages/city_page.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  final weatherData;

  LocationPage({this.weatherData});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  WeatherModel weather = WeatherModel();

  int? temprature;
  int? condition;
  String? cityName;
  String? conditionString;
  int? tempMaximum;
  int? tempMinimum;

  Icon? tempratureIcon;

  @override
  void initState() {
    super.initState();
    updateWeatherScreen(widget.weatherData);
  }

  void updateWeatherScreen(dynamic weatherData) {
    if (weatherData == null) {
      temprature = 0;

      condition = 0;
      cityName = '';

      conditionString = 'Something went wrong';

      tempMaximum = 0;
      tempMinimum = 0;

      tempratureIcon = weather.getWeatherIcon(condition!);
      return;
    }

    double temp = weatherData['main']['temp'];
    temprature = temp.toInt();

    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    var tempConditionString = weatherData['weather'][0]['main'];
    conditionString = weather.getConditionString(tempConditionString);

    double tempMax = weatherData['main']['temp_max'];
    double tempMin = weatherData['main']['temp_min'];
    tempMaximum = tempMax.toInt();
    tempMinimum = tempMin.toInt();

    tempratureIcon = weather.getWeatherIcon(condition!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/app_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      cityName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    Text(conditionString!, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      ),
                      onPressed: () async {
                        var cityName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityPage();
                        }));

                        if (cityName != null) {
                          var weatherData =
                              await weather.getCityWeatherData(cityName);
                          setState(() {
                            updateWeatherScreen(weatherData);
                          });
                        }
                      },
                      child: Text(
                        'Change City',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      temprature.toString(),
                      style: kTempTextStyle,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    tempratureIcon!
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Today: $conditionString currently. The high will be $tempMaximum°. Cloudy tonight with a low of $tempMinimum°.',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
