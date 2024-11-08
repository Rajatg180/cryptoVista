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

  // WidgetsFlutterBinding.ensureInitialized() ensures Flutter is fully set up
  //before using platform services like Firebase or device storage, typically used
  //at the start of the app in the main() function.
  WidgetsFlutterBinding.ensureInitialized();

  // if theme is null we will set it by default to light
  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp(
    MyApp(theme: currentTheme),
  );
}

class MyApp extends StatelessWidget {

  final String theme;

  const MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //  creates an instance of MarketProvider and provides it to the widget tree, 
        //allowing child widgets to listen for changes. When MarketProvider notifies listeners, 
        //the UI updates accordingly.
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
          create: (context) => NewsProvider(),
        ),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
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


/*

*****************Consumer when to use and why to use*******************************

The Consumer<ThemeProvider> widget is used to listen to changes in the ThemeProvider 
state and rebuild the MaterialApp whenever the theme changes. 
The builder function provides access to the themeProvider, allowing you to use its themeMode 
to set the app's theme dynamically.

# Why Use Consumer?

  Efficient Rebuilding: Only the widgets inside the Consumer are rebuilt when the 
                        ThemeProvider notifies listeners, improving performance.
  Access to Provider: It allows you to access the provider's state easily without 
                      needing to pass it down through the widget tree.

# When to Use Consumer?
  
  1) Use Consumer when you need to rebuild parts of the widget tree based on changes 
  in the provider’s state.

  2) It's especially useful when you want to listen to specific changes without 
  affecting the entire widget tree, as it minimizes unnecessary rebuilds.







***************************************** Accesing provider values with different methods *******************

In Flutter, when working with the Provider package for state management, you have several options to access the provider's data, each with its own purpose and behavior. Here's a breakdown of the differences between context.read<T>(), context.watch<T>(), and Provider.of<T>(context, listen: false):

1. context.read<T>()

      Purpose: Used to get the value of a provider without listening for changes.

      Usage: When you want to retrieve the provider’s value and don’t need the widget to rebuild when that value changes.

      final value = context.read<YourProvider>();

2. context.watch<T>()

      Purpose: Used to get the value of a provider and listen for changes.

      Usage: When you want the widget to rebuild whenever the provider's value changes.

      final value = context.watch<YourProvider>();

3. Provider.of<T>(context, listen: false)

      Purpose: A lower-level method to access the provider's value, similar to context.read<T>() when listen is set to false.

      Usage: Used when you want to retrieve the provider’s value without listening for changes, typically in callbacks or functions where you do not need the widget to rebuild.

      final value = Provider.of<YourProvider>(context, listen: false);



class MyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Using context.watch<T>() to rebuild when counter changes
    int counter = context.watch<CounterProvider>().counter;

    // Using context.read<T>() to increment the counter without rebuilding
    void _increment() {

      context.read<CounterProvider>().increment();

    }

    return Column(
      children: [
        Text('Counter: $counter'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}


********************************* notifyListner() *******************************
notifyListeners() is a method used within a class that extends ChangeNotifier. 
When this method is called, it notifies all the listeners (widgets that are listening to this provider) that something has changed. 
As a result, all widgets listening to this provider will rebuild to reflect the new state. 






 */
