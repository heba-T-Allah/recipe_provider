

import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width:MediaQuery.of(context).size.width ,
          height: 70,
          decoration: BoxDecoration(
            color: ColorManager.backgroundGreyColor,
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          child: const Center(child: Text('No Data Found'))),
    );
  }
}
