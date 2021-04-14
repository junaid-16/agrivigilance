import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './models/plant_disease.dart';

List<PlantDisease> _plantDiseases = [];

const List _healthyPlantCategories = [
  3,
  4,
  6,
  10,
  14,
  17,
  19,
  22,
  23,
  24,
  27,
  37
];

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

List<dynamic> getLatestPlantDiseaseResults() {
  print("2");
  try {
    var result = _plantDiseases[_plantDiseases.length - 1].classes;
    return result;
  } catch (e) {
    print("error $e");
    return [];
  }
}

double getHealthyPlantPercent() {
  int healthyCount = 0;
  print("1");
  var plantDiseaseList = getLatestPlantDiseaseResults();
  plantDiseaseList.forEach((element) {
    if (_healthyPlantCategories.contains(element)) {
      healthyCount += 1;
    }
  });
  print("Healthy plants: $healthyCount");
  var percent = healthyCount / plantDiseaseList.length * 100;
  return percent;
}
