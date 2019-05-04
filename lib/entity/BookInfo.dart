class BookInfo {
  int code;
  String msg;
  _Data data;

  BookInfo({this.code,this.msg,this.data});

  BookInfo.fromJson(Map<String, dynamic> json){
    this.code = json['code'];
    this.msg = json['msg'];
    this.data = _Data.fromJson(json['data']);
  }
}

class _Data {
  int page;
  int totalCount;
  int totalPage;
  int limit;
  List<Book> list;

  _Data({this.page, this.totalCount, this.totalPage, this.limit, this.list});

  _Data.fromJson(Map<String, dynamic> json) {
    this.page = json['page'];
    this.totalCount = json['totalCount'];
    this.totalPage = json['totalPage'];
    this.limit = json['limit'];
    this.list = List<Book>();
    json['list'].forEach((value) {
      this.list.add(Book.fromJson(value));
    });
  }
}

class Book {
  String content;
  String updateTime;

  Book({this.content, this.updateTime});

  Book.fromJson(Map<String, dynamic> json) {
    this.content = json['content'];
    this.updateTime = json['updateTime'];
  }
}
