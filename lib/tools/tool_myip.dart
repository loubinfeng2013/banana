import 'dart:convert';

import 'package:banana/entity/IpInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToolMyIpWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToolMyIpWidgetState();
}

class _ToolMyIpWidgetState extends State<ToolMyIpWidget> {
  IpInfo _ipInfo;
  bool _requestBack;

  @override
  void initState() {
    // TODO: implement initState
    _requestBack = false;
    _getIpData().then((value) {
      setState(() {
        _ipInfo = value;
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
        title: Text("当前ip"),
      ),
      body: _requestBack
          ? Center(
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
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                //backgroundColor: Colors.blue,
                // value: 0.2,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
    );
  }

  Future<IpInfo> _getIpData() async {
    var url = "https://www.mxnzp.com/api/ip/self";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      return Future.value(IpInfo.fromJson(dataJson));
    }
    return null;
  }
}
