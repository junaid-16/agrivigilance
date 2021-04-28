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

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fetchAndSetPlants();
    fetchAndSetCattle();
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
        child: Column(
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
                style: GoogleFonts.muli(color: Colors.grey[100], fontSize: 20),
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
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.tealAccent, width: 3),
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
          fetchAndSetCattle();
          print("It will display roject Info");
        },
        child: Icon(
          Icons.lightbulb_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
