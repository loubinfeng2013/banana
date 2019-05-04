class IpInfo {
  int code;
  String msg;
  _Data data;

  IpInfo({this.code, this.msg, this.data});

  IpInfo.fromJson(Map<String, dynamic> json){
    this.code = json['code'];
    this.msg = json['msg'];
    this.data = _Data.fromJson(json['data']);
  }
}

class _Data {
  String ip;
  String province;
  int provinceId;
  String city;
  int cityId;
  String isp;
  String desc;

  _Data(
      {this.ip,
      this.province,
      this.provinceId,
      this.city,
      this.cityId,
      this.isp,
      this.desc});

  _Data.fromJson(Map<String, dynamic> json) {
    this.ip = json['ip'];
    this.province = json['province'];
    this.provinceId = json['provinceId'];
    this.city = json['city'];
    this.cityId = json['cityId'];
    this.isp = json['isp'];
    this.desc = json['desc'];
  }
}
