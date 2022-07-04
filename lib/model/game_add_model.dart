class GameAddModel {
  final String? msg;

  GameAddModel({
    this.msg,
  });

  factory GameAddModel.fromJson(Map<String, dynamic> json) {
    return GameAddModel(
      msg: json["msg"],
    );
  }
}
