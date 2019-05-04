class CalendarInfo {
  int code;
  String msg;
  _Data data;

  CalendarInfo({this.code, this.msg, this.data});

  CalendarInfo.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.msg = json['msg'];
    this.data = _Data.fromJson(json['data']);
  }
}

class _Data {
  String date;
  int weekDay;
  String yearTips;
  int type;
  String typeDes;
  String chineseZodiac;
  String solarTerms;
  String avoid;
  String lunarCalendar;
  String suit;
  int dayOfYear;
  int weekOfYear;
  String constellation;

  _Data(
      {this.date,
      this.weekDay,
      this.yearTips,
      this.type,
      this.typeDes,
      this.chineseZodiac,
      this.solarTerms,
      this.avoid,
      this.lunarCalendar,
      this.suit,
      this.dayOfYear,
      this.weekOfYear,
      this.constellation});

  _Data.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.weekDay = json['weekDay'];
    this.yearTips = json['yearTips'];
    this.type = json['type'];
    this.typeDes = json['typeDes'];
    this.chineseZodiac = json['chineseZodiac'];
    this.solarTerms = json['solarTerms'];
    this.avoid = json['avoid'];
    this.lunarCalendar = json['lunarCalendar'];
    this.suit = json['suit'];
    this.dayOfYear = json['dayOfYear'];
    this.weekOfYear = json['weekOfYear'];
    this.constellation = json['constellation'];
  }
}
