class Recipe {
  String? title;
  String? image;
  String? mealType;
  double? rating;
  double? calories;
  int? prepTime;
  int? serving;
  bool? favorite;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    image = data['image'];
    mealType = data['meal_type'];
    rating = data['rating'];
    calories = data['calories'];
    prepTime = data['prep_time'];
    serving = data['serving'];
    favorite = data['favourite'];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      "meal_type": mealType,
      'rating': rating,
      'calories': calories,
      'prep_time': prepTime,
      'serving': serving,
      'favourite': favorite
    };
  }
}
