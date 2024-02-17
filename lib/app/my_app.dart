import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/providers/forget_password_provider.dart';
import 'package:registration/providers/ingredients_provider.dart';
import 'package:registration/providers/setting_provider.dart';
import 'package:registration/providers/update_profile_provider.dart';
import 'package:registration/routing/app-router.dart';
import 'package:registration/providers/ads_provider.dart';
import 'package:registration/providers/home_provider.dart';
import 'package:registration/providers/signup_provider.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../routing/routes.dart';
import '../providers/login_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(
            create: (BuildContext context) => LoginProvider(),
          ),
          ChangeNotifierProvider<SignUpProvider>(
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
          ChangeNotifierProvider<SettingProvider>(
            create: (BuildContext context) => SettingProvider(),
          ),
        ],
        child: OverlayKit(
          child: Consumer<SettingProvider>(
            builder: (context, value, child) {
              return MaterialApp(
                locale: value.local,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: AppStrings.appTitle,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                  seedColor: ColorManager.primaryColor,
                  primary: ColorManager.primaryColor,
                  secondary: ColorManager.primaryColor,
                )),
                initialRoute: Routes.splashScreen,
                onGenerateRoute: appRouter.generateRoute,
              );
            },
          ),
        ));
  }
}
