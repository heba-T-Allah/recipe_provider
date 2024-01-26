class Recipe {
  String? docId;
  String? title;
  String? image;
  String? mealType;
  double? rating;
  double? calories;
  int? prepTime;
  int? serving;
  // bool? favorite;

  List<dynamic>? ingredients;
  List<dynamic>? directions;
  List<String>? favUsersIds;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    title = data['title'];
    image = data['image'];
    mealType = data['meal_type'];
    rating = double.parse(data['rating'].toString());
    calories = double.parse(data['calories'].toString());
    prepTime = data['prep_time'];
    serving = data['serving'];
    // favorite = data['favorite'];
    directions = data['directions'].map((e) => e.toString()).toList();
    ingredients = data['ingredients'].map((e) => e.toString()).toList();
    favUsersIds = data['users_ids'] != null
        ? List<String>.from(data['users_ids'].map((e) => e.toString()))
        : null;
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
      // 'favorite': favorite,
      'directions': directions,
      'ingredients': ingredients,
      "users_ids": favUsersIds,

    };
  }
}
