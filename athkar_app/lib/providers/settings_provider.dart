import 'package:wathakren/main.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  int frequency = 2;
  bool vibrateOnTap = true;
  bool soundOnTap = true;
  String dayAthkarTime = "5:00";
  String nightAthkarTime = "16:00";
  bool canShowOverlay = true;
  bool autoHide = true;
  bool canShowNotifications = true;
  bool vibrateOnReading = true;
  bool selfReading = true;
  String overlayFont = "Cairo";
  double overlayFontScale = 1;
  int overlayColor = 0xFF876445;
  List<String> myList = [];

  SettingsProvider() {
    _loadSettings();
  }

  _loadSettings() async {
    int loadedFrequency = sharedPreferences?.getInt("frequency") ?? 2;
    bool loadedVibrateOnTap =
        sharedPreferences?.getBool("vibrateOnTap") ?? true;
    bool loadedSoundOnTap = sharedPreferences?.getBool("soundOnTap") ?? true;
    String loadedDayAthkarTime =
        sharedPreferences?.getString("dayAthkarTime") ?? "5:00";
    String loadedNightAthkarTime =
        sharedPreferences?.getString("nightAthkarTime") ?? "16:00";
    bool loadedCanShowOverlay =
        sharedPreferences?.getBool("canShowOverlay") ?? true;
    bool loadedAutoHide = sharedPreferences?.getBool("autoHide") ?? true;
    bool loadedCanShowNotifications =
        sharedPreferences?.getBool("canShowNotifications") ?? true;
    bool loadedVibrateOnReading =
        sharedPreferences?.getBool("vibrateOnReading") ?? true;
    bool loadedSelfReading = sharedPreferences?.getBool("selfReading") ?? true;
    List<String> loadedMyList =
        sharedPreferences?.getStringList("myList") ?? [];
    setFrequency(loadedFrequency, save: false);
    setVibrateOnTap(loadedVibrateOnTap, save: false);
    setSoundOnTap(loadedSoundOnTap, save: false);
    setDayAthkarTime(loadedDayAthkarTime, save: false);
    setNightAthkarTime(loadedNightAthkarTime, save: false);
    setCanShowOverlay(loadedCanShowOverlay, save: false);
    setAutoHide(loadedAutoHide, save: false);
    setCanShowNotifications(loadedCanShowNotifications, save: false);
    setVibrateOnReading(loadedVibrateOnReading, save: false);
    setSelfReading(loadedSelfReading, save: false);
    setMyList(loadedMyList, save: false);
  }

  setFrequency(int loadedFrequency, {bool save = true}) {
    //TODO ReInit Overlayer/Notification
    frequency = loadedFrequency;
    save ? sharedPreferences?.setInt("frequency", loadedFrequency) : null;
    notifyListeners();
  }

  void setVibrateOnTap(bool loadedVibrateOnTap, {bool save = true}) {
    vibrateOnTap = loadedVibrateOnTap;
    save
        ? sharedPreferences?.setBool("vibrateOnTap", loadedVibrateOnTap)
        : null;
    notifyListeners();
  }

  void setSoundOnTap(bool loadedSoundOnTap, {bool save = true}) {
    soundOnTap = loadedSoundOnTap;
    save ? sharedPreferences?.setBool("soundOnTap", loadedSoundOnTap) : null;
    notifyListeners();
  }

  void setDayAthkarTime(String loadedDayAthkarTime, {bool save = true}) {
    dayAthkarTime = loadedDayAthkarTime;
    save
        ? sharedPreferences?.setString("dayAthkarTime", loadedDayAthkarTime)
        : null;
    notifyListeners();
  }

  void setNightAthkarTime(String loadedNightAthkarTime, {bool save = true}) {
    nightAthkarTime = loadedNightAthkarTime;
    save
        ? sharedPreferences?.setString("nightAthkarTime", loadedNightAthkarTime)
        : null;
    notifyListeners();
  }

  void setCanShowOverlay(bool loadedCanShowOverlay, {bool save = true}) {
    canShowOverlay = loadedCanShowOverlay;
    save
        ? sharedPreferences?.setBool("showOverlay", loadedCanShowOverlay)
        : null;
    notifyListeners();
  }

  void setAutoHide(bool loadedAutoHide, {bool save = true}) {
    autoHide = loadedAutoHide;
    save ? sharedPreferences?.setBool("autoHide", loadedAutoHide) : null;
    notifyListeners();
  }

  void setCanShowNotifications(bool loadedCanShowNotifications,
      {bool save = true}) {
    canShowNotifications = loadedCanShowNotifications;
    save
        ? sharedPreferences?.setBool(
            "canShowNotifications", loadedCanShowNotifications)
        : null;
    notifyListeners();
  }

  void setVibrateOnReading(bool loadedVibrateOnReading, {bool save = true}) {
    vibrateOnReading = loadedVibrateOnReading;
    save
        ? sharedPreferences?.setBool("vibrateOnReading", loadedVibrateOnReading)
        : null;
    notifyListeners();
  }

  void setSelfReading(bool loadedSelfReading, {bool save = true}) {
    selfReading = loadedSelfReading;
    save ? sharedPreferences?.setBool("selfReading", loadedSelfReading) : null;
    notifyListeners();
  }

  void setOverlayFont(String loadedOverlayFont, {bool save = true}) {
    overlayFont = loadedOverlayFont;
    save
        ? sharedPreferences?.setString("overlayFont", loadedOverlayFont)
        : null;
    notifyListeners();
  }

  void setOverlayFontScale(double loadedOverlayFontScale, {bool save = true}) {
    overlayFontScale = loadedOverlayFontScale;
    save
        ? sharedPreferences?.setDouble("selectedFont", loadedOverlayFontScale)
        : null;
    notifyListeners();
  }

  void setOverlayColor(int loadedOverlayColor, {bool save = true}) {
    overlayColor = loadedOverlayColor;
    save ? sharedPreferences?.setInt("selectedFont", loadedOverlayColor) : null;
    notifyListeners();
  }

  void setMyList(List<String> loadedMyList, {bool save = true}) {
    myList = loadedMyList;
    save ? sharedPreferences?.setStringList("myList", myList) : null;
    notifyListeners();
  }

  void addToMyList(String toAdd) {
    if (myList.contains(toAdd)) {
      return;
    } else {
      myList.add(toAdd);
      setMyList(myList);
    }
  }

  void removeFromMyList(String toRemove) {
    if (!myList.contains(toRemove)) {
      return;
    } else {
      myList.removeWhere((element) => element == toRemove);
      setMyList(myList);
    }
  }
}
