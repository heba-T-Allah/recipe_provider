import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/filter/widgets/title_and_slider.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/providers/setting_provider.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../home/widgets/recommended_list.dart';
import '../widgets/no_data_found_widget.dart';
import '../widgets/skelton.dart';
import '../widgets/text_button_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String _mealValue = "Breakfast";
  late bool filtered;

  @override
  void initState() {
    filtered = false;
    super.initState();
  }

  void resetFilter() {
    _mealValue = S.of(context).Breakfast;

    //clear all filters
    Provider.of<HomeProvider>(context, listen: false).filterSendValue = {};
  }

  @override
  Widget build(BuildContext context) {
    List<String> mealList = [
      S.of(context).Breakfast,
      S.of(context).Launch,
      S.of(context).Dinner
    ];
    String local =
        Provider.of<SettingProvider>(context, listen: false).getLocal();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<HomeProvider>(builder: (context, provider, child) {
              if (filtered) {
                if (provider.filteredList == null) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      itemCount: 3,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Skelton();
                      },
                    ),
                  );
                } else if (provider.filteredList!.isEmpty) {
                  return const NoDataFoundWidget();
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
                          S.of(context).filter,
                          style: TextStyles.textStyleRegular26Black,
                        ),
                        InkWell(
                          onTap: () {
                            resetFilter();
                          },
                          child: Text(
                            S.of(context).reset,
                            style: TextStyles.textStyleMedium14Orange,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(S.of(context).meal,
                        style: TextStyles.textStyleBold18Black),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mealList
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _mealValue = e;
                                    });
                                  },
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
                                        setState(() {
                                          _mealValue = e;
                                          print(
                                              ",,,,,,,,,,,$_mealValue     $e");
                                          if (local == "ar") {
                                            provider.filterSendValue[
                                                'meal_type_ar'] = e;
                                          } else {
                                            provider.filterSendValue[
                                                'meal_type'] = e;
                                          }
                                        });
                                      }),
                                ),
                              ))
                          .toList(),
                    ),
                    TitleAndSlider(
                      title: S.of(context).serving,
                      titleValue: AppStrings.serving,
                      max: 100,
                      division: 5,
                    ),
                    TitleAndSlider(
                      title: S.of(context).preparationTime,
                      titleValue: AppStrings.preparationTime,
                      max: 240,
                      division: 15,
                    ),
                    TitleAndSlider(
                      title: S.of(context).calories,
                      titleValue: AppStrings.calories,
                      max: 1000,
                      division: 100,
                    ),
                    TitleAndSlider(
                      title: S.of(context).rate,
                      titleValue: AppStrings.rate,
                      max: 5,
                      division: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButtonWidget(
                        buttonText: S.of(context).apply,
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
