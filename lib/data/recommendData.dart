import 'package:flutter/material.dart';

class Recommend {
  final String? imageRecommend;
  final String? titleMenu;

  Recommend({
    required this.imageRecommend,
    required this.titleMenu,
  });
}

List<Recommend> recommendData = [
  Recommend(
      imageRecommend:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Scottish_fold_cat.jpg',
      titleMenu: 'Recommend Title 1'),
  Recommend(
      imageRecommend:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Scottish_fold_cat.jpg',
      titleMenu: 'Recommend Title 2'),
  Recommend(
      imageRecommend:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Scottish_fold_cat.jpg',
      titleMenu: 'Recommend Title 3'),
  Recommend(
      imageRecommend:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Scottish_fold_cat.jpg',
      titleMenu: 'Recommend Title 4'),
  Recommend(
      imageRecommend:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Scottish_fold_cat.jpg',
      titleMenu: 'Recommend Title 5'),
  Recommend(
      imageRecommend:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Scottish_fold_cat.jpg',
      titleMenu: 'Recommend Title 6'),
];
