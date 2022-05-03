import 'dart:math';

import 'package:wathakren/main.dart';
import 'package:wathakren/pages/asmaa_page.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AsmaaBox extends StatefulWidget {
  final Size size;

  const AsmaaBox({Key? key, required this.size}) : super(key: key);

  @override
  State<AsmaaBox> createState() => _AsmaaBoxState();
}

class _AsmaaBoxState extends State<AsmaaBox> {
  int? index;
  @override
  Widget build(BuildContext context) {
    var asmaCatId = (jsonData["categories"] as List<dynamic>).firstWhere(
            (element) => element["data"]["title"] == "أسماء الله الحسنى")["id"]
        as String;
    var asmaa = (jsonData["stories"] as List<dynamic>)
        .where((element) => element["data"]["catID"] == asmaCatId);

    index = index ?? Random().nextInt(asmaa.length - 1);
    return TitledBox(
      child: TitledBoxBody(
        size: widget.size,
        children: [
          Text(asmaa.elementAt(index ?? 1)["data"]["title"] ?? "",
              style: TextStyle(
                  //fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Provider.of<ThemeProvider>(context).accentColor)),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () => setState(() {
                  index = Random().nextInt(asmaa.length - 1);
                }),
                icon: SvgPicture.asset(
                  "assets/icons/refresh.svg",
                  color: Provider.of<ThemeProvider>(context).kPrimary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AsmaaPage(ind: index!)))
                    .then((value) => setState(() {
                          index = value;
                        })),
                icon: SvgPicture.asset(
                  "assets/icons/goto.svg",
                  color: Provider.of<ThemeProvider>(context).kPrimary,
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
      width: widget.size.width * .8,
      title: "أسماء الله الحسنى",
    );
  }
}
