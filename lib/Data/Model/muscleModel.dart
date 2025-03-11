class MuscleModel {
  int? trainingId;
  String? trainingName;
  String? trainingNameAr;
  int? trainingMuscle;
  String? trainingRes;
  String? trainingSet;
  int? muscleId;
  String? muscleName;
  String? muscleNameAr;

  MuscleModel(
      {this.trainingId,
        this.trainingName,
        this.trainingNameAr,
        this.trainingMuscle,
        this.trainingRes,
        this.trainingSet,
        this.muscleId,
        this.muscleName,
        this.muscleNameAr});

  MuscleModel.fromJson(Map<String, dynamic> json) {
    trainingId = json['training_id'];
    trainingName = json['training_name'];
    trainingNameAr = json['training_name_ar'];
    trainingMuscle = json['training_muscle'];
    trainingRes = json['training_res'];
    trainingSet = json['training_set'];
    muscleId = json['muscle_id'];
    muscleName = json['muscle_name'];
    muscleNameAr = json['muscle_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['training_id'] = this.trainingId;
    data['training_name'] = this.trainingName;
    data['training_name_ar'] = this.trainingNameAr;
    data['training_muscle'] = this.trainingMuscle;
    data['training_res'] = this.trainingRes;
    data['training_set'] = this.trainingSet;
    data['muscle_id'] = this.muscleId;
    data['muscle_name'] = this.muscleName;
    data['muscle_name_ar'] = this.muscleNameAr;
    return data;
  }
}