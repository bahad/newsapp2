import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp2/core/init/cache/shared_preferences_config.dart';
import 'package:newsapp2/pages/comment/comment_viewmodel.dart';
import 'package:newsapp2/pages/favorites/favorites_viewmodel.dart';
import 'package:newsapp2/pages/home/home_viewmodel.dart';
import 'package:newsapp2/pages/login/login_viewmodel.dart';
import 'package:newsapp2/pages/newsdetail/newsdetail_viewmodel.dart';
import 'package:newsapp2/pages/profile/profile_viewmodel.dart';
import 'package:newsapp2/pages/signup/signup_viewmodel.dart';
import 'package:newsapp2/pages/splash/splash_view.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/init/theme/app_theme_light.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/splash/splash_viewmodel.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  PreferenceUtils.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("tr-TR", null);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      //  splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
            ChangeNotifierProvider<NewsDetailProvider>(
                create: (_) => NewsDetailProvider()),
            ChangeNotifierProvider<CommentProvider>(
                create: (_) => CommentProvider()),
            ChangeNotifierProvider<ProfileProvider>(
                create: (_) => ProfileProvider()),
            ChangeNotifierProvider<LoginProvider>(
                create: (_) => LoginProvider()),
            ChangeNotifierProvider<SignupProvider>(
                create: (_) => SignupProvider()),
            ChangeNotifierProvider<FavoritesProvider>(
                create: (_) => FavoritesProvider()),
            ChangeNotifierProvider<SplashProvider>(
                create: (_) => SplashProvider()),
          ],
          child: MaterialApp(
              title: ApplicationConstants.appName,
              theme: AppThemeLight.instance.theme,

              /*  localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ], */
              /* supportedLocales: const [
                Locale('en'),
                Locale('tr'),
              ], */
              home: const SplashView()),
        );
      },
    );
  }
}
