import 'package:agrivigilance/authentication/ui/views/authentication/sign_in/sign_in_view.dart';
import 'package:agrivigilance/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrivigilance',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
