class CategoryGameListModel {
  final List<CategoryGameDetail>? categoryData;

  const CategoryGameListModel({
    this.categoryData,
  });

  factory CategoryGameListModel.fromJson(List<dynamic> json) {
    List<CategoryGameDetail>? categoryDataList = json
        .map((i) => i == null ? null : CategoryGameDetail.fromJson(i))
        .cast<CategoryGameDetail>()
        .toList();

    return CategoryGameListModel(
      categoryData: categoryDataList,
    );

    // List<CategoryGameDetail> categoryList =
    //     json.map((i) => CategoryGameDetail.fromJson(i)).toList();
  }
}

class CategoryGameDetail {
  final int? id;
  final String? gameName;
  final String? gameDescription;
  final int? minP;
  final int? maxP;
  final String? gameURL;
  final String? gameCategory;
  int? likesCount;
  final String? imageURL;

  CategoryGameDetail({
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

  factory CategoryGameDetail.fromJson(Map<String, dynamic> json) {
    return CategoryGameDetail(
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
