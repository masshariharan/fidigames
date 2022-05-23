class LoginResponseModel {
  final String? msg;
  final String? apiKey;

  LoginResponseModel({this.msg, this.apiKey});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(msg: json["msg"], apiKey: json["api-key"]);
  }
}


