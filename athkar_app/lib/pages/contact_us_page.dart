import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wathakren/consts.dart';
import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/providers/theme_provider.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController contentController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_forward))
        ],
        shape: customRoundedRectangleBorder,
        backgroundColor: Provider.of<ThemeProvider>(context).appBarColor,
      ),
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height * 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("يمكنك ارسال رسالة"),
                  TextField(
                    decoration: _inputDecoration(label: "الإسم"),
                    controller: nameController,
                  ),
                  TextField(
                    decoration: _inputDecoration(label: "البريد الإلكتروني"),
                    controller: emailController,
                  ),
                  TextField(
                    decoration: _inputDecoration(label: "الموضوع"),
                    controller: subjectController,
                  ),
                  TextField(
                    decoration: _inputDecoration(label: "الرسالة"),
                    controller: contentController,
                    maxLength: 500,
                    minLines: 5,
                    maxLines: 5,
                  ),
                  CustomElevatedButton(text: "إرسال", ontap: _submit)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label}) {
    return InputDecoration(
        labelText: "$label: ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(32), topLeft: Radius.circular(32)),
        ));
  }

  void _submit() async {
    List<TextEditingController> c = [
      nameController,
      emailController,
      subjectController,
      contentController
    ];
    bool cango = true;
    for (TextEditingController cc in c) {
      if (cc.text.isEmpty) {
        cango = false;
      }
    }
    if (!cango) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () => Navigator.pop(context),
                      child: Text("موافق"))
                ],
                content: Text("خطأ: كل الحقول مطلوبة *"),
              ));
    } else {
      String error = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: FutureBuilder(
                  future: _firebaseWrite(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    } else {
                      Navigator.of(context).pop(snapshot.data.toString());
                      return Container();
                    }
                  },
                ),
              ));
      if (error.contains("Error: ")) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text("خطأ"),
            content: Text("تعذر الإتصال بقاعدة البيانات"),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("موافق"))
            ],
          ),
        );
      } else {
        //submitted
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text("تم"),
            content: Text("تم الإرسال بنجاح"),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("موافق"))
            ],
          ),
        );
      }
      for (TextEditingController cc in c) {
        cc.clear();
      }
    }
  }

  Future<String> _firebaseWrite() async {
    try {
      await FirebaseFirestore.instance.collection("suggestions").doc().set({
        "name": nameController.text,
        "email": emailController.text,
        "subject": subjectController.text,
        "content": contentController.text,
      });
      return "done";
    } catch (e) {
      return "Error: $e";
    }
  }
}
