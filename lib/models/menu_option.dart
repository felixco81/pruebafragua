import 'package:flutter/material.dart';


class MenuOption {
  final String title;
  final IconData icon;
  final Widget screen; // pantalla a la que va

  const MenuOption({required this.title, required this.icon, required this.screen});
}
