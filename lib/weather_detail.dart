import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'entity/WeatherInfo.dart';

class WeatherDetailWidget extends StatefulWidget {
  final String cityName;

  WeatherDetailWidget({Key key, @required this.cityName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherDetailWidgetState();
}

class _WeatherDetailWidgetState extends State<WeatherDetailWidget>{
  
  WeatherInfo _weatherInfo;
  bool _requestBack;
  
  @override
  void initState() {
    // TODO: implement initState
    _requestBack = false;
    _getWeatherData(widget.cityName).then((info){
      setState(() {
        _requestBack = true;
        _weatherInfo = info;
      });
    }).catchError((e){});
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("天气详情"),
      ),
      body:_requestBack?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("城市:${_weatherInfo?.data?.address}"),
            Text("温度:${_weatherInfo?.data?.temp}"),
            Text("天气:${_weatherInfo?.data?.weather}"),
            Text("风向:${_weatherInfo?.data?.windDirection}"),
            Text("风力:${_weatherInfo?.data?.windPower}"),
            Text("湿度:${_weatherInfo?.data?.humidity}"),
            Text("更新时间:${_weatherInfo?.data?.reportTime}"),
          ],
        ),
      ):Center(
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          //backgroundColor: Colors.blue,
          // value: 0.2,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Future<WeatherInfo> _getWeatherData(String city) async {
    var url = "https://www.mxnzp.com/api/weather/current/$city";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      return Future.value(WeatherInfo.fromJson(dataJson));
    }
    return null;
  }
}
