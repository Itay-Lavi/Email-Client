import 'package:flutter/material.dart';

const desktopWidth = 1200;

const tabletHeight = 600;
const tabletWidth = 830;

const wideMobileWidth = 500;

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget wideMobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    this.mobile,
    required this.wideMobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isAllMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidth;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < wideMobileWidth ||
      MediaQuery.of(context).size.height < tabletHeight;

  static bool isWideMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletWidth &&
      MediaQuery.of(context).size.width >= wideMobileWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktopWidth &&
      MediaQuery.of(context).size.width >= tabletWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidth;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than desktopWidth then we consider it a desktop
    if (size.width >= desktopWidth) {
      return desktop;
    }
    // If width it less then desktopWidth and more then tabletWidth we consider it as tablet
    else if (size.width >= tabletWidth) {
      return tablet;
    } else {
      return mobile ?? tablet;
    }
  }
}
