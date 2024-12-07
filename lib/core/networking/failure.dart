class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

class ErrorModel {
  bool? success;
  String? message;

  ErrorModel({this.success, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;

    return data;
  }
}
