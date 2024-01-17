import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
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


  String getuserName() {
   String userName = FirebaseAuth.instance.currentUser?.displayName.toString() ??
        "Emma Holmes";
    setState(() {});
    return userName;
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    getuserName(),
                    style: TextStyles.textStyleRegular18Black,
                  ),
                  // SizedBox(height: 20),
                  Text(
                    AppStrings.viewProfile,
                    style: TextStyles.textStyleRegular10Grey,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  ImageAssets.notificationsIcon,
                  color: Colors.black,
                  width: AppSize.s20,
                  height: AppSize.s20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
