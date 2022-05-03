import 'package:wathakren/consts.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TimedAthkarPage extends StatefulWidget {
  final GeneralAthkar timedAthkar;

  const TimedAthkarPage({Key? key, required this.timedAthkar})
      : super(key: key);

  @override
  State<TimedAthkarPage> createState() => _TimedAthkarPageState();
}

class _TimedAthkarPageState extends State<TimedAthkarPage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var athkarCatId = (jsonData["categories"] as List<dynamic>).firstWhere(
            (element) =>
                element["data"]["title"] == widget.timedAthkar.name)["id"]
        as String;
    var athkar = (jsonData["stories"] as List<dynamic>)
        .where((element) => element["data"]["catID"] == athkarCatId);
    return Scaffold(
      appBar: AppBar(
        shape: customRoundedRectangleBorder,
        backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
        title: Text(
          widget.timedAthkar.name,
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
              onPressed: () {},
              icon: Icon(Icons.add),
              visualDensity: VisualDensity.compact),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove),
              visualDensity: VisualDensity.compact),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/notifications.svg",
                color: Provider.of<ThemeProvider>(context).kPrimary,
              ),
              visualDensity: VisualDensity.compact),
          // SizedBox(width: 32),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_forward),
              visualDensity: VisualDensity.compact)
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: _size.width / 10, horizontal: _size.width / 10),
          child: Column(
            children: athkar
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(bottom: _size.width * .1),
                    child: TitledBox(
                      inverted: true,
                      titleContained: true,
                      child: TitledBoxBody(
                        size: _size,
                        children: [
                          Text(
                            e["data"]["content"] ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Provider.of<ThemeProvider>(context)
                                    .kPrimary),
                            textAlign: TextAlign.center,
                          )
                        ],
                        inverted: true,
                      ),
                      width: _size.width * .8,
                      title: e["data"]["repeat"],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
