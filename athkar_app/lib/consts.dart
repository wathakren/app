import 'package:flutter/material.dart';

String googlePlayLink = "asd";
String appStoreLink = "asd";

String appShareMEssage() {
  return "وَالذَّاكِرِينَ اللَّهَ كَثِيرًا وَالذَّاكِرَاتِ أَعَدَّ اللَّهُ لَهُم مَّغْفِرَةً وَأَجْرًا عَظِيمًا\nتحميل تطبيق و الذاكرين يساعدك على المواظبه على أذكارك و التسبيح و ميزات اخرى\nلتحميل التطبيق من App Store على الرابط:\n$appStoreLink\nلتحميل التطبيق من Google Play على الرابط:\n$googlePlayLink";
}

RoundedRectangleBorder customRoundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: appBarBorderRadiusGeometry(),
);

BorderRadius appBarBorderRadiusGeometry() {
  return BorderRadius.only(
    bottomLeft: Radius.circular(.33 * appBarHeight()),
    bottomRight: Radius.circular(.33 * appBarHeight()),
  );
}

double appBarHeight() => AppBar().preferredSize.height;

enum GeneralAthkar {
  day,
  night,
  wake,
  sleep,
  azan,
  salat,
  afterSalat,
  masjid,
  wodoo,
  manzil,
  taam
}

extension AthcarInfo on GeneralAthkar {
  String get name {
    return [
      "أذكار الصباح",
      "أذكار المساء",
      "أذكار الإستيقاظ",
      "أذكار النوم",
      "أذكار الآذان",
      "أذكار الصلاة",
      "أذكار بعد الصلاة",
      "أذكار المسجد",
      "أذكار الوضوء",
      "أذكار المنزل",
      "أذكار الطعام",
    ][index];
  }

  String get route {
    return [
      "day",
      "night",
      "wake",
      "sleep",
      "azan",
      "salat",
      "afterSalat",
      "masjid",
      "wodoo",
      "manzil",
      "taam"
    ][index];
  }
}
