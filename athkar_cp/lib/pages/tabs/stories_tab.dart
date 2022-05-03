import 'package:athkar_cp/providers/reading_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:athkar_cp/controllers/firebase_api.dart';
import 'package:athkar_cp/pages/components/appbar.dart';
import 'package:athkar_cp/pages/components/drawer_listview.dart';
import 'package:athkar_cp/pages/components/flex_sidebar.dart';
import 'package:athkar_cp/pages/components/func.dart';
import 'package:athkar_cp/pages/tabs/edit_story_tab.dart';
import 'package:athkar_cp/pages/tabs/preview_page.dart';
import 'package:provider/provider.dart';

class StoriesTab extends StatefulWidget {
  static String routeName = "/StoriesTab";

  const StoriesTab({Key? key}) : super(key: key);

  @override
  State<StoriesTab> createState() => _StoriesTabState();
}

class _StoriesTabState extends State<StoriesTab> {
  late bool isProtrait;

  String _searchValue = "";
  @override
  Widget build(BuildContext context) {
    isProtrait = isPortrait(context: context);
    double x = (MediaQuery.of(context).size.width - 250) / 5;
    double y = MediaQuery.of(context).size.height / 7;
    x = x < y ? y : x;
    return Scaffold(
      drawer: isProtrait
          ? Drawer(
              child: MyDrawerListView(drawer: true),
              //backgroundColor: Colors.grey[800],
            )
          : null,
      appBar: MyAppBar(
        //appBar: AppBar(),
        title: "العناصر",
      ),
      body: SafeArea(
        child: FlexSideBar(
          isProtrait: isProtrait,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8))),
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          String? catID = await selectCatID();
                          if (catID == null) {
                            return;
                          }
                          Navigator.pushNamed(context, EditStoryTab.routeName,
                              arguments: {"catID": catID}).then((value) {
                            setState(() {});
                          });
                        },
                        label: Text(
                          "جديد",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          hintText: "بحث",
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseAPI.fetchStories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data == null) {
                      return Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red[700],
                          ),
                          Text(
                            "حدث خطأ اثناء التصال بقاعدة البيانات",
                            style: TextStyle(color: Colors.red[700]),
                          )
                        ],
                      ));
                    } else {
                      var mList = snapshot.data as List<Map<String, String>>;
                      return mList.isEmpty
                          ? Center(
                              child: Text("لم تقم بأضافة عناصر"),
                            )
                          : SingleChildScrollView(
                              controller: ScrollController(),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                  children: mList
                                      .where((element) =>
                                          element["catID"] ==
                                              Provider.of<Reading>(context)
                                                  .catID ||
                                          Provider.of<Reading>(context).catID ==
                                              null)
                                      .where((element) => element["title"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(_searchValue.toLowerCase()))
                                      .map((e) => mCard(
                                            catID: e["catID"] ?? "",
                                            id: e["id"] ?? "",
                                            title: e["title"] ?? "",
                                            subtitle: e["description"],
                                            document: e["content"],
                                            repeat: e["repeat"] ?? "1",
                                            width: x,
                                            height: y,
                                          ))
                                      .toList()),
                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mCard({
    required String id,
    required String catID,
    required String title,
    String? subtitle,
    String? document,
    required double width,
    required double height,
    required String repeat,
  }) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.amber,
                      ),
                ),
                Text(
                  subtitle ?? "",
                  //softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "التكرار: $repeat",
                  style: Theme.of(context).textTheme.caption,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            SizedBox(width: 32),
            Expanded(
              child: Text(
                document ?? "",
                style: Theme.of(context).textTheme.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.pushNamed(context, PreviewPage.routeName,
                        arguments: document);
                  },
                  child: Padding(
                    padding:
                        isProtrait ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
                    child: Icon(Icons.phone_iphone, color: Colors.amber),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(EditStoryTab.routeName, arguments: {
                      "id": id,
                      "catID": catID,
                      "title": title,
                      "subtitle": subtitle,
                      "document": document,
                      "repeat": repeat
                    }).then((value) {
                      setState(() {});
                    });
                  },
                  child: Padding(
                    padding:
                        isProtrait ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
                    child: Icon(Icons.edit, color: Colors.amber),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () async {
                    bool? confirmation = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text("حذف العنصر, لا يمكن التراجع!"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text("موافق")),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("رجوع")),
                        ],
                      ),
                    );
                    if (confirmation != true) {
                      return;
                    }
                    await FirebaseFirestore.instance
                        .collection("stories")
                        .doc(id)
                        .delete();
                    setState(() {});
                  },
                  child: Padding(
                    padding:
                        isProtrait ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
                    child: Icon(Icons.delete, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Row(
      //       children: [
      //         Container(
      //           width: 50,
      //           height: 50,
      //           child:
      // Column(
      //             children: [
      //               Text(
      //                 title,
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
      //                       color: Colors.amber,
      //                     ),
      //               ),
      //               Text(
      //                 subtitle ?? "",
      //                 //softWrap: true,
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //                 style: Theme.of(context).textTheme.caption,
      //               ),
      //               Text(
      //                 "التكرار: $repeat",
      //                 style: Theme.of(context).textTheme.caption,
      //               )
      //             ],
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //           ),
      //         ),
      //         SizedBox(
      //           width: 48,
      //         ),
      //         Container(
      //           child: Text(
      //             document ?? "",
      //             style: Theme.of(context).textTheme.caption,
      //             //maxLines: 2,
      //             overflow: TextOverflow.fade,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         InkWell(
      //           borderRadius: BorderRadius.circular(100),
      //           onTap: () {
      //             Navigator.pushNamed(context, PreviewPage.routeName,
      //                 arguments: document);
      //           },
      //           child: Padding(
      //             padding:
      //                 isProtrait ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
      //             child: Icon(Icons.phone_iphone, color: Colors.amber),
      //           ),
      //         ),
      //         InkWell(
      //           borderRadius: BorderRadius.circular(100),
      //           onTap: () {
      //             Navigator.of(context)
      //                 .pushNamed(EditStoryTab.routeName, arguments: {
      //               "id": id,
      //               "catID": catID,
      //               "title": title,
      //               "subtitle": subtitle,
      //               "document": document,
      //               "repeat": repeat
      //             }).then((value) {
      //               setState(() {});
      //             });
      //           },
      //           child: Padding(
      //             padding:
      //                 isProtrait ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
      //             child: Icon(Icons.edit, color: Colors.amber),
      //           ),
      //         ),
      //         InkWell(
      //           borderRadius: BorderRadius.circular(100),
      //           onTap: () async {
      //             bool? confirmation = await showDialog(
      //               context: context,
      //               builder: (context) => AlertDialog(
      //                 content: Text("حذف العنصر, لا يمكن التراجع!"),
      //                 actions: [
      //                   TextButton(
      //                       onPressed: () => Navigator.pop(context, true),
      //                       child: Text("موافق")),
      //                   TextButton(
      //                       onPressed: () => Navigator.pop(context),
      //                       child: Text("رجوع")),
      //                 ],
      //               ),
      //             );
      //             if (confirmation != true) {
      //               return;
      //             }
      //             await FirebaseFirestore.instance
      //                 .collection("stories")
      //                 .doc(id)
      //                 .delete();
      //             setState(() {});
      //           },
      //           child: Padding(
      //             padding:
      //                 isProtrait ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
      //             child: Icon(Icons.delete, color: Colors.amber),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  Future<String?> selectCatID() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: FutureBuilder(
          future: FirebaseAPI.fetchCats(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data == null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text("لا يمكن العثور على أجزاء"),
                  ),
                ],
              );
            } else {
              List<Map<String, String>> mList =
                  snapshot.data as List<Map<String, String>>;
              return mList.isEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text("لم تقم بأضافة أقسام بعد"),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: mList
                            .map((e) => ListTile(
                                  title: Text(e["title"].toString()),
                                  onTap: () {
                                    Navigator.pop(context, e["id"]);
                                  },
                                ))
                            .toList(),
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
