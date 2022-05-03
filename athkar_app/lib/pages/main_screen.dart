//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/custom_nav_bar.dart';
import 'package:wathakren/pages/tabs/bookmark_tab.dart';
import 'package:wathakren/pages/tabs/edit_tab.dart';
import 'package:wathakren/pages/tabs/main_tab.dart';
import 'package:wathakren/pages/tabs/share_tab.dart';
import 'package:wathakren/providers/settings_provider.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  //final GlobalKey<State<EditTab>> editTabKey = GlobalKey<State<EditTab>>();
  final GlobalKey<State<BottomNavigationBar>> botNavBarKey =
      GlobalKey<State<BottomNavigationBar>>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Rebuilding1111");
    Size _size = MediaQuery.of(context).size;
    checkPermession();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _selectedIndex == 3
          ? AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
              title: Text("أذكاري اليومية"),
              centerTitle: false,
            )
          : null,
      bottomNavigationBar: CustomNavBar(
        botNavBarKey: botNavBarKey,
        mainKey: widget.key as GlobalKey<State<MainScreen>>,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: pageSelector(size: _size)),
            adBanner(_size),
          ],
        ),
      ),
    );
  }

  void reAnimate(int x) {
    debugPrint("FFFFFFFFFFFFFFFF");
    setState(() {
      _selectedIndex = x;
    });
  }

  int selectedIndex() {
    return _selectedIndex;
  }

  Widget pageSelector({required Size size}) {
    switch (_selectedIndex) {
      case 1:
        return EditTab();
      case 2:
        // return Container();
        return ShareTab();
      case 3:
        // return Container();
        return BookmarkTab();

      default:
        //return Container();
        return MainTab(size: size);
    }
  }

  void checkPermession() async {
    // var p = await AwesomeNotifications().isNotificationAllowed();
    // if (!p) {
    //   await AwesomeNotifications().requestPermissionToSendNotifications();
    // }
  }

  bool isAthkar(String title) {
    if (title == "أسماء الله الحسنى" || title == "النعم") {
      return false;
    }
    return true;
  }

  Widget adBanner(Size _size) {
    var mAdWidget = AdWidget(
        ad: BannerAd(
            size: AdSize(
                width: _size.width.toInt(),
                height: (_size.height * .1).toInt()),
            adUnitId: "ca-app-pub-3940256099942544/6300978111",
            listener: BannerAdListener(),
            request: AdRequest()));
    mAdWidget.ad.load();
    return SizedBox(
      width: _size.width,
      height: _size.height * .1,
      child: FutureBuilder(
          future: mAdWidget.ad.load(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? mAdWidget
                : CircularProgressIndicator();
          }),
    );
  }
}
