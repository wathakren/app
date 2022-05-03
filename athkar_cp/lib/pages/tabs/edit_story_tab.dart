import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:athkar_cp/controllers/firebase_api.dart';
import 'package:athkar_cp/pages/components/appbar.dart';
import 'package:athkar_cp/pages/components/func.dart';

class EditStoryTab extends StatefulWidget {
  static String routeName = "/StoriesTab/EditStoryTab";

  const EditStoryTab({Key? key}) : super(key: key);

  @override
  State<EditStoryTab> createState() => _EditStoryTabState();
}

class _EditStoryTabState extends State<EditStoryTab> {
  late bool isProtrait;

  late DateTime _publishAt;

  late TextEditingController _title;
  late TextEditingController _description;
  late TextEditingController _content;
  String? _error;
  late Map<String, String?> args;

  late TextEditingController _repeat;

  @override
  Widget build(BuildContext context) {
    isProtrait = isPortrait(context: context);

//////////////////////

    try {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    } catch (e) {
      debugPrint(e.toString());
      args = {};
    }

    try {
      _publishAt =
          DateTime.fromMillisecondsSinceEpoch(int.parse(args["id"] ?? ""));

      _title = TextEditingController(text: args["title"]);

      _description = TextEditingController(text: args["subtitle"]);

      _content = TextEditingController(
        text: args["document"],
      );
      _repeat = TextEditingController(text: args["repeat"]);
    } catch (e) {
      debugPrint(e.toString());
      _publishAt = DateTime.now();
      _title = TextEditingController();
      _description = TextEditingController();
      _content = TextEditingController();
      _repeat = TextEditingController();
    }

////////////////

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        //appBar: AppBar(),
        title: "تحرير عنصر",
      ),
      body: SafeArea(
        child: args["catID"] == null || args["catID"] == ""
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("خطأ: لم تقم بإختيار قسم."),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("رجوع"))
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _title,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "العنوان: ",
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        controller: _content,
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "النص: ",
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _repeat,
                      maxLength: 3,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "التكرار: ",
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _description,
                      maxLines: 2,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "الوصف: ",
                          floatingLabelBehavior: FloatingLabelBehavior.always),
                    ),
                    SizedBox(height: 8),
                    _error != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red[700],
                                ),
                                Text(
                                  _error!,
                                  style: TextStyle(color: Colors.red[700]),
                                )
                              ])
                        : SizedBox(),
                    SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          editStory();
                        },
                        child: Text("نشر")),
                  ],
                ),
              ),
      ),
    );
  }

  editStory() async {
    if (_title.text.isEmpty) {
      setState(() {
        _error = "العنوان مطلوب";
      });
      return;
    }

    String? result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              content: FutureBuilder(
                future: FirebaseAPI.editStory(
                    id: args["id"] ??
                        DateTime.now().millisecondsSinceEpoch.toString(),
                    content: _content.text,
                    title: _title.text,
                    description: _description.text,
                    catID: args["catID"] ?? "",
                    repeat: _repeat.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    Navigator.of(context).pop(snapshot.data);
                    return Container();
                  }
                },
              ),
            ));
    if (result != null) {
      setState(() {
        _error = "حدث خطأ أثناء الإتصال بقاعدة البيانات";
      });
    } else {
      Navigator.pop(context);
    }
  }
}
