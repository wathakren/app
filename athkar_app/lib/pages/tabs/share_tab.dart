import 'dart:convert';
import 'dart:io';

import 'package:wathakren/consts.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShareTab extends StatelessWidget {
  const ShareTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _appBarHeight = AppBar().preferredSize.height;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: (_size.width / 2) + _appBarHeight,
          backgroundColor: Theme.of(context).canvasColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: [
                Container(
                  height: _appBarHeight,
                  width: _size.width,
                  color: Provider.of<ThemeProvider>(context).appBarColor,
                ),
                Container(
                  height: _size.width / 2,
                  width: _size.width,
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).appBarColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.elliptical(_size.width, _size.width / 2),
                      bottomRight:
                          Radius.elliptical(_size.width, _size.width / 2),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _size.width / 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "صدقة جارية",
                          style: TextStyle(
                              fontSize: 28,
                              color:
                                  Provider.of<ThemeProvider>(context).kPrimary),
                        ),
                        Text(
                          "شارك التطبيق مع من تعرف وخذ ثواب وأجر صدقة جارية خاصة بك! بحيث يتناقله آلاف الناس من بعدك!",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Image.asset(
            "assets/images/logo.png",
            height: _appBarHeight - 8,
            fit: BoxFit.fitHeight,
          ),
          actions: [
            Icon(Icons.share),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: _appBarHeight / 2, horizontal: _appBarHeight),
            height: _size.height - (_size.width + _appBarHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  leadingSpace: _appBarHeight / 2,
                  text: "شارك مع واتساب",
                  icon: Image.asset(
                    "assets/icons/whatsapp.png",
                    height: 24,
                    fit: BoxFit.fitHeight,
                  ),
                  ontap: () => _whatsappShare(context),
                ),
                CustomElevatedButton(
                  leadingSpace: _appBarHeight / 2,
                  text: "شارك مع فيسبوك",
                  icon: Image.asset(
                    "assets/icons/facebook.png",
                    height: 24,
                    fit: BoxFit.fitHeight,
                  ),
                  ontap: _allShare,
                ),
                CustomElevatedButton(
                  leadingSpace: _appBarHeight / 2,
                  text: "شارك مع تويتر",
                  icon: Image.asset(
                    "assets/icons/twitter.png",
                    height: 24,
                    fit: BoxFit.fitHeight,
                  ),
                  ontap: _twitterShare,
                ),
                CustomElevatedButton(
                  leadingSpace: _appBarHeight / 2,
                  text: "نسخ الرابط للمشاركة",
                  icon: Image.asset(
                    "assets/icons/copylink.png",
                    height: 24,
                    fit: BoxFit.fitHeight,
                  ),
                  ontap: () => _copyLinkShare(context),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _whatsappShare(BuildContext context) async {
    var url = whatsappUrl();
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("لا يمكن العثور على التطبيق!")));
    }
  }

  String whatsappUrl() {
    String x = appShareMEssage();
    if (Platform.isAndroid) {
      return "whatsapp://send/?text=$x";
    } else {
      return "whatsapp://send?text=$x";
    }
  }

  _twitterShare() async {
    String x = appShareMEssage();
    var tweet = "https://twitter.com/intent/tweet?text=$x";
    if (await canLaunchUrlString(tweet)) {
      launchUrlString(tweet);
    } else {
      debugPrint(utf8.decode(base64.decode("Q2FuJ3QgTGF1bmNo")));
    }
  }

  _allShare() async {
    String x = appShareMEssage();
    Share.share(x);
  }

  _copyLinkShare(BuildContext context) {
    var x = appShareMEssage();
    Clipboard.setData(ClipboardData(text: x));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "تم النسخ",
        style: TextStyle(
            color: Provider.of<ThemeProvider>(context, listen: false).kPrimary,
            fontSize: 21,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo"),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
