import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_pages.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  State<SplashScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(

      const Duration(seconds: 5),
      (() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return const HomePage();
            },
          ),
        );
      }),
    );
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/Lottie/crypto.json',
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: const Text(
                  "CryptoVista",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
