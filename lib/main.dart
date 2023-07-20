import 'package:flutter/material.dart';


import 'package:provider/provider.dart';


import 'app/config/providers.dart';
import 'app/config/routes.dart';
import 'app/config/theme_colors.dart';


void main() {
  runApp(
      MultiProvider(
        providers: Providers.listDefault(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Endereços',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: ThemeColors.priColor, surfaceTint: Colors.white),
        primaryColor: ThemeColors.priColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: ThemeColors.priColor, centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold, fontSize: 20)
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ThemeColors.secColor,
          extendedTextStyle: TextStyle(color: Colors.white)
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      initialRoute: "/login",
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
