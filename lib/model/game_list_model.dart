class GameListModel {
  final String? message;
  final List? data;

  const GameListModel({
    this.message,
    this.data,
  });

  factory GameListModel.fromJson(Map<String, dynamic> json) {
    return GameListModel(message: json["message"], data: json["data"]);
  }
}

