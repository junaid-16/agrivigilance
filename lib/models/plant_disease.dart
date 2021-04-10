class PlantDisease {
  List<int> status;

  PlantDisease({this.status});

  PlantDisease.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'].cast<int>();
  }

  Map<dynamic, dynamic> toJson() => {'status': status.cast<int>()};
}
