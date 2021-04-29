import 'dart:ui';

import 'package:agrivigilance/authentication/app/constants/string.dart';
import 'package:agrivigilance/authentication/app/services/firebase_auth_service.dart';
import 'package:agrivigilance/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/plants_line_chart.dart';
import '../widgets/plant_pie_chart.dart';
import '../widgets/cattle_bar_chart.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    fetchAndSetPlants();
    fetchAndSetCattle();
  }

  bool showInfo = false;
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/black-concrete-wall.jpg"), context);
    final userId = FirebaseAuthService().currentUser();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/black-concrete-wall.jpg"),
              fit: BoxFit.fill),
        ),
        child: showInfo
            ? Info()
            : Column(
                children: <Widget>[
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        height: 75,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0.0, 100), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            ". . .  Agrivigilance  . . .",
                            style: GoogleFonts.rancho(
                                fontSize: 45,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Welcome Back,',
                      style: GoogleFonts.muli(
                          color: Colors.grey[100], fontSize: 20),
                    ),
                  ),
                  // Text(
                  //   userId,
                  //   style: GoogleFonts.muli(color: Colors.white, fontSize: 25),
                  // ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PlantPieChart(),
                          SizedBox(width: 15),
                          CattleBarChart(),
                        ],
                      ),
                      SizedBox(height: 15),
                      PlantsLineChart(),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 250,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<FirebaseAuthService>().signOut();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side:
                                BorderSide(color: Colors.tealAccent, width: 3),
                          ),
                        ),
                      ),
                      child: Text(
                        Strings.signOut,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          print("It will display project Info");
          setState(() {
            showInfo = !showInfo;
          });
        },
        child: Icon(
          showInfo ? Icons.close : Icons.lightbulb_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
      child: Column(
        children: [
          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                ". . .  Agrivigilance  . . .",
                style: GoogleFonts.rancho(
                    fontSize: 45,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Made by,",
              style: GoogleFonts.muli(color: Colors.white, fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              "Karan Owalekar   •   Junaid Shaikh   •   Meghna Daftary",
              style: GoogleFonts.rancho(color: Colors.tealAccent, fontSize: 27),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: Text(
              "Our system, Agrivigilance, helps in implementing precise farming techniques like crop disease detection and cattle counting to encounter the challenges faced by the farmers in India. This system takes in the image as input and detects whether a crop is healthy or not. If not, it identifies the disease of the plant. Additionally, due to the theft and killing of cattle, we have introduced a counter in our system to keep track of the cattle at all times. Agrivigilance will increase the productivity of the agricultural processes because of the efficiency, robustness, and reliability of the system.",
              style: GoogleFonts.indieFlower(
                  fontSize: 23, color: Colors.grey[100]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Text(
            "Charts",
            style: GoogleFonts.indieFlower(
              fontSize: 21,
              color: Colors.grey[100],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Text(
              "Plant Health - This chart depicts the percentage of healthy and unhealthy plants taken from the latest reading of the crops on the farmland.\n\nCattle Count - The bar chart illustrates the number of each animal spotted on the farmland.\n\nHealthy Plants Trend - This line graph unfolds the trend of plant health by giving an overview of the readings recorded over the last few readings.",
              style: GoogleFonts.indieFlower(
                  fontSize: 20, color: Colors.grey[100]),
              textAlign: TextAlign.justify,
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
