import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_portfolio/screens/landing_page.dart';
import 'package:ui_portfolio/theme.dart';
import 'package:ui_portfolio/utils/size_config.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeNotifier.themeMode,
          home: LayoutBuilder(
            builder: (context, constraints) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  if (constraints.smallest.width > 0 && constraints.smallest.height > 0) {
                    SizeConfig.init(constraints, orientation);
                    return const LandingPage();
                  }
                  return const SizedBox();
                },
              );
            },
          ),
        );
      },
    );
  }
}
