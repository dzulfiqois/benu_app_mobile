import 'package:benu_app/home/home_screen.dart';
import 'package:flutter/material.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff006769),
      body: Stack(
        children: [
          SafeArea(
              child: Center(
            child: Image.asset('assets/images/benu_logo.png'),
          )),
        ],
      ),
    );
  }
}
