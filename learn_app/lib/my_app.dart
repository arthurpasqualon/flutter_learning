import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_app/pages/splash_screen.dart';
import 'package:learn_app/services/counter_service.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterService>(
            create: (BuildContext context) => CounterService()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.grey,
            textTheme: GoogleFonts.ptSansTextTheme(),
          ),
          home: const SplashScreen()),
    );
  }
}
