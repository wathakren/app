import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wathakren/main.dart';
import 'package:wathakren/pages/main_screen.dart';

class LoadContentScreen extends StatefulWidget {
  const LoadContentScreen({Key? key}) : super(key: key);

  @override
  State<LoadContentScreen> createState() => _LoadContentScreenState();
}

class _LoadContentScreenState extends State<LoadContentScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadDAta(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return loading(context);
        } else if (!(snapshot.data as bool)) {
          return failed(context);
        } else {
          return MainScreen(key: GlobalKey<State<MainScreen>>());
        }
      },
    );
  }

  loading(context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("جاري التحميل"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  failed(context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("تعذر تحميل البيانات")),
            Center(
                child: Text(
              "الرجاء التأكد من الإتصال بالانترنت و إعطاء التطبيق الصلاحيات اللازمة",
              style: Theme.of(context).textTheme.caption,
            )),
            ElevatedButton.icon(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh),
                label: Text("تحديث"))
          ],
        ),
      ),
    );
  }

  _loadDAta() async {
    try {
      bool result = false;
      var path = await getApplicationDocumentsDirectory();
      var dFile = File("${path.path}/data/data.json");
      var svc = await _getSVC();
      if (await dFile.exists() && await _isUptodate(dFile, svc)) {
        //all good continue
        result = true;
      } else {
        //updateFile
        result = await _downloadFile(dFile, svc);
      }
      if (result) {
        var stringData = await dFile.readAsString();
        jsonData = jsonDecode(stringData);
      }
      return result;
      //var vcFile = File(ExternalS);
    } catch (e) {
      debugPrint("loadData: ${e.toString()}");
      return false;
    }
  }

  Future<bool> _isUptodate(File dFile, int svc) async {
    var dataString = await dFile.readAsString();
    var dataJson = jsonDecode(dataString);
    int vc = int.tryParse(dataJson["vc"] ?? "0") ?? 0;
    return vc == svc;
  }

  Future<int> _getSVC() async {
    var doc = await FirebaseFirestore.instance.collection("vc").doc("vc").get();
    return int.tryParse(doc["vc"] ?? "0") ?? 0;
  }

  _downloadFile(File dFile, int svc) async {
    try {
      var jj = jsonDecode("{}");
      var cats =
          await FirebaseFirestore.instance.collection("categories").get();
      var stories =
          await FirebaseFirestore.instance.collection("stories").get();
      jj["vc"] = svc.toString();
      jj["categories"] =
          cats.docs.map((doc) => {"id": doc.id, "data": doc.data()}).toList();
      jj["stories"] = stories.docs
          .map((doc) => {"id": doc.id, "data": doc.data()})
          .toList();

      String jf = jsonEncode(jj);
      if (await dFile.exists()) {
        await dFile.delete();
      }
      await dFile.parent.create();
      await dFile.writeAsString(jf);
      return true;
    } catch (e) {
      debugPrint("downloadFile: ${e.toString()}");
      return false;
    }
  }
}
