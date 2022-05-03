import 'package:wathakren/consts.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/components/cuts.dart';
import 'package:wathakren/pages/summary_page.dart';
import 'package:wathakren/providers/settings_provider.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TasbihPage extends StatefulWidget {
  const TasbihPage({Key? key}) : super(key: key);

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  int tVar = 0;
  int miniCount = 0;
  int max = 100;
  int count = 0;
  List<String> tList = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
  ];
  double _multi = 1;
  double _sliderValue = 1;
  late bool _vibrationOn;
  late TextStyle? tStyle;
  late bool _soundsOn;
  int? soundID;
  BetterSoundEffect soundEffect = BetterSoundEffect();

  @override
  void initState() {
    Future.microtask(() async {
      soundID = await soundEffect.loadAssetAudioFile("assets/sounds/click.mp3");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    tStyle = Theme.of(context).textTheme.headline6;
    BoxShadow bShadow = BoxShadow(
        blurRadius: 4, spreadRadius: 4, color: Colors.grey.withOpacity(.2));
    _vibrationOn = Provider.of<SettingsProvider>(context).vibrateOnTap;
    _soundsOn = Provider.of<SettingsProvider>(context).soundOnTap;

    return WillPopScope(
      onWillPop: () async {
        addtoTodayCount(count);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          shape: customRoundedRectangleBorder,
          backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
          automaticallyImplyLeading: false,
          leading: SizedBox(width: 16),
          title: Text("تسبيح"
              // overflow: TextOverflow.visible,
              ),
          centerTitle: false,
          titleSpacing: 0,
          leadingWidth: 32,
          actions: [
            //mod - + not
            //SizedBox(width: 32),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/moon.svg",
                  color: Provider.of<ThemeProvider>(context).kPrimary,
                ),
                visualDensity: VisualDensity.compact),
            IconButton(
                onPressed: () {
                  tVar++;
                  if (tVar == 4) {
                    tVar = 0;
                  }
                  addtoTodayCount(count);
                  count = 0;
                  miniCount = 0;
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  "assets/icons/toggle.svg",
                  color: Provider.of<ThemeProvider>(context).kPrimary,
                ),
                visualDensity: VisualDensity.compact),
            IconButton(
                onPressed: _toggleSound,
                icon: SvgPicture.asset(
                  "assets/icons/speaker.svg",
                  color: Provider.of<ThemeProvider>(context).kPrimary,
                ),
                visualDensity: VisualDensity.compact),
            IconButton(
                onPressed: _toggleVibration,
                icon: SvgPicture.asset(
                  "assets/icons/vibration.svg",
                  color: Provider.of<ThemeProvider>(context).kPrimary,
                ),
                visualDensity: VisualDensity.compact),
            SizedBox(width: 32),
            IconButton(
                onPressed: () {
                  addtoTodayCount(count);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_forward),
                visualDensity: VisualDensity.compact)
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(_width * .1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width / 6),
                  child: CustomOutlinedButton(
                    text: "إبدأ",
                    ontap: () {
                      addtoTodayCount(count);
                      setState(() {
                        count = 0;
                        miniCount = 0;
                      });
                    },
                    boldness: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  //color: Colors.red,
                  width: _width * .7,
                  height: _width * .7,
                  child: tVar == 0
                      ? SingleCut(
                          width: _width * .7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("التكرار", style: tStyle),
                              Text(max.toString(), style: tStyle),
                            ],
                          ),
                        )
                      : tVar == 1
                          ? BiCut(
                              vals: [
                                miniCount.isEven && count > 0,
                                miniCount.isOdd || count == max
                              ],
                              width: _width * .7,
                              child: GestureDetector(
                                onPanDown: _panDown,
                                onTapUp: _tapUp,
                                child: Container(
                                  width: _multi * _width / 2.3,
                                  height: _multi * _width / 2.3,
                                  decoration: BoxDecoration(
                                    boxShadow: [bShadow],
                                    borderRadius: BorderRadius.circular(_width),
                                    color: Provider.of<ThemeProvider>(context)
                                        .appBarColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      miniCount.isEven
                                          ? "سبحان الله\nو بحمده"
                                          : "سبحان الله\nالعظيم",
                                      style: tStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : tVar == 2
                              ? TriCut(
                                  val: count == max ? 3 : miniCount,
                                  width: _width * .7,
                                  child: GestureDetector(
                                    onPanDown: _panDown,
                                    onTapUp: _tapUp,
                                    child: Container(
                                      width: _multi * _width / 2.3,
                                      height: _multi * _width / 2.3,
                                      decoration: BoxDecoration(
                                        boxShadow: [bShadow],
                                        borderRadius:
                                            BorderRadius.circular(_width),
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                .appBarColor,
                                      ),
                                      child: Center(
                                          child: Text(tList[miniCount],
                                              style: tStyle)),
                                    ),
                                  ),
                                )
                              : SingleCut(
                                  cVal: count == max,
                                  width: _width * .7,
                                  child: GestureDetector(
                                    onPanDown: _panDown,
                                    onTapUp: _tapUp,
                                    child: Container(
                                      width: _multi * _width / 2.3,
                                      height: _multi * _width / 2.3,
                                      decoration: BoxDecoration(
                                        boxShadow: [bShadow],
                                        borderRadius:
                                            BorderRadius.circular(_width),
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                .appBarColor,
                                      ),
                                      child: Center(
                                        child:
                                            Text("أستغفر الله", style: tStyle),
                                      ),
                                    ),
                                  ),
                                ),
                ),
                Text(tVar > 0 ? "مجموع التسبيحات" : "التكرار",
                    style: Theme.of(context).textTheme.headline6),
                tVar == 0
                    ? Container()
                    : Text((count).toString().split(".").first,
                        style: Theme.of(context).textTheme.headline6),
                tVar > 0
                    ? Container()
                    : Slider(
                        value: _sliderValue * 100,
                        max: 100,
                        min: 1,
                        divisions: 100,
                        label: max.toString(),
                        onChanged: (double value) {
                          setState(() {
                            max = value.round();
                            _sliderValue = value / 100;
                          });
                        },
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width / 10),
                  child: CustomOutlinedButton(
                    text: "الحاسبة",
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SummaryPage()));
                    },
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tasbih1Progress() {
    if (tVar == 0 || count == max) {
      return;
    }

    if (tVar == 1) {
      if (miniCount.isOdd) {
        miniCount = 0;
        count++;
      } else {
        miniCount++;
      }
    } else if (tVar == 2) {
      if (miniCount == 3) {
        miniCount = 0;
        count++;
      } else {
        miniCount++;
      }
    } else {
      count++;
    }
    setState(() {});
  }

  void _panDown(DragDownDetails details) {
    if (count == max) {
      return;
    }
    _vibrationOn ? HapticFeedback.lightImpact() : null;
    _soundsOn ? _playSound() : null;
    setState(() {
      _multi = 1.2;
    });
  }

  void _tapUp(TapUpDetails details) {
    if (count == max) {
      return;
    }
    _tasbih1Progress();
    setState(() {
      _multi = 1;
    });
  }

  void _toggleVibration() {
    Provider.of<SettingsProvider>(context, listen: false)
        .setVibrateOnTap(!_vibrationOn);
  }

  void _toggleSound() {
    Provider.of<SettingsProvider>(context, listen: false)
        .setSoundOnTap(!_soundsOn);
  }

  _playSound() async {
    soundEffect.play(soundID!);
  }

  void addtoTodayCount(int count) {
    var ts = DateTime.now();
    var tasbihCount = sharedPreferences!.getStringList("tasbihCount") ?? [];
    var todayCount = tasbihCount.isEmpty
        ? "0"
        : tasbihCount
            .firstWhere((element) =>
                element.contains("${ts.year}:${ts.month}:${ts.day}"))
            .split(":")
            .last;

    var cInt = int.tryParse(todayCount) ?? 0;
    cInt += count;
    tasbihCount.removeWhere(
        (element) => element.contains("${ts.year}:${ts.month}:${ts.day}"));
    tasbihCount.add("${ts.year}:${ts.month}:${ts.day}:$cInt");
    sharedPreferences!.setStringList("tasbihCount", tasbihCount);
  }
}
