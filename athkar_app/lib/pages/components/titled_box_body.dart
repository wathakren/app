import 'package:flutter/material.dart';

class TitledBoxBody extends StatelessWidget {
  final bool inverted;
  const TitledBoxBody({
    Key? key,
    required this.size,
    required this.children,
    this.inverted = false,
  }) : super(key: key);

  final Size size;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .8,
      padding: EdgeInsets.all(16),
      child: Column(
          children: <Widget>[
                inverted ? SizedBox() : SizedBox(height: 48),
              ] +
              children +
              [
                inverted ? SizedBox(height: 48) : SizedBox(),
                // SizedBox(height: 24),
              ]),
    );
  }
}
