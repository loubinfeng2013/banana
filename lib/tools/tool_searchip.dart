import 'dart:convert';

import 'package:banana/entity/IpInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToolSearchIpWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToolSearchIpWidgetState();
}

class _ToolSearchIpWidgetState extends State<ToolSearchIpWidget> {
  IpInfo _ipInfo;
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("查询ip"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          labelText: "查询的ip",
                        ),
                        controller: _controller,
                      ),
                      flex: 1,
                    ),
                    Container(
                        width: 60.0,
                        child: RaisedButton(
                          onPressed: () {
                            _getIpData(_controller.text).then((value) {
                              setState(() {
                                _ipInfo = value;
                              });
                            });
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ))
                  ],
                )),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ip地址:${_ipInfo?.data?.ip}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "省份:${_ipInfo?.data?.province} ${_ipInfo?.data?.provinceId}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "城市:${_ipInfo?.data?.city} ${_ipInfo?.data?.cityId}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "运营商:${_ipInfo?.data?.isp}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "详细描述:${_ipInfo?.data?.desc}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              flex: 1,
            )
          ],
        ));
  }

  Future<IpInfo> _getIpData(String ip) async {
    var url = "https://www.mxnzp.com/api/ip/aim_ip?ip=$ip";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      return Future.value(IpInfo.fromJson(dataJson));
    }
    return null;
  }
}
