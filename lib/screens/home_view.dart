import 'package:agrivigilance/authentication/app/constants/string.dart';
import 'package:agrivigilance/authentication/app/services/firebase_auth_service.dart';
import 'package:agrivigilance/models/plant_disease.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuthService().currentUser();

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Home Page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const Spacer(),
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users/5mDylgM9JrVDYWxbYoPusCu2GRb2/plant')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  PlantDiseases plantDisease =
                      PlantDiseases.fromJson(snapshot.data.docs[0].data());
                  return Text(plantDisease.status.toString());
                },
              ),
            ),
            Text(userId),
            ElevatedButton(
              onPressed: () {
                context.read<FirebaseAuthService>().signOut();
              },
              child: Text(Strings.signOut),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
