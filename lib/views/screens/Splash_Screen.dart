import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/json_decode_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loadData() async {
    await Provider.of<JsonDecodeProvider>(context, listen: false).loadJson();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacementNamed('second_page');
      },
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 800,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/gifs/splesh_screen.gif',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
