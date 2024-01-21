class RecipeAd {
  String? id;
  String? title;
  String? image;

  RecipeAd();

  RecipeAd.fromJson(Map<String, dynamic> data, [String? docId]) {
    title = data['title'];
    image = data['image'];
    id = docId;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
    };
  }
}
