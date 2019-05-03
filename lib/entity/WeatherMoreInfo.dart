class WeatherMoreInfo {
  int code;
  String msg;
  _Data data;

  WeatherMoreInfo({this.code, this.msg, this.data});

  WeatherMoreInfo.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.msg = json['msg'];
    this.data = _Data.fromJson(json['data']);
  }
}

class _Data {
  String address;
  String cityCode;
  String reportTime;
  List<_Weather> forecasts;

  _Data({this.address, this.cityCode, this.reportTime, this.forecasts});

  _Data.fromJson(Map<String, dynamic> json) {
    this.address = json['address'];
    this.cityCode = json['cityCode'];
    this.reportTime = json['reportTime'];
    this.forecasts = List<_Weather>();
    json['forecasts'].forEach((value) {
      this.forecasts.add(_Weather.fromJson(value));
    });
  }
}

class _Weather {
  String date;
  String dayOfWeek;
  String dayWeather;
  String nightWeather;
  String dayTemp;
  String nightTemp;
  String dayWindDirection;
  String nightWindDirection;
  String dayWindPower;
  String nightWindPower;

  _Weather(
      {this.date,
      this.dayOfWeek,
      this.dayWeather,
      this.nightWeather,
      this.dayTemp,
      this.nightTemp,
      this.dayWindDirection,
      this.nightWindDirection,
      this.dayWindPower,
      this.nightWindPower});

  _Weather.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.dayOfWeek = json['dayOfWeek'];
    this.dayWeather = json['dayWeather'];
    this.nightWeather = json['nightWeather'];
    this.dayTemp = json['dayTemp'];
    this.nightTemp = json['nightTemp'];
    this.dayWindDirection = json['dayWindDirection'];
    this.nightWindDirection = json['nightWindDirection'];
    this.dayWindPower = json['dayWindPower'];
    this.nightWindPower = json['nightWindPower'];
  }
}
