import 'package:wathakren/consts.dart';
import 'package:wathakren/controllers/hijri.dart';
import 'package:wathakren/pages/components/asmaa_box.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/components/frequency_controller.dart';
import 'package:wathakren/pages/components/niam_box.dart';
import 'package:wathakren/pages/components/tasbih_box.dart';
import 'package:wathakren/pages/general_athkar_page.dart';
import 'package:wathakren/pages/settings_page.dart';
import 'package:wathakren/pages/timed_athkar_page.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

class MainTab extends StatelessWidget {
  const MainTab({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          pinned: true,
          stretch: true,
          shape: customRoundedRectangleBorder,
          backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
          leading: IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SettingsPage())),
            icon: Icon(Icons.settings_outlined),
          ),
          expandedHeight: (_size.width / 2) + 8,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            expandedTitleScale: 1.2,
            title: Padding(
              padding: EdgeInsets.only(bottom: appBarHeight() * .7),
              child: Text(
                //"6 رمضان 1443",
                Hijri().formatter(HijriDateTime.now()),
                style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).kPrimary),
              ),
            ),
            centerTitle: true,
            background: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  Container(
                      height: _size.width / 2,
                      width: _size.width,
                      decoration: BoxDecoration(
                        color: Provider.of<ThemeProvider>(context)
                            .appBarColor
                            .withOpacity(.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(_size.width),
                          bottomRight: Radius.circular(_size.width),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: appBarHeight()),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: _size.width * .22,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )),
                  SizedBox(height: 8)
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              FrequencyBox(size: _size),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width / 10),
                child: CustomOutlinedButton(
                  text: "أذكار الصباح",
                  ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TimedAthkarPage(
                          timedAthkar: GeneralAthkar.day,
                        ),
                      )),
                  filled: true,
                  icon: Image.asset("assets/images/day.png"),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width / 10),
                child: CustomOutlinedButton(
                  text: "أذكار المساء",
                  ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TimedAthkarPage(
                          timedAthkar: GeneralAthkar.night,
                        ),
                      )),
                  filled: true,
                  icon: Image.asset("assets/images/night.png"),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width / 10),
                child: CustomOutlinedButton(
                  text: "أذكار متنوعة",
                  ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GeneralAthkarPage(),
                      )),
                  filled: true,
                  icon: Image.asset("assets/images/hands.png"),
                ),
              ),
              SizedBox(height: 24),
              AsmaaBox(
                size: _size,
              ),
              SizedBox(height: 24),
              TasbihBox(size: _size),
              SizedBox(height: 24),
              NiamBox(size: _size),
              SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
