import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ColorSelectPage extends StatefulWidget {
  const ColorSelectPage({Key? key}) : super(key: key);

  @override
  State<ColorSelectPage> createState() => _ColorSelectPageState();
}

class _ColorSelectPageState extends State<ColorSelectPage> {
  final List<Map<String, Color>> _themes = [
    {
      "_appBarColor": Color(0xFFE9E5D6),
      "_kPrimary": Color(0xFF464E2E),
      "_accentColor": Color(0xFFACB992),
      "_textColor": Color(0xFF282018),
      "_elevationColor": Color(0xFFACB992).withOpacity(.5),
    },
    {
      "_appBarColor": Color(0xFFF4DFBA),
      "_kPrimary": Colors.brown,
      "_accentColor": Color(0xFFEEC373),
      "_textColor": Color(0xFF282018),
      "_elevationColor": Color(0xFFCA965C).withOpacity(.1),
    },
    {
      "_appBarColor": Color(0xFF00AFC1),
      "_kPrimary": Color(0xFF006778),
      "_accentColor": Color(0xFFFFD124),
      "_textColor": Color(0xFF282018),
      "_elevationColor": Color(0xFFFFD124).withOpacity(.1),
    }
  ];

  int _showingTheme = 0;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          //clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: _themes[_showingTheme]["_appBarColor"],
                  border: Border.all(
                      color: _themes[_showingTheme]["_appBarColor"]!),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(_width),
                      bottomRight: Radius.circular(_width)),
                ),
                width: _width,
                height: _width / 2,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        "assets/icons/color.svg",
                        color: Provider.of<ThemeProvider>(context).kPrimary,
                      ),
                    ),
                    Text(
                      "تغيير لون التطبيق",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_forward))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("إختر لون التطبيق الذي يناسبك")]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Spacer(flex: 3),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => setState(() {
                          _showingTheme < _themes.length - 1
                              ? _showingTheme++
                              : null;
                        }),
                      ),
                      Spacer(flex: 1),
                      Text(
                        "الشكل الجديد",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: _themes[_showingTheme]["_kPrimary"]),
                      ),
                      Spacer(flex: 1),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () => setState(() {
                          _showingTheme > 0 ? _showingTheme-- : null;
                        }),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: _width * .7,
                    maxHeight: MediaQuery.of(context).size.height * .57),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          TitledBox(
                              color: _themes[_showingTheme]["_kPrimary"],
                              fillColor: Theme.of(context).canvasColor,
                              title: "      ",
                              child: TitledBoxBody(
                                size: MediaQuery.of(context).size,
                                children: [
                                  SizedBox(
                                    height: 28,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomElevatedButton(
                                          color: _themes[_showingTheme]
                                              ["_accentColor"],
                                          text: "            ",
                                          ontap: () {}),
                                      CustomOutlinedButton(
                                        color: _themes[_showingTheme]
                                            ["_kPrimary"],
                                        text: "            ",
                                        ontap: () {},
                                      ),
                                      CustomOutlinedButton(
                                          color: _themes[_showingTheme]
                                              ["_kPrimary"],
                                          text: "            ",
                                          ontap: () {}),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 28,
                                  ),
                                ],
                              ),
                              width: _width * .7),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //SizedBox(height: _width * .15),
                          CustomOutlinedButton(
                              text: "",
                              ontap: () {},
                              filled: true,
                              color: _themes[_showingTheme]["_kPrimary"]),
                          SizedBox(height: 16),
                          CustomOutlinedButton(
                              text: "",
                              ontap: () {},
                              filled: true,
                              color: _themes[_showingTheme]["_kPrimary"]),
                          SizedBox(height: 16),
                          CustomOutlinedButton(
                              text: "",
                              ontap: () {},
                              filled: true,
                              color: _themes[_showingTheme]["_kPrimary"]),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: TitledBox(
                          color: _themes[_showingTheme]["_kPrimary"],
                          fillColor: Theme.of(context).canvasColor,
                          title: "      ",
                          child: TitledBoxBody(
                            size: MediaQuery.of(context).size,
                            children: [
                              SizedBox(
                                height: _width * .1,
                              ),
                              Row(
                                children: [
                                  Spacer(flex: 5),
                                  SvgPicture.asset("assets/icons/refresh.svg",
                                      color: _themes[_showingTheme]
                                          ["_kPrimary"]),
                                  Spacer(flex: 1),
                                  SvgPicture.asset("assets/icons/goto.svg",
                                      color: _themes[_showingTheme]
                                          ["_kPrimary"]),
                                  Spacer(flex: 5),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          width: _width * .7),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomOutlinedButton(
                        childCentered: true,
                        text: "      إختار      ",
                        ontap: () =>
                            Provider.of<ThemeProvider>(context, listen: false)
                                .setTheme(colors: _themes[_showingTheme]),
                        filled: true,
                      ),
                      SizedBox(
                        height: _width * .23,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
