import 'package:wathakren/consts.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/specific_athkar_page.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GeneralAthkarPage extends StatefulWidget {
  const GeneralAthkarPage({Key? key}) : super(key: key);

  @override
  State<GeneralAthkarPage> createState() => _GeneralAthkarPageState();
}

class _GeneralAthkarPageState extends State<GeneralAthkarPage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var athkarCats = (jsonData["categories"] as List<dynamic>)
        .where((element) => isGeneralAthkar(element["data"]["title"] ?? "NaN"))
        .map((e) => e)
        .toList();
    // var athkarCats = (jsonData["stories"] as List<dynamic>).where((element) =>
    //     athkarCatIds.contains(element["data"]["catID"].toString()));
    return Scaffold(
      appBar: AppBar(
        shape: customRoundedRectangleBorder,
        backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
        leading: SizedBox(
            //width: 32,
            ),
        automaticallyImplyLeading: false,
        title: Text(
          "أذكار متنوعة",
          // overflow: TextOverflow.visible,
        ),
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 32,
        actions: [
          //mod - + not
          SizedBox(width: 32),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/moon.svg",
                color: Provider.of<ThemeProvider>(context).kPrimary,
              ),
              visualDensity: VisualDensity.compact),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove),
              visualDensity: VisualDensity.compact),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              visualDensity: VisualDensity.compact),

          SizedBox(width: 32),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_forward),
              visualDensity: VisualDensity.compact)
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              vertical: _size.width / 10, horizontal: _size.width / 10),
          child: Column(
            children: athkarCats
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: CustomOutlinedButton(
                        filled: true,
                        text: e["data"]["title"],
                        fillColor: Provider.of<ThemeProvider>(context).kPrimary,
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    SpecificAthkarPage(category: e))),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  bool isGeneralAthkar(String title) {
    if (title == GeneralAthkar.day.name || title == GeneralAthkar.night.name) {
      return false;
    } else if (title == "أسماء الله الحسنى" || title == "النعم") {
      return false;
    }
    return true;
  }
}
