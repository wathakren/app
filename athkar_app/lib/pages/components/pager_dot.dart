import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagerDot extends StatelessWidget {
  final bool active;
  const PagerDot({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: active
              ? Provider.of<ThemeProvider>(context).kPrimary
              : Colors.white,
          border:
              Border.all(color: Provider.of<ThemeProvider>(context).kPrimary),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
