import 'package:wathakren/pages/components/carousel_page_content.dart';
import 'package:flutter/material.dart';

class CarouselPage2 extends StatefulWidget {
  const CarouselPage2({Key? key}) : super(key: key);

  @override
  State<CarouselPage2> createState() => _CarouselPage2State();
}

class _CarouselPage2State extends State<CarouselPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CarouselPageContent(
      text1: "تنسى أذكارك اليومية ؟",
      text2: "بعد الآن لن تنساها",
      text3:
          "تطبيق يذكرك بأذكارك اليومية ومتاح لكل الأوقات مع كل مايلزمك من تسبيح وذكر...",
      length: 2,
      index: 1,
    ));
  }
}
