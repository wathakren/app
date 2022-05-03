import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/pages/components/cuts.dart';
import 'package:wathakren/pages/tasbih_page.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TasbihBox extends StatefulWidget {
  final Size size;
  const TasbihBox({Key? key, required this.size}) : super(key: key);

  @override
  State<TasbihBox> createState() => _TasbihBoxState();
}

class _TasbihBoxState extends State<TasbihBox> {
  @override
  Widget build(BuildContext context) {
    return TitledBox(
      child: TitledBoxBody(
        size: widget.size,
        children: [
          SizedBox(
            //color: Colors.red,
            width: widget.size.width / 3,
            height: widget.size.width / 3,
            child: Trycut(
                child: Text("أستغفر الله",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                width: widget.size.width / 3),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TasbihPage())),
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
      title: "التسبيح",
    );
  }
}
