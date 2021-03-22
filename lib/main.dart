import 'package:agrivigilance/app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuthService(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged,
        )
      ],
      child: MyApp(),
    ),
  );
}
