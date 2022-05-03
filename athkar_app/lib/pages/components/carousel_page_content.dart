import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/load_content_screen.dart';
import 'package:wathakren/pages/components/pager_dot.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CarouselPageContent extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final int length;
  final int index;
  final Widget? next;
  const CarouselPageContent({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.length,
    required this.index,
    this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) async {
        double dx = details.velocity.pixelsPerSecond.dx;
        double dy = details.velocity.pixelsPerSecond.dy;
        if (dx == 0 || dy.abs() > dx.abs()) {
          return;
        } else if (dx > 0) {
          bool _isLast = index == length - 1 && next == null;
          if (!_isLast) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => next!));
          }
        } else {
          if (index > 0) {
            Navigator.pop(context);
          }
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .05),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .77,
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Provider.of<ThemeProvider>(context)
                                .accentColor
                                .withOpacity(.0),
                            Provider.of<ThemeProvider>(context)
                                .accentColor
                                .withOpacity(.25)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      border: Border.all(
                          width: 1,
                          color:
                              Provider.of<ThemeProvider>(context).accentColor),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(75)),
                    ),
                    height: MediaQuery.of(context).size.height * .73,
                    child: Column(
                      children: [
                        Spacer(flex: 3),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Hero(
                                tag: "WelcomeLogo",
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  width:
                                      MediaQuery.of(context).size.width * .42,
                                ))),
                        Spacer(flex: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            text1,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(flex: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            text2,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(flex: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            text3,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(flex: 3),
                        Row(),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    child: Row(),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Hero(
              tag: "WelcomeDot",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: {for (int i = 0; i < length; i++) i}
                    .map((e) => PagerDot(active: e == index))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            index == length - 1
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10),
                    child: CustomOutlinedButton(
                      filled: true,
                      text: "متابعة",
                      ontap: () {
                        sharedPreferences!.setBool("firstRunPassed", true);
                        pushLoad(context);
                      },
                    ),
                  )
                : Container(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void pushLoad(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoadContentScreen()),
        (route) => route.toString() == "/LoadContentScreen");
  }
}
