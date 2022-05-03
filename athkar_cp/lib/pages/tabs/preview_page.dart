import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:athkar_cp/pages/components/func.dart';

class PreviewPage extends StatefulWidget {
  static String routeName = "/PreviewPage";

  const PreviewPage({Key? key}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late String? doc;

  late TextEditingController _mController;
  @override
  Widget build(BuildContext context) {
    _mController = TextEditingController(
        text: ModalRoute.of(context)?.settings.arguments as String);
    var maxHeight =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height - 10;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text("معاينة")),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            constraints: isPortrait(context: context)
                ? null
                : BoxConstraints(maxHeight: maxHeight, maxWidth: maxHeight / 2),
            child: TextField(
              maxLines: 100,
              controller: _mController,
            ),
          ),
        ),
      ),
    );
  }
}
