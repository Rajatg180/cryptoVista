import 'package:cryptotracker/Constants/themes.dart';
import 'package:cryptotracker/Models/local_storage.dart';
import 'package:cryptotracker/Provider/market_provider.dart';
import 'package:cryptotracker/Provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/splash_screen.dart';
import 'Provider/graph_provider.dart';
import 'Provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if theme is null we will set it by default to light
  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp(MyApp(theme:currentTheme));
}

class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),

        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        ),

        ChangeNotifierProvider<GraphProvider>(
          create: (context) => GraphProvider(),
        ),

        ChangeNotifierProvider<NewsProvider>(
          create: (context)=>NewsProvider(),
        )

      ],
      child: Consumer<ThemeProvider>(
        builder: (context,themeProvider,child){
          return MaterialApp(
            title: 'CryptoVista',
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
