// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Recipe App`
  String get appTitle {
    return Intl.message(
      'Recipe App',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cooking Done The easy way`
  String get splashTitle {
    return Intl.message(
      'Cooking Done The easy way',
      name: 'splashTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// ` Register`
  String get register {
    return Intl.message(
      ' Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailHintText {
    return Intl.message(
      'Email Address',
      name: 'emailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameHintText {
    return Intl.message(
      'Full Name',
      name: 'fullNameHintText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get donotHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'donotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register.`
  String get registerDot {
    return Intl.message(
      'Register.',
      name: 'registerDot',
      desc: '',
      args: [],
    );
  }

  /// `Send Mail`
  String get sendMail {
    return Intl.message(
      'Send Mail',
      name: 'sendMail',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Not registered yet,Sign Up`
  String get notRegistered {
    return Intl.message(
      'Not registered yet,Sign Up',
      name: 'notRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Already have account?`
  String get alreadyRegistered {
    return Intl.message(
      'Already have account?',
      name: 'alreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeScreen {
    return Intl.message(
      'Home',
      name: 'homeScreen',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `loggedIn`
  String get isLoggedInPref {
    return Intl.message(
      'loggedIn',
      name: 'isLoggedInPref',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get userName {
    return Intl.message(
      'User name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get emailPref {
    return Intl.message(
      'email',
      name: 'emailPref',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get passwordPref {
    return Intl.message(
      'password',
      name: 'passwordPref',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid Email`
  String get notValidEmail {
    return Intl.message(
      'Not Valid Email',
      name: 'notValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get passwordTooShort {
    return Intl.message(
      'Password is too short',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid Password`
  String get pleaseEnterValidPassword {
    return Intl.message(
      'Please enter a valid Password',
      name: 'pleaseEnterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `What Would you Like to Cook \n Today?`
  String get whatWouldYouLikeToCook {
    return Intl.message(
      'What Would you Like to Cook \n Today?',
      name: 'whatWouldYouLikeToCook',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Today 's Fresh Recipes`
  String get todayFresh {
    return Intl.message(
      'Today \'s Fresh Recipes',
      name: 'todayFresh',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong Please try again`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong Please try again',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `There is no data`
  String get thereIsNoData {
    return Intl.message(
      'There is no data',
      name: 'thereIsNoData',
      desc: '',
      args: [],
    );
  }

  /// `View Profile`
  String get viewProfile {
    return Intl.message(
      'View Profile',
      name: 'viewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `RecentlyViewed`
  String get recentlyViewed {
    return Intl.message(
      'RecentlyViewed',
      name: 'recentlyViewed',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Directions`
  String get directions {
    return Intl.message(
      'Directions',
      name: 'directions',
      desc: '',
      args: [],
    );
  }

  /// `All Recipe`
  String get allRecipe {
    return Intl.message(
      'All Recipe',
      name: 'allRecipe',
      desc: '',
      args: [],
    );
  }

  /// `Meal`
  String get meal {
    return Intl.message(
      'Meal',
      name: 'meal',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Serving`
  String get serving {
    return Intl.message(
      'Serving',
      name: 'serving',
      desc: '',
      args: [],
    );
  }

  /// `Preparation Time`
  String get preparationTime {
    return Intl.message(
      'Preparation Time',
      name: 'preparationTime',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get calories {
    return Intl.message(
      'Calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rate {
    return Intl.message(
      'Rating',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Search using keyword`
  String get searchUsingKeyword {
    return Intl.message(
      'Search using keyword',
      name: 'searchUsingKeyword',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get changeName {
    return Intl.message(
      'Change Name',
      name: 'changeName',
      desc: '',
      args: [],
    );
  }

  /// `this Recipe app is for people who are confused about choosing meals, as it allows them to add the ingredients available in their kitchen and choose the appropriate meal for them. they can also view the meals they have recently viewed, add meals to favorites, and remove them.`
  String get aboutUsContent {
    return Intl.message(
      'this Recipe app is for people who are confused about choosing meals, as it allows them to add the ingredients available in their kitchen and choose the appropriate meal for them. they can also view the meals they have recently viewed, add meals to favorites, and remove them.',
      name: 'aboutUsContent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name.`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name.',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Mail sent Successfully`
  String get mailSentSuccessfully {
    return Intl.message(
      'Mail sent Successfully',
      name: 'mailSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get calorie {
    return Intl.message(
      'Calories',
      name: 'calorie',
      desc: '',
      args: [],
    );
  }

  /// `Serving`
  String get servingNum {
    return Intl.message(
      'Serving',
      name: 'servingNum',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get min {
    return Intl.message(
      'Min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `You registered Successfully`
  String get youRegisteredSuccessfully {
    return Intl.message(
      'You registered Successfully',
      name: 'youRegisteredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You login Successfully`
  String get YouLogedinSuccessfully {
    return Intl.message(
      'You login Successfully',
      name: 'YouLogedinSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No filter Data entered.`
  String get NoFilterDataEntered {
    return Intl.message(
      'No filter Data entered.',
      name: 'NoFilterDataEntered',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get NoDataFound {
    return Intl.message(
      'No Data Found',
      name: 'NoDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Error when get data`
  String get errorWhenGetData {
    return Intl.message(
      'Error when get data',
      name: 'errorWhenGetData',
      desc: '',
      args: [],
    );
  }

  /// `Step`
  String get Step {
    return Intl.message(
      'Step',
      name: 'Step',
      desc: '',
      args: [],
    );
  }

  /// `Bonjour`
  String get Bonjour {
    return Intl.message(
      'Bonjour',
      name: 'Bonjour',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast`
  String get Breakfast {
    return Intl.message(
      'Breakfast',
      name: 'Breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Launch`
  String get Launch {
    return Intl.message(
      'Launch',
      name: 'Launch',
      desc: '',
      args: [],
    );
  }

  /// `Dinner`
  String get Dinner {
    return Intl.message(
      'Dinner',
      name: 'Dinner',
      desc: '',
      args: [],
    );
  }

  /// `العربيه`
  String get arabic {
    return Intl.message(
      'العربيه',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `name is empty!`
  String get nameIsEmpty {
    return Intl.message(
      'name is empty!',
      name: 'nameIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email is empty!`
  String get emailIsEmpty {
    return Intl.message(
      'Email is empty!',
      name: 'emailIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `password is empty!`
  String get passwordIsEmpty {
    return Intl.message(
      'password is empty!',
      name: 'passwordIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `field is empty`
  String get fieldIsEmpty {
    return Intl.message(
      'field is empty',
      name: 'fieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Yes {
    return Intl.message(
      'Yes',
      name: 'Yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit?`
  String get Areyousureyouwanttoexit {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'Areyousureyouwanttoexit',
      desc: '',
      args: [],
    );
  }

  /// `Exit App`
  String get ExitApp {
    return Intl.message(
      'Exit App',
      name: 'ExitApp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
