class PromotionId {
  String name;
  String image;
  PromotionId({required this.name, required this.image});
}

List<PromotionId> listPromoId = [
  PromotionId(
    name: 'โรงพยาบาลสัตว์ขวัญคำ สาขาราษฏร์พัฒนา',
    image: 'assets/image/p_kwan.jpg',
  ),
  PromotionId(
    name: 'โรงพยาบาลสัตว์ปาริชาต สุวินทวงศ์',
    image: 'assets/image/p_bronze.jpg',
  ),
  PromotionId(
    name: 'โรงพยาบาลสัตว์แฟมิแคร์',
    image: 'assets/image/p_fairpet.jpg',
  ),
  PromotionId(
    name: 'สถานพยาบาลสัตว์มายด์เพ็ทส์',
    image: 'assets/image/p_mypet.jpg',
  ),
];
