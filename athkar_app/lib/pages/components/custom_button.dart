import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final String? subText;
  final Function() ontap;
  final Function()? onLongPress;
  final bool filled;
  final Widget? icon;
  final Color? fillColor;
  final Color? color;
  final String? fontFamily;

  final bool childCentered;
  final FontWeight? boldness;
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.ontap,
    this.filled = false,
    this.childCentered = true,
    this.subText,
    this.icon,
    this.boldness,
    this.fillColor,
    this.color,
    this.fontFamily,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: filled
            ? fillColor ?? color ?? Provider.of<ThemeProvider>(context).kPrimary
            : null,
        border: Border.all(
            width: 1,
            color: fillColor ??
                color ??
                Provider.of<ThemeProvider>(context).kPrimary),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32), topLeft: Radius.circular(32)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(32), topLeft: Radius.circular(32)),
          ),
          onTap: ontap,
          onLongPress: onLongPress,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 18.0, vertical: icon == null && filled ? 12 : 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: filled
                          ? TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white,
                              fontWeight: boldness ?? FontWeight.bold)
                          : TextStyle(
                              fontFamily: fontFamily,
                              color: color ??
                                  Provider.of<ThemeProvider>(context).kPrimary,
                              fontWeight: boldness),
                    ),
                    subText == null
                        ? SizedBox()
                        : Text(
                            subText ?? "",
                            textScaleFactor: .6,
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: fontFamily,
                            ),
                          ),
                  ],
                ),
                childCentered
                    ? SizedBox(width: icon == null ? 0 : 16)
                    : Spacer(),
                icon == null
                    ? SizedBox()
                    : SizedBox(
                        child: icon!,
                        height: childCentered ? 34 : null,
                        width: childCentered ? 34 : null,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final Widget? icon;
  final double? leadingSpace;
  final String text;
  final Color? color;
  final String? fontFamily;
  final Function() ontap;
  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.ontap,
      this.color,
      this.fontFamily,
      this.icon,
      this.leadingSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Provider.of<ThemeProvider>(context).accentColor,
        border: Border.all(
            width: 1,
            color: color ?? Provider.of<ThemeProvider>(context).accentColor),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32), topLeft: Radius.circular(32)),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(32), topLeft: Radius.circular(32)),
        ),
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
          child: icon != null
              ? Row(
                  children: [
                    SizedBox(width: leadingSpace ?? 48),
                    icon ?? SizedBox(),
                    SizedBox(width: (leadingSpace ?? 48) / 2),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontFamily,
                  ),
                ),
        ),
      ),
    );
  }
}
