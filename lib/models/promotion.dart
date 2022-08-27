class Promotions {
  late String adminId;
  late String promotionId;
  late String promotionImage;
  late String promotionTitle;

  Promotions(
      {required this.adminId,
      required this.promotionId,
      required this.promotionImage,
      required this.promotionTitle});

  Promotions.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    promotionId = json['promotionId'];
    promotionImage = json['promotionImage'];
    promotionTitle = json['promotionTitle'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['promotionId'] = this.promotionId;
    data['promotionImage'] = this.promotionImage;
    data['promotionTitle'] = this.promotionTitle;

    return data;
  }
}
