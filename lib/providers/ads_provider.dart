import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import '../model/recipe_ad.dart';
import '../resources/constants_manager.dart';
import '../utils/toast_msg_status.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class AdsProvider extends ChangeNotifier {
  List<RecipeAd>? _adsList;

  CarouselController? buttonCarouselController;
  var currentPos = 0;

  List<RecipeAd>? get adsList => _adsList;

  set adsList(List<RecipeAd>? value) {
    _adsList = value;
    notifyListeners();
  }

  void onPageChanged(index) {
    currentPos = index;
    notifyListeners();
  }

  void sliderBackArrow() async {
    await buttonCarouselController!.previousPage(
        duration: const Duration(milliseconds: AppConstants.carouselDuration),
        curve: Curves.easeInCubic);
  }

  void sliderForwardArrow() async {
    await buttonCarouselController!.nextPage(
        duration: const Duration(milliseconds: AppConstants.carouselDuration),
        curve: Curves.easeInCubic);
  }

  void onDotTapped(position) async {
    currentPos = position;
    notifyListeners();
    await buttonCarouselController!.animateToPage(currentPos);
  }

  initCarousal() {
    buttonCarouselController = CarouselController();
  }

  Future<void> getAds(BuildContext context) async {
    try {
      var result = await FirebaseFirestore.instance.collection("ads").get();
      if (result.docs.isNotEmpty) {
        adsList = List<RecipeAd>.from(result.docs
            .map((doc) => RecipeAd.fromJson(doc.data(), context, doc.id)));
      } else {
        adsList = [];
      }
      notifyListeners();
    } catch (e) {
      adsList = [];
      notifyListeners();
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "Error: $e",
        status: ToastMessageStatus.failed,
      ));
    }
  }

  void disposeProvider() {
    buttonCarouselController = null;
  }
}
