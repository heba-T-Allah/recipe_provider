import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/routing/app-router.dart';
import 'package:registration/view/home/logic/home_provider.dart';
import '../resources/strings_manager.dart';
import '../routing/routes.dart';
import '../view/favorite/logic/favorite_provider.dart';
import '../view/recently_viewed/logic/recently_viewed_provider.dart';
import '../view/sign_in/logic/login_provider.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(
            create: (BuildContext context) => LoginProvider(),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (BuildContext context) => HomeProvider()..getAdsAndRecipes(),
          ),
          ChangeNotifierProvider<FavoriteProvider>(
            create: (BuildContext context) => FavoriteProvider()..getFavoriteRecipes(),
          ),
          ChangeNotifierProvider<RecentlyViewedProvider>(
            create: (BuildContext context) => RecentlyViewedProvider(),
          ),
        ],
        child: MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //     inputDecorationTheme: InputDecorationTheme(
          //       filled: true,
          //       fillColor: Colors.grey.shade200,
          //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          //     ),
          //     colorScheme: ColorScheme.fromSeed(
          //       seedColor: ColorManager.primaryColor,
          //       primary: ColorManager.primaryColor,
          //       secondary: ColorManager.primaryColor,
          //     )),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: appRouter.generateRoute,
        ));
  }
}
