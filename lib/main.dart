import 'package:flutter/material.dart';
import 'data/menu_data.dart';
import 'widgets/glass_button.dart';
import 'package:flutter/services.dart';
import 'theme/colors.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'data/menu_data.dart';
import 'widgets/glass_button.dart';
import 'providers/tip_calculator_provider.dart'; 
import 'providers/task_provider.dart';  
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); // 🔹 asegurarte de que esto pase primero
  } catch (e) {
    print('Error cargando .env: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TipCalculator()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),  
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ), 
      ),


      home: const MyHomePage(title: 'Desafio Tecnico Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* NOTAS
 * Pantalla principal, con estilo glass 
 * Las opciones del menu se cargan desde menu_data.dart de froma que pueda escalar facilmente
 * Sin logica de negocio aun, solo navegacion a pantallas siguientes
 * Pantalla sin navigation bar ni app bar, para un mejor efecto visual, con iconos blancos en statusbar

 */

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(
                    'Desafio Tecnico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Selecciona una opción',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 140, 
              left: 0,
              right: 0,
              bottom: 0,
              child: GridView.count(
                padding: const EdgeInsets.all(12),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ...listMenu
                      .map(
                        (menu) => GlassButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => menu.screen),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(menu.icon, size: 36, color: Colors.white),
                              const SizedBox(height: 8),
                              Text(
                                menu.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      "Ir",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),

            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Text(
                'By Felix Carrillo Orozco',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
