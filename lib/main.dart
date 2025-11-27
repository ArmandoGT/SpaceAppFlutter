import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'providers/apod_provider.dart';
import 'screens/home_screen.dart';
import 'screens/about_us_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApodProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário Espacial NASA',
      debugShowCheckedModeBanner: false,

      // Configuração de Tema
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0b3c91), // Azul NASA
          primary: const Color(0xFF0b3c91),
          secondary: const Color(0xFFfc3d21), // Vermelho NASA
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      // DatePicker Português
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      home: const HomeScreen(),

      routes: {
        '/about': (context) => const AboutUsScreen(),
      },
    );
  }
}
