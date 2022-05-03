import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:athkar_cp/consts.dart';

abstract class FirebaseAPI {
  static Future<String> uploadPhoto(
      {required String fileName,
      required Uint8List fileData,
      required FileType mFileType}) async {
    try {
      Reference file =
          FirebaseStorage.instance.ref().child(mFileType.name).child(fileName);
      UploadTask task = file.putData(
          fileData,
          SettableMetadata(
              contentType:
                  "${mFileType.name}/${fileName.split('.').last.toLowerCase()}"));
      TaskSnapshot result = await Future.value(task);
      return await result.ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
      return "Error: Can not Upload Image!";
    }
  }

  static Future<String?> editCat(
      {required String id,
      String? image,
      String? title,
      String? description}) async {
    try {
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(id)
          .set({"image": image, "title": title, "description": description});
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  static editStory(
      {required String id,
      required String catID,
      required String content,
      required String title,
      String? description,
      String repeat = "1"}) async {
    try {
      await FirebaseFirestore.instance.collection("stories").doc(id).set({
        "catID": catID,
        "content": content,
        "title": title,
        "description": description,
        "repeat": repeat,
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, String>>> fetchCats() async {
    try {
      var x = await FirebaseFirestore.instance.collection("categories").get();
      return x.docs
          .map((e) => {
                "id": e.id,
                "title": e["title"].toString(),
                "image": e["image"].toString(),
                "description": e["description"].toString()
              })
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<Map<String, String>>> fetchStories() async {
    try {
      var stories =
          await FirebaseFirestore.instance.collection("stories").get();
      return stories.docs
          .map((e) => {
                "id": e.id,
                "title": e["title"].toString(),
                "catID": e["catID"].toString(),
                "content": e["content"].toString(),
                "description": e["description"].toString(),
                "repeat": e["repeat"].toString(),
              })
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static getCat({required String id}) async {
    try {
      var cat = await FirebaseFirestore.instance
          .collection("categories")
          .doc(id)
          .get();
      return {
        "title": cat["title"],
        "image": cat["image"],
        "description": cat["description"],
      };
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<String?> loadAbout() async {
    try {
      var x = await FirebaseFirestore.instance.collection("about").get();
      var y = x.docs.last["document"];
      return y;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<String?> saveAboute({required String document}) async {
    try {
      await FirebaseFirestore.instance
          .collection("about")
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({"document": document});
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return "Error: $e";
    }
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getMessages() async {
    try {
      var x = await FirebaseFirestore.instance.collection("suggestions").get();
      return x.docs;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<String> sendMessage(
      {required String title,
      String? body,
      String? imageUrl,
      Map<String, String>? data,
      String? serverKey}) async {
    try {
      String sK = serverKey ?? defaultServerKey;
      Map<String, String> headersList = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $sK',
        'Content-Type': 'application/json'
      };
      Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

      Map<String, Object?> rBody = {
        "to": "/topics/news",
        "notification": {
          "title": title,
          "mutable_content": true,
          "body": body,
          "image": imageUrl
        },
        "data": data
      };
      http.Request req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(rBody);

      http.StreamedResponse res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return resBody;
      } else if (res.statusCode == 401) {
        return "Error: 401, INVALID_KEY";
      } else {
        debugPrint(resBody);
        return "Error: ${res.reasonPhrase.toString()}";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "Error: ${e.toString()}";
    }
  }
}
