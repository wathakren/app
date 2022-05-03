import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wathakren/consts.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/components/titled_box_body.dart';
import 'package:wathakren/providers/theme_provider.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: customRoundedRectangleBorder,
        backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
        automaticallyImplyLeading: false,
        leading: SizedBox(width: 16),
        title: Text("الحاسبة"),
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 32,
        actions: [
          SizedBox(width: 32),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_forward),
              visualDensity: VisualDensity.compact)
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(),
          TitledBox(
              title: "عدد التسبيحات",
              filled: true,
              child: TitledBoxBody(
                size: Size(_size.width, _size.height / 2),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: _size.width / 6, child: Text("اليوم")),
                      SizedBox(width: _size.width / 6, child: Text(_today())),
                      IconButton(
                        onPressed: () {
                          var ts = DateTime.now();
                          var old =
                              sharedPreferences!.getStringList("tasbihCount") ??
                                  [];
                          old.removeWhere((element) => element
                              .contains("${ts.year}:${ts.month}:${ts.day}"));
                          sharedPreferences!.setStringList("tasbihCount", old);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: _size.width / 6, child: Text("الشهر")),
                      SizedBox(
                          width: _size.width / 6, child: Text(_thisMonth())),
                      IconButton(
                        onPressed: () {
                          var ts = DateTime.now();
                          var old =
                              sharedPreferences!.getStringList("tasbihCount") ??
                                  [];
                          old.removeWhere((element) => element
                              .contains("${ts.year}:${ts.month}:${ts.day}"));
                          sharedPreferences!.setStringList("tasbihCount", old);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: _size.width / 6, child: Text("السنة")),
                      SizedBox(
                          width: _size.width / 6, child: Text(_thisYear())),
                      IconButton(
                        onPressed: () {
                          var ts = DateTime.now();
                          var old =
                              sharedPreferences!.getStringList("tasbihCount") ??
                                  [];
                          old.removeWhere((element) => element
                              .contains("${ts.year}:${ts.month}:${ts.day}"));
                          sharedPreferences!.setStringList("tasbihCount", old);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: _size.width / 6, child: Text("المجموع")),
                      SizedBox(width: _size.width / 6, child: Text(_all())),
                      IconButton(
                        onPressed: () {
                          var ts = DateTime.now();
                          var old =
                              sharedPreferences!.getStringList("tasbihCount") ??
                                  [];
                          old.removeWhere((element) => element
                              .contains("${ts.year}:${ts.month}:${ts.day}"));
                          sharedPreferences!.setStringList("tasbihCount", old);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              width: _size.width * .8),
          Row(),
          Row(),
        ],
      ),
    );
  }

  String _today() {
    var all = sharedPreferences!.getStringList("tasbihCount") ?? [];
    var ts = DateTime.now();
    all.removeWhere((element) =>
        element.contains("${ts.year}:${ts.month}:${ts.day}") == false);
    var count = 0;
    for (var element in all) {
      var c = int.tryParse(element.split(":").last) ?? 0;
      count += c;
    }
    return count.toString();
  }

  String _thisMonth() {
    var all = sharedPreferences!.getStringList("tasbihCount") ?? [];
    var ts = DateTime.now();
    all.removeWhere(
        (element) => element.contains("${ts.year}:${ts.month}") == false);
    var count = 0;
    for (var element in all) {
      var c = int.tryParse(element.split(":").last) ?? 0;
      count += c;
    }
    return count.toString();
  }

  String _thisYear() {
    var all = sharedPreferences!.getStringList("tasbihCount") ?? [];
    var ts = DateTime.now();
    all.removeWhere((element) => element.contains("${ts.year}") == false);
    var count = 0;
    for (var element in all) {
      var c = int.tryParse(element.split(":").last) ?? 0;
      count += c;
    }
    return count.toString();
  }

  String _all() {
    var all = sharedPreferences!.getStringList("tasbihCount") ?? [];
    var count = 0;
    for (var element in all) {
      var c = int.tryParse(element.split(":").last) ?? 0;
      count += c;
    }
    return count.toString();
  }
}
