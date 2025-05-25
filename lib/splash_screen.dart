import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_pass/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  //teb3a splash screen hiya wel option  fi star elli lfou9 (with SingleTickerProviderStateMixin)
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // tna7i barre mta3 wa9t wel buttons mel louta
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const OnBoardingOne(),));
    });
    
  }


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/splash.png"),fit: BoxFit.cover),
        ),
      ),
    );
  }
}