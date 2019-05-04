import 'dart:convert';

import 'package:banana/entity/CalendarInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarInfo _calendarInfo;
  bool _requestBack;

  @override
  void initState() {
    // TODO: implement initState
    _requestBack = false;
    var nowStr = DateFormat("yyyyMMdd").format(DateTime.now());
    _getCalendarData(nowStr).then((value) {
      setState(() {
        _calendarInfo = value;
        _requestBack = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("黄历"),
      ),
      body: _requestBack
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "日期:${_calendarInfo?.data?.date} 星期${_calendarInfo?.data?.weekDay == 7 ? '日' : _calendarInfo?.data?.weekDay}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "纪年法:${_calendarInfo?.data?.yearTips}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "类型:${_calendarInfo?.data?.typeDes}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "属相:${_calendarInfo?.data?.chineseZodiac}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "节气:${_calendarInfo?.data?.solarTerms}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "农历:${_calendarInfo?.data?.lunarCalendar}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "宜事:${_calendarInfo?.data?.suit}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "星座:${_calendarInfo?.data?.constellation}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                //backgroundColor: Colors.blue,
                // value: 0.2,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: new DateTime.now().subtract(new Duration(days: 180)),
            lastDate: new DateTime.now().add(new Duration(days: 180)),
          ).then((value){
            var timeStr = DateFormat("yyyyMMdd").format(value);
            _getCalendarData(timeStr).then((value) {
              setState(() {
                _calendarInfo = value;
              });
            });
          });
        },
        child: Icon(Icons.search),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 10.0,
        highlightElevation: 50.0,
        shape: CircleBorder(),
      ),
    );
  }

  Future<CalendarInfo> _getCalendarData(String day) async {
    var url = "https://www.mxnzp.com/api/holiday/single/$day";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      return Future.value(CalendarInfo.fromJson(dataJson));
    }
    return null;
  }
}
