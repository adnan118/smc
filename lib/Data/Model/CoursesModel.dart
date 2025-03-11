class CoursesModel {
  int? coursesId;
  String? coursesName;
  String? coursesNameAr;
  int? coursesPrice;
  int? coursesDiscount;

  CoursesModel(
      {this.coursesId,
        this.coursesName,
        this.coursesNameAr,
        this.coursesPrice,
        this.coursesDiscount});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    coursesId = json['courses_id'];
    coursesName = json['courses_name'];
    coursesNameAr = json['courses_name_ar'];
    coursesPrice = json['courses_price'];
    coursesDiscount = json['courses_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses_id'] = this.coursesId;
    data['courses_name'] = this.coursesName;
    data['courses_name_ar'] = this.coursesNameAr;
    data['courses_price'] = this.coursesPrice;
    data['courses_discount'] = this.coursesDiscount;
    return data;
  }
}