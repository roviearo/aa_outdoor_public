import 'package:flutter/material.dart';

class NavModel {
  NavModel({required this.page, required this.navKey});
  final Widget page;
  final GlobalKey<NavigatorState> navKey;
}
