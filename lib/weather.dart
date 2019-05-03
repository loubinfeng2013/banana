import 'package:flutter/material.dart';
import 'weather_detail.dart';

class WeatherWidget extends StatelessWidget {
  final List<String> _cityNames = [
    "北京",
    "上海",
    "天津",
    "重庆",
    "深圳",
    "澳门",
    "香港",
    "广州",
    "杭州",
    "武汉",
    "南京",
    "西安",
    "南昌",
    "厦门",
    "昆明",
    "济南",
    "青岛",
    "苏州",
    "洛阳",
    "石家庄",
    "温州",
    "宁波",
    "内蒙古",
    "哈尔滨",
    "沈阳",
    "大连"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(" 主要城市天气"),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return Container(height: 1.0,color: Colors.grey,);
          },
          itemBuilder: (context, index) {
            return FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return WeatherDetailWidget(cityName: _cityNames[index]);
              }));
            }, child: Container(
              height: 50.0,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(_cityNames[index]),
                  )),
            ));
          },
          itemCount: _cityNames.length),
    );
  }
}
