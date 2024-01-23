import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/color_manager.dart';
import '../logic/home_provider.dart';

class MyFavIcon extends StatefulWidget {
   MyFavIcon({
    super.key,
    required this.isFav,
     required this.docId,
     required this.listType
  });

  bool? isFav;
  String? docId;
  String? listType;

  @override
  State<MyFavIcon> createState() => _MyFavIconState();
}

class _MyFavIconState extends State<MyFavIcon> {
  @override
  Widget build(BuildContext context) {
    return    Consumer<HomeProvider>(
        builder: (context, value, child) => IconButton(
            onPressed: () {
              widget.isFav = !widget.isFav!;
              print("============ ${widget.isFav}");
              value.addFavToRecipe(
                 widget.docId!, widget.isFav!, widget.listType!);
              setState(() {

              });
            },
            icon: Icon(
              widget.isFav == true ? Icons.favorite : Icons.favorite_border,
              color: widget.isFav == true
                  ? ColorManager.primaryColor
                  : ColorManager.greyText,
            )));
    //   Icon(
    //  favourite == true
    //       ? Icons.favorite
    //       : Icons.favorite_border,
    //   color: favourite == true
    //       ? ColorManager.primaryColor
    //       : ColorManager.greyText,
    // );
  }
}
