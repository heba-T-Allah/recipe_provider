class RecipeAd {
  String? title;
  String? image;

  RecipeAd();

  RecipeAd.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    image = data['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
    };
  }
}
