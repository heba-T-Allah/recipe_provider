import 'dart:core';

class Car {
  String? model;
  String? color;
  int? year;

  Car({this.model, this.color, this.year});

  Car.fromMap(Map<String, dynamic> data) {
    model = data['model'];
    color = data['color'];
    year = data['year'];
  }


  void moveForward() {}

  void moveBackward() {}

  void stop() {}

  void turnLeft() {}

  void turnRight() {}

  void honk() {}

  void drive() {
    print("I can drive ");
  }
}

class Sedan extends Car {
  final String _type = "Sedan";
String get type=>_type;
  Sedan() {
    print("type sedan");
  }


}

class HatchPack extends Car {
  HatchPack({super.model, super.color, super.year});
  

  @override
  void honk() {
    print("honk loader");
    super.honk();
  }
}

class Jeep extends Car {
  @override
  void drive() {
    print("I am 4x4 car");
    super.drive();
  }
}

void main() {
  Car myCar = new Car(color: "red",
      model: "my model", year: 2013);
  myCar.drive();


  Jeep myJeep = Jeep();
  myJeep.drive();



  HatchPack hatchPack = HatchPack(
      year: 2020, model: "any model", color: "black");
  print(hatchPack.model);
  hatchPack.honk();

  var data={"color":"red","model":"this model","year" :2030 };
  Car newCar=Car.fromMap(data);
  print(newCar.model);

  Sedan sedan=Sedan();
  print(sedan.type);
}
