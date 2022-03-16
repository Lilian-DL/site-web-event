import 'package:flutter/material.dart';
import 'package:web_plan/breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({required this.mobileBody, required this.desktopBody});

  final Widget mobileBody;
  final Widget desktopBody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) {
        if (constaints.maxWidth < kMobileBreakpoint) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
