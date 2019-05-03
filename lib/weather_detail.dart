import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'entity/WeatherInfo.dart';
import 'weather_more.dart';

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
        title: Text("${widget.cityName}天气详情"),
      ),
      body:_requestBack?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("城市:${_weatherInfo?.data?.address}",style: TextStyle(fontSize: 20.0),),
            Text("温度:${_weatherInfo?.data?.temp}",style: TextStyle(fontSize: 20.0),),
            Text("天气:${_weatherInfo?.data?.weather}",style: TextStyle(fontSize: 20.0),),
            Text("风向:${_weatherInfo?.data?.windDirection}",style: TextStyle(fontSize: 20.0),),
            Text("风力:${_weatherInfo?.data?.windPower}",style: TextStyle(fontSize: 20.0),),
            Text("湿度:${_weatherInfo?.data?.humidity}",style: TextStyle(fontSize: 20.0),),
            Text("更新时间:${_weatherInfo?.data?.reportTime}",style: TextStyle(fontSize: 20.0),),
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return WeatherMoreWidget(cityName: widget.cityName,);
        }));
      },
      child: Icon(Icons.more_horiz),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      elevation: 10.0,
      highlightElevation: 50.0,
      shape: CircleBorder(),),
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
