import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/update_profile_provider.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../../utils/navigation.dart';
import '../update_profile/update_profile_screen.dart';

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
    Provider.of<UpdateProfileProvider>(context,listen: false).getUserPhotoUrl();
    Provider.of<UpdateProfileProvider>(context,listen: false).getUserName();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Consumer<UpdateProfileProvider>(builder: (context, value, child) =>
     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: value.profileImageUrl! ,
                placeholder: (context, url) =>
                new CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: NetworkImage(
                      value.profileImageUrl!,
                    ),
                    radius: AppSize.s40),
              ),
              // SizedBox(width: 10,),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.getUserName() ,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyles.textStyleRegular18Black,
                      ),
                      InkWell(
                        onTap: () =>  NavigationUtils.push(
                            context: context, page: UpdateProfileScreen()),
                        child: Text(
                          AppStrings.viewProfile,
                          style: TextStyles.textStyleRegular10Grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
