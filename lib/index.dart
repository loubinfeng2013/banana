import 'package:flutter/material.dart';
import 'package:banana/weather/weather.dart';
import 'package:banana/book/book.dart';
import 'tools.dart';
import 'calendar.dart';

class IndexActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "index",
      home: _IndexWidget(),
    );
  }
}

class _IndexWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<_IndexWidget> {
  Color _defaultColor = Colors.grey;
  Color _selectColor = Colors.blue;
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: <Widget>[
            WeatherWidget(),
            BookWidget(),
            ToolsWidget(),
            CalendarWidget()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _pageController.jumpToPage(index);
              _currentIndex = index;
            },
            items: [
              BottomNavigationBarItem(title: Text("天气"), icon: Icon(
                Icons.wb_cloudy,
                color: _defaultColor,
              ), activeIcon: Icon(
                Icons.wb_cloudy,
                color: _selectColor,
              )),
              BottomNavigationBarItem(title: Text("段子"), icon: Icon(
                Icons.book,
                color: _defaultColor,
              ), activeIcon: Icon(
                Icons.book,
                color: _selectColor,
              )),
              BottomNavigationBarItem(title: Text("黄历"), icon: Icon(
                Icons.calendar_today,
                color: _defaultColor,
              ), activeIcon: Icon(
                Icons.calendar_today,
                color: _selectColor,
              )),
              BottomNavigationBarItem(title: Text("工具"), icon: Icon(
                Icons.pan_tool,
                color: _defaultColor,
              ), activeIcon: Icon(
                Icons.pan_tool,
                color: _selectColor,
              )),
            ])
    );
  }
}
