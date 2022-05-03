import 'package:wathakren/pages/components/carousel_page_content.dart';
import 'package:wathakren/pages/pager_view/caroussel_page2.dart';
import 'package:flutter/material.dart';

class CarouselPage1 extends StatefulWidget {
  const CarouselPage1({Key? key}) : super(key: key);

  @override
  State<CarouselPage1> createState() => _CarouselPage1State();
}

class _CarouselPage1State extends State<CarouselPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CarouselPageContent(
      text1: "إجعل قلبك مطمئن بذكر الله",
      text2:
          "“وَالذَّاكِرِينَ اللَّهَ كَثِيرًا وَالذَّاكِرَاتِ أَعَدَّ اللَّهُ لَهُمْ مَغْفِرَةً وَأَجْرًا عَظِيمًا”",
      text3:
          "“الَذِينَ آمَنُواْ وَتَطْمَئِنُ قُلُوبُهُم بِذِكْرِ اللَهِ أَلاَ بِذِكْرِ اللَهِ تَطْمَئِنُ الْقُلُوبُ”",
      length: 2,
      index: 0,
      next: CarouselPage2(),
    ));
  }
}
