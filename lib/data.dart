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

// This function returns the list of plant-classes
List<dynamic> getHealthyPlantCount(index) {
  try {
    var result = _plantDiseases[index].classes;
    return result;
  } catch (e) {
    print("[ERROR] $e");
    return [];
  }
}

// This functions is used in donut chart for healthy and unhealthy plant percentage
// This return % of healthy plants present in the last plant-disease object present in _plantDiseases
double getHealthyPlantPercent() {
  int healthyCount = 0;
  var plantDiseaseList = getHealthyPlantCount(_plantDiseases.length - 1);
  plantDiseaseList.forEach((element) {
    if (_healthyPlantCategories.contains(element)) {
      healthyCount += 1;
    }
  });
  var percent = healthyCount / plantDiseaseList.length * 100;
  print("Latest healthy plant %: $percent");
  return percent;
}

// This function is meant to be used in line chart for plants
// As of now, it prints the list of count of healthy plants of all objects present in _plantDiseases
List<dynamic> getAllHealthyPlantsNumber() {
  List healthyList = [];
  for (int i = 0; i < _plantDiseases.length; i++) {
    int healthyCount = 0;
    var plantDiseaseList = getHealthyPlantCount(i);
    plantDiseaseList.forEach((element) {
      if (_healthyPlantCategories.contains(element)) {
        healthyCount += 1;
      }
    });
    healthyList.add(healthyCount);
  }
  return healthyList;
}

int getTotalPlantsCount() {
  return(_plantDiseases[0].classes.length);
}
