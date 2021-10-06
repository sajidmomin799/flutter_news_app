
class Source {
  int? sourceId;
  String? id;
  String? name;

  Source({this.id, this.name});

  _fromJson(Map<String, dynamic> json, bool fromDatabse) {
    sourceId = json['sourceId'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson(bool fromDatabse) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sourceId'] = this.sourceId;
    data['name'] = this.name;
    return data;
  }

  Source.fromJson(dynamic json) {
    _fromJson(json, true);
  }

  Source.fromDBJson(dynamic json) {
    _fromJson(json, true);
  }

  Map<String, dynamic> toDBJson() {
    return toJson(true);
  }
}