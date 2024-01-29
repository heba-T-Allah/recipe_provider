import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/filter/widgets/title_and_slider.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../home/widgets/recommended_list.dart';
import '../widgets/text_button_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    filtered = false;
    super.initState();
  }

  String? _mealValue = "Breakfast";
  late bool filtered;

  void resetFilter() {
    _mealValue = "Breakfast";
    //clear all filters
    Provider.of<HomeProvider>(context, listen: false).filterValue = {};
  }

  @override
  Widget build(BuildContext context) {
    List<String> mealList = ["Breakfast", "Launch", "Dinner"];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<HomeProvider>(builder: (context, provider, child) {
              if (filtered) {
                if (provider.filteredList == null) {
                  return Skeletonizer(enabled: true, child: Text('Loading...'));
                } else if (provider.filteredList!.isEmpty) {
                  return const Text('No Data Found');
                } else {
                  return RecommendedRecipeList(
                    recipeList: provider.filteredList!,
                    screen: "filter",
                  );
                }
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.filter,
                          style: TextStyles.textStyleRegular26Black,
                        ),
                        InkWell(
                          onTap: () {
                            resetFilter();
                          },
                          child: Text(
                            AppStrings.reset,
                            style: TextStyles.textStyleMedium14Orange,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(AppStrings.meal,
                        style: TextStyles.textStyleBold18Black),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mealList
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ChoiceChip(
                                    showCheckmark: false,
                                    label: Text(
                                      e,
                                      style: _mealValue == e
                                          ? TextStyles.textStyleMedium12Orange
                                          : TextStyles
                                              .textStyleMedium12DarkGrey,
                                    ),
                                    backgroundColor: _mealValue == e
                                        ? ColorManager.primaryColor
                                        : ColorManager.darkGreyBg,
                                    selected: _mealValue == e,
                                    onSelected: (bool selected) {
                                      setState(() {});
                                      _mealValue = e;
                                      provider.filterValue['meal_type'] = e;
                                      // selectedFilterValue['meal_type'] = e;
                                      // print(selectedFilterValue);
                                    }),
                              ))
                          .toList(),
                    ),
                    TitleAndSlider(
                      title: AppStrings.serving,
                      max: 100,
                      division: 5,
                    ),
                    TitleAndSlider(
                      title: AppStrings.preparationTime,
                      max: 240,
                      division: 15,
                    ),
                    TitleAndSlider(
                      title: AppStrings.calories,
                      max: 1000,
                      division: 100,
                    ),
                    TitleAndSlider(
                      title: AppStrings.rate,
                      max: 5,
                      division: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButtonWidget(
                        buttonText: AppStrings.apply,
                        textStyle: TextStyles.textStyleRegular16White,
                        onPressed: () {
                          setState(() {});
                          filtered = true;
                          provider.getFilteredRecipes();
                        }),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}