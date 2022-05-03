//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:wathakren/consts.dart';
import 'package:wathakren/pages/color_select_page.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/pages/contact_us_page.dart';
import 'package:wathakren/providers/settings_provider.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool _canShowOverlay =
        Provider.of<SettingsProvider>(context).canShowOverlay;
    bool _autoHide = Provider.of<SettingsProvider>(context).autoHide;
    bool _canShowNotifications =
        Provider.of<SettingsProvider>(context).canShowNotifications;
    bool _vibrateOnReading =
        Provider.of<SettingsProvider>(context).vibrateOnReading;
    bool _selfReading = Provider.of<SettingsProvider>(context).selfReading;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shape: customRoundedRectangleBorder,
        backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
        automaticallyImplyLeading: false,
        title: Text("الإعدادات"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CustomOutlinedButton(
                  text: "موعد التنبيهات لأذكار الصباح",
                  ontap: _setDayAthkarTime,
                  childCentered: false,
                  icon: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            Provider.of<SettingsProvider>(context)
                                .dayAthkarTime,
                            textScaleFactor: .8,
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .accentColor),
                          ),
                          SizedBox(
                            height: 4,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8),
                        child: SvgPicture.asset(
                          "assets/icons/goto.svg",
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                      )
                    ],
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "موعد التنبيهات لأذكار المساء",
                  ontap: _setNightAthkarTime,
                  childCentered: false,
                  icon: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            Provider.of<SettingsProvider>(context)
                                .nightAthkarTime,
                            textScaleFactor: .8,
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                    .accentColor),
                          ),
                          SizedBox(
                            height: 4,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8),
                        child: SvgPicture.asset(
                          "assets/icons/goto.svg",
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                      )
                    ],
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "إيقاف الأذكار الظاهرة على الشاشة",
                  ontap: () => _toggleCanShowOverlay(!_canShowOverlay),
                  childCentered: false,
                  icon: Switch(
                    value: _canShowOverlay,
                    onChanged: _toggleCanShowOverlay,
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "الإختفاء التلقائي",
                  subText: "تختفي الأذكار تلقائياً بعج 15 ثانية",
                  ontap: () => _toggleAutoHide(!_autoHide),
                  childCentered: false,
                  icon: Switch(value: _autoHide, onChanged: _toggleAutoHide),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تفعيل التنبيهات",
                  ontap: () =>
                      _toggleCanShowNotifications(!_canShowNotifications),
                  childCentered: false,
                  icon: Switch(
                      value: _canShowNotifications,
                      onChanged: _toggleCanShowNotifications),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تفعيل الإهتزاز عند القراءة",
                  ontap: () => _toggleVibrateOnReading(!_vibrateOnReading),
                  childCentered: false,
                  icon: Switch(
                      value: _vibrateOnReading,
                      onChanged: _toggleVibrateOnReading),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تفعيل القراءة الذاتية",
                  subText: "إظهار لون أحمر عند ظهور الأذكار",
                  ontap: () => _toggleSelfReading(!_selfReading),
                  childCentered: false,
                  icon: Switch(
                      value: _selfReading, onChanged: _toggleSelfReading),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تغيير لون التطبيق",
                  ontap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ColorSelectPage())),
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تغيير نوع الخط",
                  ontap: _selectFont,
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تغيير حجم الخط",
                  ontap: _selectFontSize,
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تغيير لون الأذكار الظاهرة على الشاشة",
                  ontap: _selectOverlayColor,
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "إزالة الإعلانات و دعم التطبيق",
                  ontap: () async {
                    // if (await AwesomeNotifications().isNotificationAllowed()) {
                    //   Future.delayed(Duration(seconds: 2), () {
                    //     AwesomeNotifications().createNotification(
                    //       content: NotificationContent(
                    //         id: 1337,
                    //         channelKey: "Wathakren",
                    //         title: "الورد اليومي",
                    //         autoDismissible: true,
                    //         body:
                    //             "اللهم صل على سيدنا محمد و على آل سيدنا محمد كمان صليت على سيدنا إبراهيم و على آل سيدنا إبراهيم و بارك على سيدنا محمد و على آل سيدنا محمد كما باركت على سيدنا إبراهيم و على آل سيدنا إبراهيم.",
                    //         locked: false,
                    //         category: NotificationCategory.Reminder,
                    //         notificationLayout: NotificationLayout.BigText,
                    //         wakeUpScreen: true,
                    //         fullScreenIntent: true,
                    //         displayOnBackground: true,
                    //         displayOnForeground: true,
                    //         backgroundColor: Colors.white,
                    //         color: Colors.brown,
                    //       ),
                    //     );
                    //   });
                    // }
                  },
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تقييم التطبيق",
                  ontap: () {},
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  text: "تواصل معنا",
                  ontap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ContactUsPage())),
                  childCentered: false,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: SvgPicture.asset(
                      "assets/icons/goto.svg",
                      color: Provider.of<ThemeProvider>(context).kPrimary,
                    ),
                  ),
                  boldness: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setDayAthkarTime() async {
    TimeOfDay? selectedDayTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(
                Provider.of<SettingsProvider>(context, listen: false)
                    .dayAthkarTime
                    .split(":")
                    .first),
            minute: int.parse(
                Provider.of<SettingsProvider>(context, listen: false)
                    .dayAthkarTime
                    .split(":")
                    .last)));
    selectedDayTime != null
        ? Provider.of<SettingsProvider>(context, listen: false).setDayAthkarTime(
            "${selectedDayTime.hour}:${selectedDayTime.minute > 9 ? selectedDayTime.minute : '0' + selectedDayTime.minute.toString()}")
        : null;
  }

  _setNightAthkarTime() async {
    TimeOfDay? selectedNightTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(
                Provider.of<SettingsProvider>(context, listen: false)
                    .nightAthkarTime
                    .split(":")
                    .first),
            minute: int.parse(
                Provider.of<SettingsProvider>(context, listen: false)
                    .nightAthkarTime
                    .split(":")
                    .last)));
    selectedNightTime != null
        ? Provider.of<SettingsProvider>(context, listen: false).setNightAthkarTime(
            "${selectedNightTime.hour}:${selectedNightTime.minute > 9 ? selectedNightTime.minute : '0' + selectedNightTime.minute.toString()}")
        : null;
  }

  void _toggleCanShowOverlay(bool value) {
    Provider.of<SettingsProvider>(context, listen: false)
        .setCanShowOverlay(value);
  }

  void _toggleAutoHide(bool value) {
    Provider.of<SettingsProvider>(context, listen: false).setAutoHide(value);
  }

  void _toggleCanShowNotifications(bool value) {
    Provider.of<SettingsProvider>(context, listen: false)
        .setCanShowNotifications(value);
  }

  void _toggleVibrateOnReading(bool value) {
    Provider.of<SettingsProvider>(context, listen: false)
        .setVibrateOnReading(value);
  }

  void _toggleSelfReading(bool value) {
    Provider.of<SettingsProvider>(context, listen: false).setSelfReading(value);
  }

  _selectFont() async {
    String? selectedFont = await showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              content: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitledBox(
                      filled: true,
                      fillColor: Colors.white,
                      title: "تغيير نوع الخط للأذكار الظاهرة على الشاشة",
                      fontSize: 11,
                      width: MediaQuery.of(context).size.width * .7,
                      child: TitledBoxBody(
                        size: MediaQuery.of(context).size,
                        children: [
                          CustomOutlinedButton(
                              text: "سبحان الله و بحمده",
                              boldness: FontWeight.bold,
                              fontFamily: "Dubai",
                              ontap: () => Navigator.of(context).pop("Dubai")),
                          SizedBox(height: 16),
                          CustomOutlinedButton(
                              text: "سبحان الله و بحمده",
                              boldness: FontWeight.bold,
                              fontFamily: "Cairo",
                              ontap: () => Navigator.of(context).pop("Cairo")),
                          SizedBox(height: 16),
                          CustomOutlinedButton(
                              text: "سبحان الله و بحمده",
                              boldness: FontWeight.bold,
                              fontFamily: "Kufi",
                              ontap: () => Navigator.of(context).pop("Kufi")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
    if (selectedFont == null) {
      return;
    } else {
      Provider.of<SettingsProvider>(context, listen: false)
          .setOverlayFont(selectedFont);
    }
  }

  _selectFontSize() async {
    double? selectedFontScale = await showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitledBox(
                    filled: true,
                    fillColor: Colors.white,
                    title: "تغيير حجم الأذكار الظاهرة على الشاشة",
                    fontSize: 16,
                    width: MediaQuery.of(context).size.width * .7,
                    child: TitledBoxBody(
                      size: MediaQuery.of(context).size,
                      children: [
                        CustomOutlinedButton(
                            text: "سبحان الله و بحمده",
                            boldness: FontWeight.bold,
                            fontFamily: Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .overlayFont,
                            ontap: () => Navigator.of(context).pop(1)),
                        SizedBox(height: 16),
                        MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.2),
                          child: CustomOutlinedButton(
                              text: "سبحان الله و بحمده",
                              boldness: FontWeight.bold,
                              fontFamily: Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .overlayFont,
                              ontap: () => Navigator.of(context).pop(1.2)),
                        ),
                        SizedBox(height: 16),
                        MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.5),
                          child: CustomOutlinedButton(
                              text: "سبحان الله و بحمده",
                              boldness: FontWeight.bold,
                              fontFamily: Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .overlayFont,
                              ontap: () => Navigator.of(context).pop(1.5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
    if (selectedFontScale == null) {
      return;
    } else {
      Provider.of<SettingsProvider>(context, listen: false)
          .setOverlayFontScale(selectedFontScale);
    }
  }

  _selectOverlayColor() async {
    int? selectedOverlayColor = await showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitledBox(
                    filled: true,
                    fillColor: Colors.white,
                    title: "تغيير لون الأذكار الظاهرة على الشاشة",
                    fontSize: 16,
                    width: MediaQuery.of(context).size.width * .7,
                    child: TitledBoxBody(
                      size: MediaQuery.of(context).size,
                      children: [
                        CustomOutlinedButton(
                            color: Color(0xFF255B43),
                            text: "سبحان الله و بحمده",
                            boldness: FontWeight.bold,
                            fontFamily: Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .overlayFont,
                            ontap: () => Navigator.of(context).pop(0x255B43)),
                        SizedBox(height: 16),
                        CustomOutlinedButton(
                            color: Color(0xFF876445),
                            text: "سبحان الله و بحمده",
                            boldness: FontWeight.bold,
                            fontFamily: Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .overlayFont,
                            ontap: () => Navigator.of(context).pop(0x876445)),
                        SizedBox(height: 16),
                        CustomOutlinedButton(
                            color: Color(0xFFF79E1B),
                            text: "سبحان الله و بحمده",
                            boldness: FontWeight.bold,
                            fontFamily: Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .overlayFont,
                            ontap: () => Navigator.of(context).pop(0xF79E1B)),
                      ],
                    ),
                  ),
                ],
              ),
            ));
    if (selectedOverlayColor == null) {
      return;
    } else {
      Provider.of<SettingsProvider>(context, listen: false)
          .setOverlayColor(selectedOverlayColor);
    }
  }
}
