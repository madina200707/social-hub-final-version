import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/post_cubit.dart';
import 'cubits/api_cubit.dart';
import 'cubits/theme_cubit.dart';
import 'cubits/language_cubit.dart';

import 'screens/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PostCubit()),
        BlocProvider(create: (_) => ApiCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              title: 'Social Hub',
              debugShowCheckedModeBanner: false,
              locale: locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
                Locale('kk'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              themeMode: themeMode,

              
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                colorScheme: ColorScheme(
                  brightness: Brightness.light,
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  secondary: Colors.greenAccent,
                  onSecondary: Colors.black,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Colors.white,
                  onBackground: Colors.black,
                  surface: Colors.grey.shade100,
                  onSurface: Colors.black,
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.green,
                ),
              ),

              
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: Colors.green,
                  onPrimary: Colors.black,
                  secondary: Colors.greenAccent,
                  onSecondary: Colors.black,
                  error: Colors.red,
                  onError: Colors.black,
                  background: Colors.black,
                  onBackground: Colors.white,
                  surface: Color(0xFF1E1E1E),
                  onSurface: Colors.white,
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                  ),
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.green,
                ),
              ),

              home: BlocBuilder<AuthCubit, dynamic>(
                builder: (context, user) {
                  if (user == null) {
                    return const LoginScreen();
                  } else {
                    return const MainScreen();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
