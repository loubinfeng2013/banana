import 'package:flutter/material.dart';

import 'tool_myip.dart';
import 'tool_searchip.dart';

class ToolsWidget extends StatelessWidget {
  final List<String> tools = ["当前ip", "查ip"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("小工具"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        children: tools.asMap().keys.map((index) {
          return FlatButton(
              onPressed: () {
                if (index == 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ToolMyIpWidget();
                  }));
                }else if(index == 1){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ToolSearchIpWidget();
                  }));
                }
              },
              child: Card(
                child: Center(
                  child: Text(tools[index]),
                ),
              ));
        }).toList(),
      ),
    );
  }
}
