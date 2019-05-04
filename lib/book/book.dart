import 'dart:convert';

import 'package:banana/entity/BookInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'book_detail.dart';

class BookWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  List<Book> _data;
  ScrollController _controller;
  bool _requesting;
  int _page;

  @override
  void initState() {
    // TODO: implement initState
    _data = new List<Book>();
    _requesting = false;
    _page = 0;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _handleRequestData();
      }
    });
    _handleRequestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("段子"),
      ),
      body: RefreshIndicator(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Container(
              height: 1.0,
              child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  color: Colors.black,
                ),
              ),
            );
          },
          itemBuilder: (context, index) {
            return Container(
              height: 80.0,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookDetailWidget(
                            content: _data[index].content,
                          );
                        }));
                      },
                      child: Container(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _data[index].content,
                                style: TextStyle(fontSize: 15.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text(
                                _data[index].updateTime,
                                style: TextStyle(fontSize: 12.0),
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      )))),
            );
          },
          itemCount: _data.length,
          controller: _controller,
        ),
        onRefresh: _handleRefreshData,
        color: Colors.blue,
        backgroundColor: Colors.black,
      ),
    );
  }

  Future<Null> _handleRefreshData() async {
    if (!_requesting) {
      _requesting = true;
      _page = 0;
      var url = "https://www.mxnzp.com/api/jokes/list?page=${++_page}";
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var bookInfo = BookInfo.fromJson(jsonData);
        setState(() {
          _data.clear();
          _data.addAll(bookInfo.data.list);
          _requesting = false;
        });
        return Future<Null>.value();
      }
    }
    return Null;
  }

  _handleRequestData() async {
    if (!_requesting) {
      _requesting = true;
      var url = "https://www.mxnzp.com/api/jokes/list?page=${++_page}";
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var bookInfo = BookInfo.fromJson(jsonData);
        setState(() {
          _data.addAll(bookInfo.data.list);
          _requesting = false;
        });
      }
    }
  }
}
