import 'package:flutter/material.dart';
import 'package:galaxy_planets/models/json_decode.dart';
import 'package:provider/provider.dart';

import '../../providers/json_decode_provider.dart';
import '../../providers/theme_provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation sizeAnimatiion;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
      lowerBound: 0,
      upperBound: 1,
    )..forward();
    animationController.addListener(() {
      setState(() {});
    });
    sizeAnimatiion = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 100), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 100, end: 150), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 150, end: 200), weight: 1),
    ]).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    JsonDecodeModel data =
        ModalRoute.of(context)!.settings.arguments as JsonDecodeModel;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage('assets/gifs/BackgroundBlack.gif'),
            fit: BoxFit.cover,
          ),
        ),
        body: Container(
          height: 800,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gifs/BackgroundBlack.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeAnimatiion.value,
                    width: sizeAnimatiion.value,
                    child: Image.asset(
                      data.image,
                    ),
                  ),
                  Container(
                    height: 1000,
                    width: 440,
                    decoration: BoxDecoration(
                      color: (Provider.of<ThemeProvider>(context)
                              .themeModel
                              .isDark)
                          ? Colors.grey.withOpacity(0.4)
                          : Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.name,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<JsonDecodeProvider>(context,
                                        listen: false)
                                    .favoritePlanet(int.parse(data.position));
                              },
                              icon: (Provider.of<JsonDecodeProvider>(context)
                                      .galaxyDetails[int.parse(data.position)]
                                      .favorite)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.pink,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                    ),
                            ),
                          ],
                        ),
                        Text(
                          data.type,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade700,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Age : ${data.age}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Radius : ${data.radius}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Orbital Period : ${data.orbital_period}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Gravity : ${data.gravity}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Velocity : ${data.velocity}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Distance (from Sun) : ${data.distance}',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade700,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade700,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 400,
                              width: 320,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 20),
                                itemCount: data.images.length,
                                itemBuilder: (context, i) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(data.images[i]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
