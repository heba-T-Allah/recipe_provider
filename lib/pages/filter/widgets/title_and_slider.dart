import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/home_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_style.dart';

class TitleAndSlider extends StatefulWidget {
  TitleAndSlider(
      {super.key,
      required this.title,
      required this.titleValue,
      required this.max,
      required this.division});

  String? title;
  String? titleValue;
  double? value = 0;
  int? division;
  double? max;

  @override
  State<TitleAndSlider> createState() => _TitleAndSliderState();
}

class _TitleAndSliderState extends State<TitleAndSlider> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 30,
            color: ColorManager.greyText,
            thickness: 1,
          ),
          Text(widget.title!, style: TextStyles.textStyleBold18Black),
          Slider(
            min: 0.0,
            label: "${widget.value}",
            max: widget.max!,
            value: widget.value!,
            divisions: widget.division!,
            inactiveColor: ColorManager.greyText,
            onChanged: (val) {
              setState(() {});
              //   provider.selectedValue=val;
              String key;
              if (widget.titleValue == 'Preparation Time') {
                key = "prep_time";
              } else {
                key = widget.titleValue!.toLowerCase();
              }
              provider.filterSendValue[key] = val;
              print("${provider.filterSendValue}  from  slider");
              widget.value = val;
            },
          ),
        ],
      ),
    );
  }
}
