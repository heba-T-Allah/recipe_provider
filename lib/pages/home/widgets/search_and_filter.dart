import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/filter/filter_screen.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/providers/ingredients_provider.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_style.dart';
import '../../../utils/navigation.dart';

class SearchAndFilter extends StatefulWidget {
  SearchAndFilter({
    super.key,
    required this.screen,
  });

  String? screen;

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 8,
            child: InkWell(
              onTap: () {
                if (widget.screen == "home") {
                  NavigationUtils.push(context: context, page: FilterScreen());
                }
              },
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.backgroundGreyColor,
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorManager.greyText,
                    ),
                    // border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                    hintText: widget.screen == "home"
                        ? AppStrings.search
                        : AppStrings.searchUsingKeyword,
                    hintStyle: TextStyles.textStyleRegular13Grey,
                  ),
                  onChanged: (value) {
                    if (widget.screen == "ingredients") {
                      Provider.of<IngredientsProvider>(context, listen: false)
                          .searchIngredients(value);
                    } else {
                      Provider.of<HomeProvider>(context, listen: false)
                          .searchRecipe(value, widget.screen!);
                    }
                  },
                  // onSubmitted: (value) =>  Provider.of<HomeProvider>(context, listen: false)
                  //     .searchRecipe(value, widget.screen!),
                  enabled: widget.screen == "home" ? false : true,
                ),
              ),
            )),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () =>
                NavigationUtils.push(context: context, page: FilterScreen()),
            child: Container(
              height: 60,
              width: 30,
              decoration: BoxDecoration(
                color: ColorManager.backgroundGreyColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  ImageAssets.filterIcon,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
