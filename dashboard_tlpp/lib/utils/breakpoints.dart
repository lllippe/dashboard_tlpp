import 'package:flutter/material.dart';

const double mobileBreakpoint = 660;
const double tabletBreakpoint = 910;
const double desktopBreakpoint = 1200;

bool isMobile(BuildContext context) => 
    MediaQuery.of(context).size.width < mobileBreakpoint;

bool isTablet(BuildContext context) => 
    MediaQuery.of(context).size.width >= mobileBreakpoint && 
    MediaQuery.of(context).size.width < desktopBreakpoint;

bool isDesktop(BuildContext context) => 
    MediaQuery.of(context).size.width >= desktopBreakpoint;
