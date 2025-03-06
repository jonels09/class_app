import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './providers/auth_provider.dart';
import './providers/student_provider.dart';
import './providers/subject_provider.dart';
import './providers/grade_provider.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<StudentProvider>(
          create: (_) => StudentProvider(),
        ),
        ChangeNotifierProvider<SubjectProvider>(
          create: (_) => SubjectProvider(),
        ),
        ChangeNotifierProvider<GradeProvider>(
          create: (_) => GradeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Loop HR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF2C3E50),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3498DB),
            primary: const Color(0xFF3498DB),
            secondary: const Color(0xFF2C3E50),
          ),
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
        home: const SplashScreen(),
      ),
    );
  }
}
