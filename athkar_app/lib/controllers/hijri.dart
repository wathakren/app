// ignore_for_file: file_names

import 'package:syncfusion_flutter_core/core.dart';

class Hijri {
  String formatter(HijriDateTime dateTime) {
    return "${dateTime.day} ${_name(dateTime.month)} ${dateTime.year}";
  }

  _name(int month) {
    return [
      "المحرم",
      "صفر",
      "ربيع الأول",
      "ربيع الثاني",
      "جمادى الأولى",
      "جمادى الآخرة",
      "رجب",
      "شعبان",
      "رمضان",
      "شوال",
      "ذو القعدة",
      "ذو الحجة",
    ][month - 1];
  }
}
