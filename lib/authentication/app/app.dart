import 'package:agrivigilance/authentication/ui/views/authentication/sign_in/sign_in_view.dart';
import 'package:agrivigilance/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

MaterialColor customColor = MaterialColor(0xFF54d6be, color);
Map<int, Color> color = {
  50: Color.fromRGBO(84, 214, 190, .1),
  100: Color.fromRGBO(84, 214, 190, .2),
  200: Color.fromRGBO(84, 214, 190, .3),
  300: Color.fromRGBO(84, 214, 190, .4),
  400: Color.fromRGBO(84, 214, 190, .5),
  500: Color.fromRGBO(84, 214, 190, .6),
  600: Color.fromRGBO(84, 214, 190, .7),
  700: Color.fromRGBO(84, 214, 190, .8),
  800: Color.fromRGBO(84, 214, 190, .9),
  900: Color.fromRGBO(84, 214, 190, 1),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrivigilance',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: Consumer<UserModel>(
        builder: (_, user, __) {
          if (user == null) {
            return SignInView();
          } else {
            return HomeView();
          }
        },
      ),
    );
  }
}
