import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitledBox extends StatelessWidget {
  final String? title;
  final Widget child;
  final double width;
  final bool inverted;
  final bool titleContained;
  final bool filled;
  final Color? color;
  final Color? fillColor;
  final double? fontSize;

  const TitledBox({
    Key? key,
    this.title,
    this.color,
    this.filled = false,
    this.inverted = false,
    this.titleContained = false,
    required this.child,
    required this.width,
    this.fillColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: width,
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
            width: 1,
            color: color ?? Provider.of<ThemeProvider>(context).kPrimary),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50), topLeft: Radius.circular(50)),
      ),
      child: Stack(
        children: [
          inverted ? child : SizedBox(),
          title == null
              ? SizedBox()
              : Positioned(
                  top: inverted ? null : -1,
                  left: -1,
                  right: -1,
                  bottom: inverted ? -1 : null,
                  child: BoxTitle(
                    color: color,
                    contained: titleContained,
                    title: title!,
                    fontSize: fontSize,
                    filled: filled,
                    width: width,
                  ),
                ),
          inverted ? SizedBox() : child,
        ],
      ),
    );
  }
}

class BoxTitle extends StatelessWidget {
  final String title;
  final double width;
  final bool contained;
  final bool filled;
  final Color? color;
  final double? fontSize;
  const BoxTitle({
    Key? key,
    required this.title,
    required this.width,
    this.contained = false,
    this.filled = false,
    this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: filled
            ? color ?? Provider.of<ThemeProvider>(context).kPrimary
            : null,
        border: Border.all(
            width: 1,
            color: color ?? Provider.of<ThemeProvider>(context).kPrimary),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50), topLeft: Radius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: contained ? EdgeInsets.all(8) : null,
              decoration: contained
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: color ??
                                Provider.of<ThemeProvider>(context).accentColor)
                      ],
                      color: Colors.white,
                    )
                  : null,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: filled
                      ? Colors.white
                      : color ?? Provider.of<ThemeProvider>(context).kPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
