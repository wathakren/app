import 'package:flutter/material.dart';

class EditCustomThekr extends StatelessWidget {
  final String? text;
  const EditCustomThekr({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    TextEditingController mController = TextEditingController(text: text);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  maxLength: 200,
                  minLines: 3,
                  maxLines: 3,
                  controller: mController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("رجوع")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, mController.text);
                        },
                        child: Text("أضافة")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
