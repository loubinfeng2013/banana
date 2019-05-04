import 'package:flutter/material.dart';

class BookDetailWidget extends StatelessWidget {
  String content;

  BookDetailWidget({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("段子详情"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            content,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
