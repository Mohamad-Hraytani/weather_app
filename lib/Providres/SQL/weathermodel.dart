

class weathermodel  {
late String lable;
late int id;

  weathermodel({required this.lable, required this.id});

  @override
  Map<String, dynamic> tomap() {
    return {'lable': this.lable, 'id':this.id };
  }

  weathermodel.fromMap(Map<String, dynamic> map) {
    this.lable = map['lable'];
    this.id = map['id'];
  }

  @override
  String tabel() {
    return 'weather';
  }

  @override
  int getid() {
    return this.id;
  }

String getlable(){

return this.lable;

}
  @override
  String getnamedb() {
    return 'weather_db';
  }


}
