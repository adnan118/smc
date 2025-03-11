class StoreModel {
  int? productId;
  String? productName;
  String? productNameAr;
  String? productImg;
  int? productQuantity;
  int? productPrice;
  int? productDiscount;
  int? productCategories;
  int? productActive;
  String? productDate;
  int? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImg;

  StoreModel(
      {this.productId,
        this.productName,
        this.productNameAr,
        this.productImg,
        this.productQuantity,
        this.productPrice,
        this.productDiscount,
        this.productCategories,
        this.productActive,
        this.productDate,
        this.categoriesId,
        this.categoriesName,
        this.categoriesNameAr,
        this.categoriesImg});

  StoreModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productNameAr = json['product_name_ar'];
    productImg = json['product_img'];
    productQuantity = json['product_quantity'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productCategories = json['product_categories'];
    productActive = json['product_active'];
    productDate = json['product_date'];
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesImg = json['categories_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_name_ar'] = this.productNameAr;
    data['product_img'] = this.productImg;
    data['product_quantity'] = this.productQuantity;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_categories'] = this.productCategories;
    data['product_active'] = this.productActive;
    data['product_date'] = this.productDate;
    data['categories_id'] = this.categoriesId;
    data['categories_name'] = this.categoriesName;
    data['categories_name_ar'] = this.categoriesNameAr;
    data['categories_img'] = this.categoriesImg;
    return data;
  }
}