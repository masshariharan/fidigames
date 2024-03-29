class GameListModel {
  final String? message;
  final List<GameDetail>? data;

  const GameListModel({
    this.message,
    this.data,
  });

  factory GameListModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    List<GameDetail>? dataList = list
        .map((i) => i == null ? null : GameDetail.fromJson(i))
        .cast<GameDetail>()
        .toList();

    return GameListModel(
      message: json["message"],
      data: dataList,
    );
  }
}

class GameDetail {
  final int? id;
  final String? gameName;
  final String? gameDescription;
  final int? minP;
  final int? maxP;
  final String? gameURL;
  final String? gameCategory;
  int? likesCount;
  final String? imageURL;

  GameDetail({
    this.id,
    this.gameName,
    this.gameDescription,
    this.minP,
    this.maxP,
    this.gameCategory,
    this.gameURL,
    this.likesCount,
    this.imageURL,
  });

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    return GameDetail(
      id: json["id"],
      gameName: json["game_name"],
      gameDescription: json["game_description"],
      gameURL: json["game_url"],
      minP: json["game_minp"],
      maxP: json["game_maxp"],
      gameCategory: json["game_category"],
      likesCount: json["game_likes_count"],
      imageURL: json["game_image_url"],
    );
  }
}
