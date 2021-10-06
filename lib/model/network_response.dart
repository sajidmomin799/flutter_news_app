import 'dart:convert';

class NetworkResponse {
  int? statusCode;
  String? errorMsg;
  String? response;

  NetworkResponse({this.statusCode, this.response, this.errorMsg});

  bool get isSuccess {
    if (statusCode != null) {
      return statusCode! >= 200 && statusCode! < 300;
    } else {
      return false;
    }
  }
}

extension NetworkResponseExt on NetworkResponse {
  bool get isContentSuccess {
    if (this.isSuccess) {
      var decoded = this.decode();
      if (decoded != null) {
        return decoded['Success'] == true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Map<String, dynamic>? decode() {
    if (response == null) {
      return null;
    }
    return jsonDecode(response!);
  }

  List decodeList() {
    if (response == null) {
      return List.empty();
    }
    return (jsonDecode(response!) as List);
  }

  Map<String, dynamic> decodeInnerObject({String value = "value"}) {
    var content = jsonDecode(response!);
    return content[value];
  }

  List decodeInnerObjectAsList({String value = "value"}) {
    final decoded = this.decode();
    if (decoded == null) {
      return List.empty();
    }
    return decoded[value] as List;
  }
}
