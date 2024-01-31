import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/forget_password_provider.dart';
import 'package:registration/providers/ingredients_provider.dart';
import 'package:registration/providers/update_profile_provider.dart';
import 'package:registration/routing/app-router.dart';
import 'package:registration/providers/ads_provider.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/providers/signup_provider.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../routing/routes.dart';
import '../providers/login_provider.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();
// final navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(
            create: (BuildContext context) => LoginProvider(),
          ),ChangeNotifierProvider<SignUpProvider>(
            create: (BuildContext context) => SignUpProvider(),
          ),
          ChangeNotifierProvider<ForgetPasswordProvider>(
            create: (BuildContext context) => ForgetPasswordProvider(),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (BuildContext context) => HomeProvider(),
          ),
          ChangeNotifierProvider<AdsProvider>(
            create: (BuildContext context) => AdsProvider(),
          ),

          ChangeNotifierProvider<IngredientsProvider>(
            create: (BuildContext context) => IngredientsProvider(),
          ),
          ChangeNotifierProvider<UpdateProfileProvider>(
            create: (BuildContext context) => UpdateProfileProvider(),
          ),
        ],
        child: OverlayKit(
          child: MaterialApp(
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            // navigatorKey: navigatorKey,
            theme: ThemeData(
                // inputDecorationTheme: InputDecorationTheme(
                //   filled: true,
                //   fillColor: Colors.grey.shade200,
                //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                // ),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: ColorManager.primaryColor,
                  primary: ColorManager.primaryColor,
                  secondary: ColorManager.primaryColor,
                )),
            initialRoute: Routes.splashScreen,
            onGenerateRoute: appRouter.generateRoute,
          ),
        ));
  }
}
