class Coupon {
  String? sId;
  String? couponCode;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  String? endDate;
  String? status;
  String? applicableCategory;
  Null? applicableSubCategory;
  Null? applicableProduct;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Coupon(
      {this.sId,
        this.couponCode,
        this.discountType,
        this.discountAmount,
        this.minimumPurchaseAmount,
        this.endDate,
        this.status,
        this.applicableCategory,
        this.applicableSubCategory,
        this.applicableProduct,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount']?.toDouble();
    minimumPurchaseAmount = json['minimumPurchaseAmount']?.toDouble();
    endDate = json['endDate'];
    status = json['status'];
    applicableCategory = json['applicableCategory'];
    applicableSubCategory = json['applicableSubCategory'];
    applicableProduct = json['applicableProduct'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['couponCode'] = this.couponCode;
    data['discountType'] = this.discountType;
    data['discountAmount'] = this.discountAmount;
    data['minimumPurchaseAmount'] = this.minimumPurchaseAmount;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['applicableCategory'] = this.applicableCategory;
    data['applicableSubCategory'] = this.applicableSubCategory;
    data['applicableProduct'] = this.applicableProduct;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}