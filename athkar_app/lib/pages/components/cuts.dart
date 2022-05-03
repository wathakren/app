import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class Trycut extends StatelessWidget {
  final double? thickness;
  final Widget child;
  final Color? color;
  const Trycut({
    Key? key,
    required this.child,
    required double width,
    this.thickness,
    this.color,
  })  : _width = width,
        super(key: key);

  final double _width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: _width,
          width: _width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: color ??
                        Provider.of<ThemeProvider>(context)
                            .accentColor
                            .withOpacity(.1),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 0))
              ],
              border: Border.all(
                width: 10 * (thickness ?? 1),
                color: color ?? Provider.of<ThemeProvider>(context).accentColor,
              ),
              borderRadius: BorderRadius.circular(_width * 3)),
          child: Center(child: child),
        ),
        Transform.rotate(
          angle: -math.pi / 2,
          child: Row(
            children: [
              Container(
                  color: Colors.white, height: 4, width: 12 * (thickness ?? 1)),
              SizedBox(
                height: 4,
                width: _width / 3 - 12 * (thickness ?? 1),
              ),
            ],
          ),
        ),
        Transform.rotate(
          angle: math.pi / 6,
          child: Row(
            children: [
              Container(
                  color: Colors.white, height: 4, width: 12 * (thickness ?? 1)),
              SizedBox(
                height: 4,
                width: _width / 3 - 12 * (thickness ?? 1),
              ),
            ],
          ),
        ),
        Transform.rotate(
          angle: math.pi / 1.2,
          child: Row(
            children: [
              Container(
                  color: Colors.white, height: 4, width: 12 * (thickness ?? 1)),
              SizedBox(
                height: 4,
                width: _width / 3 - 12 * (thickness ?? 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TriCut extends StatelessWidget {
  final double _width;
  final Widget _child;
  final int val;

  const TriCut(
      {Key? key, required double width, required Widget child, this.val = 0})
      : _width = width,
        _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _width,
      width: _width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.rotate(
            angle: math.pi * .01,
            child: CircularProgressIndicator(
              valueColor: val > 0
                  ? AlwaysStoppedAnimation<Color>(
                      Provider.of<ThemeProvider>(context).kPrimary)
                  : null,
              strokeWidth: 20,
              color: Provider.of<ThemeProvider>(context).accentColor,
              value: .32,
            ),
          ),
          Transform.rotate(
            angle: .678 * math.pi,
            child: CircularProgressIndicator(
              valueColor: val > 1
                  ? AlwaysStoppedAnimation<Color>(
                      Provider.of<ThemeProvider>(context).kPrimary)
                  : null,
              strokeWidth: 20,
              color: Provider.of<ThemeProvider>(context).accentColor,
              value: .32,
            ),
          ),
          Transform.rotate(
            angle: -math.pi * .658,
            child: CircularProgressIndicator(
              valueColor: val > 2
                  ? AlwaysStoppedAnimation<Color>(
                      Provider.of<ThemeProvider>(context).kPrimary)
                  : null,
              strokeWidth: 20,
              color: Provider.of<ThemeProvider>(context).accentColor,
              value: .32,
            ),
          ),
          Center(child: _child),
        ],
      ),
    );
  }
}

class BiCut extends StatelessWidget {
  final double _width;
  final Widget _child;
  final List<bool> vals;

  const BiCut(
      {Key? key,
      required double width,
      required Widget child,
      required this.vals})
      : _width = width,
        _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool v1 = vals.first;
    bool v2 = vals.last;
    return SizedBox(
      height: _width,
      width: _width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.rotate(
            angle: 0.01,
            child: CircularProgressIndicator(
              valueColor: v1
                  ? AlwaysStoppedAnimation<Color>(
                      Provider.of<ThemeProvider>(context).kPrimary)
                  : null,
              strokeWidth: 20,
              color: Provider.of<ThemeProvider>(context).accentColor,
              value: .49,
            ),
          ),
          Transform.rotate(
            angle: 1.005 * math.pi,
            child: CircularProgressIndicator(
              valueColor: v2
                  ? AlwaysStoppedAnimation<Color>(
                      Provider.of<ThemeProvider>(context).kPrimary)
                  : null,
              strokeWidth: 20,
              color: Provider.of<ThemeProvider>(context).accentColor,
              value: .49,
            ),
          ),
          Center(child: _child),
        ],
      ),
    );
  }
}

class SingleCut extends StatelessWidget {
  final double _width;
  final Widget _child;
  final bool _val;
  const SingleCut(
      {Key? key,
      required double width,
      required Widget child,
      bool cVal = true})
      : _width = width,
        _child = child,
        _val = cVal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _width,
      width: _width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.rotate(
            angle: 1.01 * math.pi,
            child: CircularProgressIndicator(
              valueColor: _val
                  ? AlwaysStoppedAnimation<Color>(
                      Provider.of<ThemeProvider>(context).kPrimary)
                  : null,
              strokeWidth: 20,
              color: Provider.of<ThemeProvider>(context).accentColor,
              value: .99,
            ),
          ),
          Center(child: _child),
        ],
      ),
    );
  }
}
