import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/text_style.dart';
import '../../../resources/values_manager.dart';
import '../logic/ads_provider.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Provider.of<AdsProvider>(context, listen: false).initCarousal();
    await Provider.of<AdsProvider>(context, listen: false).getAds();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(
      builder: (BuildContext context, adProvider, Widget? child) => adProvider
                  .adsList ==
              null
          ? const Center(child: CircularProgressIndicator())
          : adProvider.adsList!.isEmpty
              ? const Text('No Data Found')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: adProvider.adsList!
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
                                            padding: const EdgeInsets.all(
                                                AppPadding.p8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black38,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSize.s20)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    AppPadding.p8),
                                                child: Text(
                                                    recipeAd.title.toString(),
                                                    style: TextStyles
                                                        .textStyleRegular16White),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            carouselController:
                                adProvider.buttonCarouselController,
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * .3,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              enableInfiniteScroll: true,
                              viewportFraction: 0.8,
                              initialPage: adProvider.currentPos,
                              aspectRatio: 2,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (index, _) {
                                adProvider.onPageChanged(index);
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
                                  onPressed: () {
                                    Provider.of<AdsProvider>(context,
                                            listen: false)
                                        .sliderForwardArrow();
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
                                onPressed: () {
                                  Provider.of<AdsProvider>(context,
                                          listen: false)
                                      .sliderBackArrow();
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s15),
                      Center(
                        child: DotsIndicator(
                          onTap: (position) {
                            adProvider.onDotTapped(position);
                          },
                          dotsCount: adProvider.adsList!.length,
                          position: adProvider.currentPos,
                          decorator: const DotsDecorator(
                            color: Colors.grey, // Inactive color
                            activeColor: Colors.redAccent,
                          ),
                        ),
                      )
                    ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}