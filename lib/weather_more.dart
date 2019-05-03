import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'entity/WeatherMoreInfo.dart';

class WeatherMoreWidget extends StatefulWidget {
  final String cityName;

  WeatherMoreWidget({Key key, @required this.cityName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherMoreWidgetState();
}

class _WeatherMoreWidgetState extends State<WeatherMoreWidget> {
  List<String> _girdTitle;
  bool _requestBack;
  WeatherMoreInfo _info;

  @override
  void initState() {
    // TODO: implement initState
    _girdTitle = ["今天", "明天", "后天", "大后天"];
    _requestBack = false;
    _getWeatherMore(widget.cityName).then((info) {
      setState(() {
        this._requestBack = true;
        this._info = info;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _requestBack
        ? DefaultTabController(
            length: _girdTitle.length,
            child: Scaffold(
              appBar: AppBar(
                title: Center(
                  child: TabBar(
                    tabs: _girdTitle.map((name) {
                      return Tab(
                        text: name,
                      );
                    }).toList(),
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(),
                  ),
                ),
              ),
              body: Container(
                child: TabBarView(
                    children: _girdTitle.asMap().keys.map((index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "城市:${_info?.data?.address}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "温度:${_info?.data?.forecasts[index].dayTemp}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "天气:${_info?.data?.forecasts[index].dayWeather}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "风向:${_info?.data?.forecasts[index].dayWindDirection}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "风力:${_info?.data?.forecasts[index].dayWindPower}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "日期:${_info?.data?.forecasts[index].date} 星期${_info?.data?.forecasts[index].dayOfWeek == '7' ? '日' : _info?.data?.forecasts[index].dayOfWeek}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "更新时间:${_info?.data?.reportTime}",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  );
                }).toList()),
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              title: Text("正在请求${widget.cityName}的数据"),
            ),
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                //backgroundColor: Colors.blue,
                // value: 0.2,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ));
  }

  Future<WeatherMoreInfo> _getWeatherMore(String city) async {
    var url = "https://www.mxnzp.com/api/weather/forecast/$city";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      return Future.value(WeatherMoreInfo.fromJson(dataJson));
    }
    return null;
  }
}
