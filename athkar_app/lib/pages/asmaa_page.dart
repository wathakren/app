import 'dart:math';

import 'package:wathakren/consts.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AsmaaPage extends StatefulWidget {
  final int ind;
  const AsmaaPage({Key? key, required this.ind}) : super(key: key);

  @override
  State<AsmaaPage> createState() => _AsmaaPageState();
}

class _AsmaaPageState extends State<AsmaaPage> {
  late int index;

  bool _refreshed = false;
  @override
  Widget build(BuildContext context) {
    var asmaCatId = (jsonData["categories"] as List<dynamic>).firstWhere(
            (element) => element["data"]["title"] == "أسماء الله الحسنى")["id"]
        as String;
    var asmaa = (jsonData["stories"] as List<dynamic>)
        .where((element) => element["data"]["catID"] == asmaCatId);
    index = _refreshed ? index : widget.ind;
    return Scaffold(
      appBar: AppBar(
        shape: customRoundedRectangleBorder,
        backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
        automaticallyImplyLeading: false,
        leading: SizedBox(),
        title: Text(
          "أسماء الله الحسنى",
          // overflow: TextOverflow.visible,
        ),
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 32,
        actions: [
          //mod - + not
          SizedBox(width: 32),
          IconButton(
            onPressed: () => setState(() {
              _refreshed = true;
              index = Random().nextInt(98);
            }),
            icon: SvgPicture.asset(
              "assets/icons/refresh.svg",
              color: Provider.of<ThemeProvider>(context).kPrimary,
            ),
          ),

          SizedBox(width: 32),
          IconButton(
              onPressed: () => Navigator.pop(context, index),
              icon: Icon(Icons.arrow_forward),
              visualDensity: VisualDensity.compact)
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(32),
          child: Center(
            child: TitledBox(
                title: asmaa.elementAt(index)["data"]["title"] ?? "",
                filled: true,
                color: Provider.of<ThemeProvider>(context).accentColor,
                child:
                    TitledBoxBody(size: MediaQuery.of(context).size, children: [
                  Text(
                    asmaa.elementAt(index)["data"]["content"] ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
                width: MediaQuery.of(context).size.width * .8),
          ),
        ),
      ),
    );
  }
}
