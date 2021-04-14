import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './models/plant_disease.dart';

List<PlantDisease> _plantDiseases = [];

Future<void> fetchAndSetPlants() async {
  final snapshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("plant")
      .get();
  var temp = [];
  snapshot.docs.forEach((element) {
    temp.add(element.id);
  });
  print(temp);
  List<PlantDisease> tempPlantDiseases = [];
  temp.forEach((element) async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("plant")
        .doc(element)
        .get();
    var count = value.data()["count"];
    tempPlantDiseases
        .add(PlantDisease(classes: count, time: element.toString()));
  });
  _plantDiseases = tempPlantDiseases;
}

void printPlantDiseases() {
  print(_plantDiseases[0].classes);
}
