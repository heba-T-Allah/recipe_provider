main() {
  ////1
  printNumbersLessThan5();
  //
  // //----------------------------------
  //
  // ////2 returns a list that contains only the elements that are common
  // List common = getCommonElements();
  //
  // print("common numbers are : $common");
  //
  // //------------------------------------
  // ////3 Dart code that takes this list and makes a new list that has only the even elements of this list in it.
  // List a = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
  // getEvenElements(a);
  // //------------------------------------
  // ////4make new list of only the first and last elements
  // List x = [5, 10, 15, 20, 25];
  // getFirstAndLastElements(x);
  //



  var vals = <int>[1, 2, 3, 4, 5];
  var sum = vals.reduce((sum, e) => sum += e);
  var product = vals.reduce((product, e) => product *= e);
  print('The sum is $sum');
  print('The product is $product');
}

void printNumbersLessThan5() {
  List<int> a = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  // List x=[];
  // for (int i in a) {
  //   if (i < 5) {
  //    x.add(i);
  //   }
  // }
  a.removeWhere((element) => element>=5);
  print("the numbers that are less than 5 are : $a");
}

List getCommonElements() {
  List<int> a = [1, 33, 44, 5, 6, 7, 8, 9, 6, 88];
  List<int> b = [1, 2, 3, 10, 1, 33, 77, 88, 5, 7, 55, 8];
  List<int> common = [];
  for (int i in a) {
    if (b.contains(i)) {
      common.add(i);
    }
  }

  return common;
}

void getEvenElements(List a) {
  List even = [];
  for (int i in a) {
    if (i % 2 == 0) {
      even.add(i);
    }
  }
  print("even numbers are : $even");

}

void getFirstAndLastElements(List a) {
  List b = [];
  int lastElement = a.last;
  int firstElemnt = a.first;
  b.add(firstElemnt);
  b.add(lastElement);
  print("first and last numbers are : $b");
}
