import 'dart:convert';

//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wathakren/consts.dart';
import 'package:wathakren/pages/load_content_screen.dart';
import 'package:wathakren/pages/general_athkar_child_page.dart';
import 'package:wathakren/pages/pager_view/carousel_page1.dart';
import 'package:wathakren/pages/timed_athkar_page.dart';
import 'package:wathakren/providers/settings_provider.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

SharedPreferences? sharedPreferences;
var jsonData = jsonDecode("");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Stream.periodic(Duration(days: 2), (x) {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/8691691433",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (x) {
          x.show();
        }, onAdFailedToLoad: (e) {
          debugPrint("Error Loading Ad: $e");
        }));
  }).listen((event) {});
  Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBtPbkSriXvhe_zGKUQ8B15ckaaCl_Unl0",
        authDomain: "wathakren-3b5fc.firebaseapp.com",
        projectId: "wathakren-3b5fc",
        storageBucket: "wathakren-3b5fc.appspot.com",
        messagingSenderId: "1071538625621",
        appId: "1:1071538625621:web:ea8128e53b907b6fc108dc",
        measurementId: "G-T8YYJCT5BQ"),
  );
  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //       channelKey: "Wathakren",
  //       channelName: "Wathakren",
  //       channelDescription: "Wathakren")
  // ]);
  sharedPreferences = await SharedPreferences.getInstance();
  int _freq = sharedPreferences!.getInt("frequency") ?? 2;
  Workmanager().initialize(_callbackDispatcher);
  Workmanager().registerPeriodicTask("athkarApp", "showAthkar",
      frequency: Duration(
        minutes: _freq == 2 ? 15 : 720 ~/ ((_freq + 1) * 10),
      ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.brown,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Provider.of<ThemeProvider>(context).kPrimary,
      title: 'Wathakren',
      locale: Locale("ar", "UA"),
      supportedLocales: [Locale("ar", "UA")],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        // colorSchemeSeed: Provider.of<ThemeProvider>(context).kPrimary,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Provider.of<ThemeProvider>(context).kPrimary,
            onPrimary: Provider.of<ThemeProvider>(context).kPrimary,
            secondary: Provider.of<ThemeProvider>(context).accentColor,
            onSecondary: Provider.of<ThemeProvider>(context).kPrimary,
            error: Provider.of<ThemeProvider>(context).kPrimary,
            onError: Provider.of<ThemeProvider>(context).accentColor,
            background: Colors.white,
            onBackground: Provider.of<ThemeProvider>(context).kPrimary,
            surface: Colors.white,
            onSurface: Provider.of<ThemeProvider>(context).kPrimary),
        fontFamily: 'Cairo',
        primarySwatch:
            MaterialColor(Provider.of<ThemeProvider>(context).kPrimary.value, {
          50: Provider.of<ThemeProvider>(context).kPrimary,
          100: Provider.of<ThemeProvider>(context).kPrimary,
          200: Provider.of<ThemeProvider>(context).kPrimary,
          300: Provider.of<ThemeProvider>(context).kPrimary,
          400: Provider.of<ThemeProvider>(context).kPrimary,
          500: Provider.of<ThemeProvider>(context).kPrimary,
          600: Provider.of<ThemeProvider>(context).kPrimary,
          700: Provider.of<ThemeProvider>(context).kPrimary,
          800: Provider.of<ThemeProvider>(context).kPrimary,
          900: Provider.of<ThemeProvider>(context).kPrimary,
        }),
      ),
      // home: MainScreen(key: GlobalKey<State<MainScreen>>()),
      home: !(sharedPreferences!.getBool("firstRunPassed") ?? false)
          ? CarouselPage1()
          : LoadContentScreen(),
      routes: {
        GeneralAthkar.day.route: (context) =>
            TimedAthkarPage(timedAthkar: GeneralAthkar.day),
        GeneralAthkar.night.route: (context) =>
            TimedAthkarPage(timedAthkar: GeneralAthkar.night),
        GeneralAthkar.wake.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.wake),
        GeneralAthkar.sleep.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.sleep),
        GeneralAthkar.azan.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.azan),
        GeneralAthkar.salat.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.salat),
        GeneralAthkar.afterSalat.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.afterSalat),
        GeneralAthkar.masjid.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.masjid),
        GeneralAthkar.wodoo.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.wodoo),
        GeneralAthkar.manzil.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.manzil),
        GeneralAthkar.taam.route: (context) =>
            GeneralAthkarChildPage(athkar: GeneralAthkar.taam),
      },
    );
  }
}

_callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    debugPrint("showNotification");
    // if (await AwesomeNotifications().isNotificationAllowed()) {
    //   AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 1337,
    //       channelKey: "Wathakren",
    //       title: "الورد اليومي",
    //       autoDismissible: true,
    //       body:
    //           "اللهم صل على سيدنا محمد و على آل سيدنا محمد كمان صليت على سيدنا إبراهيم و على آل سيدنا إبراهيم و بارك على سيدنا محمد و على آل سيدنا محمد كما باركت على سيدنا إبراهيم و على آل سيدنا إبراهيم.",
    //       locked: false,
    //       category: NotificationCategory.Reminder,
    //       notificationLayout: NotificationLayout.BigText,
    //       wakeUpScreen: true,
    //       fullScreenIntent: true,
    //       displayOnBackground: true,
    //       displayOnForeground: true,
    //       backgroundColor: Colors.white,
    //       color: Colors.brown,
    //     ),
    //   );
    // }
    return true;
  });
}
