import 'package:flutter/material.dart';
import 'package:test_app/models/menu_option.dart';
import '../pages/calculator_screen.dart';
import '../pages/list_task_screen.dart';
import '../pages/search_screen.dart';

final List<MenuOption> listMenu = [
  MenuOption(
    title: 'Calculadora de propinas',
    icon: Icons.calculate,
    screen: CalculatorScreen(),
  ),
  MenuOption(
    title: 'Lista de Tareas',
    icon: Icons.list_alt_outlined,
    screen: TaskListScreen(),
  ),
  MenuOption(
    title: 'Consumo de API',
    icon: Icons.api_outlined,
    screen: SearchScreen(),
  ),
  MenuOption(
    title: 'Persistencia de Datos Avanzada',
    icon: Icons.data_array_outlined,
    screen: TaskListScreen(),
  ),
];
