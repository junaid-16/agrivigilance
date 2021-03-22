import 'package:agrivigilance/ui/views/authentication/sign_in/sign_in_view.dart';
import 'package:agrivigilance/ui/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrivigilance',
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
