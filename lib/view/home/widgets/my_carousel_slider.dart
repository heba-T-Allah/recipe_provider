import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../../model/recipe_ad.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';

class MyCarouselSlider extends StatefulWidget {
  MyCarouselSlider({super.key, required this.adsList});

  List<RecipeAd> adsList = [];


  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  var currentPos = 0;
  late CarouselController buttonCarouselController;

  @override
  void initState() {
    buttonCarouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: widget.adsList
                    .map((recipeAd) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppMargin.m8),
                          child: Stack(
                            children: [
                              Center(
                                  child: Image.asset(
                                recipeAd.image!,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p8),
                                    child: Text(recipeAd.title.toString(),
                                        style:
                                            TextStyles.textStyleRegular16White),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .3,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                  initialPage: currentPos,
                  aspectRatio: 2,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, _) {
                    currentPos = index;

                    setState(() {});
                  },
                  autoPlayAnimationDuration: const Duration(
                      milliseconds: AppConstants.carouselDuration),
                  autoPlayCurve: Curves.easeInCubic,
                ),
              ),
              Positioned(
                  top: 80,
                  right: 4,
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: AppSize.s50,
                      ),
                      onPressed: () async {
                        await buttonCarouselController.nextPage(
                            duration: const Duration(
                                milliseconds: AppConstants.carouselDuration),
                            curve: Curves.easeInCubic);
                      })),
              Positioned(
                top: 80,
                left: 4,
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: AppSize.s50,
                    ),
                    onPressed: () async {
                      await buttonCarouselController.previousPage(
                          duration: const Duration(
                              milliseconds: AppConstants.carouselDuration),
                          curve: Curves.easeInCubic);
                    }),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s15),
          Center(
            child: DotsIndicator(
              onTap: (position) async {
                setState(() => currentPos = position);

                await buttonCarouselController.animateToPage(currentPos);
              },
              dotsCount: widget.adsList.length,
              position: currentPos,
              decorator: const DotsDecorator(
                color: Colors.grey, // Inactive color
                activeColor: Colors.redAccent,
              ),
            ),
          )
        ]);
  }
  @override
  void dispose() {
super.dispose();
  }
}
