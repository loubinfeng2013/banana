class WeatherInfo{
  int code;
  String msg;
  Weather data;

  WeatherInfo({this.code,this.msg,this.data});

  WeatherInfo.fromJson(Map<String , dynamic> json){
    this.code = json['code'];
    this.msg = json['msg'];
    this.data = Weather.fromJson(json['data']);
  }
}

class Weather{
   String address;
   String cityCode;
   String temp;
   String weather;
   String windDirection;
   String windPower;
   String humidity;
   String reportTime;

   Weather({this.address,this.cityCode,this.temp,this.weather,this.windDirection,this.windPower,this.humidity,this.reportTime});

   Weather.fromJson(Map<String , dynamic> json){
      this.address = json['address'];
      this.cityCode = json['address'];
      this.temp = json['temp'];
      this.weather = json['weather'];
      this.windDirection = json['windDirection'];
      this.windPower = json['windPower'];
      this.humidity = json['humidity'];
      this.humidity = json['humidity'];
      this.reportTime = json['reportTime'];
   }
}