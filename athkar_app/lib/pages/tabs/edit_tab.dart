import 'package:wathakren/main.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/pages/edit_custom_thekr_pae.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTab extends StatefulWidget {
  const EditTab({Key? key}) : super(key: key);

  @override
  State<EditTab> createState() => EditTabState();
}

class EditTabState extends State<EditTab> {
  int _selectedAthkar = 1;

  List<Map<String, String>>? athkarList;
  List<String>? mAthkarList;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: AppBar().preferredSize.height,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: _size.width / 3,
              child: CustomOutlinedButton(
                  filled: true,
                  fillColor: Provider.of<ThemeProvider>(context)
                      .kPrimary
                      .withOpacity(_selectedAthkar == 0 ? 1 : .3),
                  text: "أذكار التطبيق",
                  ontap: () {
                    setState(() {
                      _selectedAthkar = 0;
                    });
                  }),
            ),
            SizedBox(
              width: _size.width / 3,
              child: CustomOutlinedButton(
                  filled: true,
                  fillColor: Provider.of<ThemeProvider>(context)
                      .kPrimary
                      .withOpacity(_selectedAthkar == 1 ? 1 : .3),
                  text: "أذكاري",
                  ontap: () {
                    setState(() {
                      _selectedAthkar = 1;
                    });
                  }),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _selectedAthkar == 0
                ? "اختر الاذكار التي ستظهر على الشاشة"
                : "بامكانك اضافة ادعية خاصة بك لتظهر على الشاشة",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.grey),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            //fit: StackFit.expand,
            children: [
              FutureBuilder(
                future: _getSelectedAthkar(_selectedAthkar),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ]);
                  } else if (_selectedAthkarLength(_selectedAthkar) != 0) {
                    return SingleChildScrollView(
                      child: Column(
                        children: _selectedAthkar == 0
                            ? _builtinAthkar(width: _size.width)
                            : _customAthkar(width: _size.width),
                      ),
                    );
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("لم تقم بأضافة أذكار")]);
                  }
                },
              ),
              _selectedAthkar == 0
                  ? SizedBox()
                  : Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            addCustomAthkar();
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  _builtinAthkar({required double width}) {
    return athkarList!
        .map((e) => Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * .1, vertical: 16),
              child: TitledBox(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: width / 10,
                          height: width / 10,
                        ),
                        SizedBox(
                          width: width / 2,
                          child: Text(
                            "data data data data data data data data data data data data data data ",
                          ),
                        ),
                        Spacer(),
                        Icon(
                          e["showing"] == "true"
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Provider.of<ThemeProvider>(context).kPrimary,
                        ),
                        SizedBox(
                          width: width / 10,
                          height: width / 10,
                        ),
                      ],
                    ),
                  ),
                ),
                width: width,
                filled: e["showing"] == "true",
              ),
            ))
        .toList();
  }

  _customAthkar({required double width}) {
    return mAthkarList!
        .map((e) => Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * .1, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  //color: Provider.of<ThemeProvider>(context).kPrimary,
                  border: Border.all(
                      width: 1,
                      color: Provider.of<ThemeProvider>(context).kPrimary),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //color: Provider.of<ThemeProvider>(context).kPrimary,
                        border: Border.all(
                            width: 1,
                            color:
                                Provider.of<ThemeProvider>(context).kPrimary),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(49),
                            topLeft: Radius.circular(49)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert,
                                color: Provider.of<ThemeProvider>(context)
                                    .kPrimary,
                              )),
                          Spacer(flex: 2),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(e),
                          ),
                          Spacer(flex: 3)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Spacer(flex: 1),
                          IconButton(
                              onPressed: () {
                                addCustomAthkar(e);
                              },
                              icon: Icon(
                                Icons.edit_note,
                                color: Provider.of<ThemeProvider>(context)
                                    .kPrimary,
                              )),
                          Spacer(flex: 8),
                          IconButton(
                              onPressed: () {
                                var old = sharedPreferences!
                                        .getStringList("customAthkar") ??
                                    [];
                                old.removeWhere((element) => element == e);
                                sharedPreferences!
                                    .setStringList("customAthkar", old);
                                setState(() {
                                  mAthkarList = null;
                                });
                              },
                              icon: Icon(
                                Icons.delete_outlined,
                                color: Provider.of<ThemeProvider>(context)
                                    .kPrimary,
                              )),
                          Spacer(flex: 1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }

  Future<void> _getSelectedAthkar(int selectedAthkar) async {
    if (selectedAthkar == 0 && athkarList == null) {
      athkarList = [];
    } else if (selectedAthkar == 1 && mAthkarList == null) {
      mAthkarList = sharedPreferences?.getStringList("customAthkar") ?? [];
      setState(() {});
    }
    return;
  }

  addCustomAthkar([String? thekr]) async {
    String? singleThekr = await Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => EditCustomThekr(
              text: thekr,
            )));
    if (singleThekr != null && singleThekr.isNotEmpty) {
      mAthkarList!.removeWhere((element) => element == thekr);
      mAthkarList!.add(singleThekr);
      sharedPreferences?.setStringList("customAthkar", mAthkarList!);
    }
  }

  _selectedAthkarLength(int selectedAthkar) {
    return selectedAthkar == 0
        ? (athkarList ?? []).length
        : (mAthkarList ?? []).length;
  }
}
