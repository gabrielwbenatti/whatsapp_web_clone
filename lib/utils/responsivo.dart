import 'package:flutter/material.dart';

class Responsivo extends StatelessWidget {
  const Responsivo({
    Key? key,
    required this.web,
    required this.mobile,
    this.tablet,
  }) : super(key: key);

  final Widget mobile;
  final Widget? tablet;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return web;
        } else if (constraints.maxWidth >= 800) {
          Widget? resTablet = tablet;
          if (resTablet != null) {
            return resTablet;
          } else {
            return mobile;
          }
        } else {
          return mobile;
        }
      },
    );
  }
}
