class PlantDiseases {
  var status = [];

  PlantDiseases({this.status});

  PlantDiseases.fromJson(Map json) {
    status = json['status'];
  }

  Map toJson() => {'status': status};
}
