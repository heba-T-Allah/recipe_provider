import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({
    super.key,
  });

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    String userName =
        FirebaseAuth.instance.currentUser?.displayName.toString() ??
            "No name";

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                backgroundImage: AssetImage("assets/images/1686.jpg"),
                radius: AppSize.s40),
            // SizedBox(width: 10,),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left:8,
                top: 14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles.textStyleRegular18Black,
                    ),
                    Text(
                      AppStrings.viewProfile,
                      style: TextStyles.textStyleRegular10Grey,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
