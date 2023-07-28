import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/json_decode_provider.dart';
import '../../providers/theme_provider.dart';
import 'Favorites_Page.dart';
import 'Settings_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  int initialIndex = 0;
  PageController pageController = PageController();
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: initialIndex,
          onTap: (val) {
            Provider.of<JsonDecodeProvider>(context, listen: false)
                .selectColor(val);
            pageController.animateToPage(val,
                duration: Duration(milliseconds: 400), curve: Curves.easeIn);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gifs/BackgroundBlack.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: PageView(
            controller: pageController,
            onPageChanged: (val) {
              setState(() {
                initialIndex = val;
              });
            },
            children: [
              Expanded(
                flex: 18,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...List.generate(
                        Provider.of<JsonDecodeProvider>(context, listen: false)
                            .galaxyDetails
                            .length,
                        (index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  'details_page',
                                  arguments: Provider.of<JsonDecodeProvider>(
                                          context,
                                          listen: false)
                                      .galaxyDetails[index],
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: AnimatedBuilder(
                                      animation: animationController,
                                      child: Image.asset(
                                        Provider.of<JsonDecodeProvider>(context,
                                                listen: false)
                                            .galaxyDetails[index]
                                            .image,
                                        height: 180,
                                        width: 180,
                                      ),
                                      builder: (context, widget) {
                                        return Transform.rotate(
                                          angle: animationController.value,
                                          child: widget,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 160,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color:
                                          (Provider.of<ThemeProvider>(context)
                                                  .themeModel
                                                  .isDark)
                                              ? Colors.grey.withOpacity(0.4)
                                              : Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Provider.of<JsonDecodeProvider>(
                                                  context)
                                              .galaxyDetails[index]
                                              .name,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  animationController.stop();

                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.stop)),
                                            IconButton(
                                              onPressed: () {
                                                animationController.forward();

                                                setState(() {});
                                              },
                                              icon:
                                                  const Icon(Icons.play_arrow),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                animationController.repeat();

                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.repeat),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                animationController.reverse(
                                                    from: 2 * pi);
                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.refresh),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FavoritesPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
