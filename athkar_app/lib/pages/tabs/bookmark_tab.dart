import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/specific_athkar_page.dart';
import 'package:wathakren/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkTab extends StatelessWidget {
  const BookmarkTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final athkarCats = (jsonData["categories"] as List<dynamic>)
        .where((element) => isAthkar(element["data"]["title"] ?? "NaN"))
        .map((e) => e)
        .toList();
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: Provider.of<SettingsProvider>(context)
                .myList
                .map((e) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: _size.width / 20,
                          horizontal: _size.width / 8),
                      child: CustomOutlinedButton(
                          filled: true,
                          text: e,
                          ontap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SpecificAthkarPage(
                                      category: athkarCats.firstWhere(
                                          (element) =>
                                              element["data"]["title"] == e)))),
                          onLongPress: () => _remove(e, context)),
                    ))
                .toList(),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                addToBookmark(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  _remove(String e, BuildContext context) {
    Provider.of<SettingsProvider>(context, listen: false).removeFromMyList(e);
  }

  bool isAthkar(String title) {
    if (title == "أسماء الله الحسنى" || title == "النعم") {
      return false;
    }
    return true;
  }

  void addToBookmark(BuildContext context) async {
    final athkarCats = (jsonData["categories"] as List<dynamic>)
        .where((element) => isAthkar(element["data"]["title"] ?? "NaN"))
        .map((e) => e)
        .toList();
    if (athkarCats
        .where((element) =>
            !Provider.of<SettingsProvider>(context, listen: false)
                .myList
                .contains(element["data"]["title"] ?? "NaN"))
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // elevation: 0,
          // backgroundColor: Colors.transparent,
          content: Text(
        "لقد قمت بإضافة كل الأذكار مسبقاً",
        style: TextStyle(
            //color: Colors.red[700],
            fontFamily: "Cairo",
            fontSize: 21,
            fontWeight: FontWeight.bold),
      )));
      return;
    }
    String? toAdd = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: athkarCats
                    .where((element) =>
                        !Provider.of<SettingsProvider>(context, listen: false)
                            .myList
                            .contains(element["data"]["title"]))
                    .map((e) => ListTile(
                          title: Text(e["data"]["title"] ?? "NaN"),
                          onTap: () =>
                              Navigator.pop(context, e["data"]["title"]),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
    if (toAdd == null) {
      return;
    } else {
      Provider.of<SettingsProvider>(context, listen: false).addToMyList(toAdd);
    }
  }
}
