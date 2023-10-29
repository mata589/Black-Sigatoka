import 'package:flutter/material.dart';

import 'package:yoo_katale/model/plant_model.dart';
import 'package:yoo_katale/model/data/constant.dart';
import 'package:yoo_katale/model/plant_model.dart';

import '../plant_model.dart';

final List<plant> Plant = [
  plant(
    plantname: "CASSAVA",
    imageUrl: "images/pic/img1.png",
    backImage: "images/box/box1.png",
    color: kDarkBlue,
    Diseases: [
      'CORDANA LEAF SPOT',
      'BLACK SIGATOKA',
      'BANANA',
      'MAIZE',
    ],
  ),
  plant(
    plantname: "SWEET POTATO",
    imageUrl: "images/pic/img2.png",
    backImage: "images/box/box2.png",
    color: kOrange,
    Diseases: [
      'Desease1',
      'Desease2',
      'Desease3',
      'LDesease4',
      'Desease5'
    ],
  ),
  plant(
    plantname: "BANANA",
    imageUrl: "images/pic/img3.png",
    backImage: "images/box/box3.png",
    color: kGreen,
    Diseases: ['Desease1', 'Desease2'],
  ),
  plant(
    plantname: "MAIZE",
    imageUrl: "images/pic/img4.png",
    backImage: "images/box/box4.png",
    color: kYellow,
    Diseases: ['Desease1'],
  ),
  plant(
    plantname: "SOYA BEANS",
    imageUrl: "images/pic/img4.png",
    backImage: "images/box/box4.png",
    color: kDarkBlue,
    Diseases: ['Desease1'],
  ),
  plant(
    plantname: "BEANS",
    imageUrl: "images/pic/img4.png",
    backImage: "images/box/box4.png",
    color: kOrange,
    Diseases: ['Desease1'],
  ),
  plant(
    plantname: "PEANUTS",
    imageUrl: "images/pic/img4.png",
    backImage: "images/box/box4.png",
    color: kGreen,
    Diseases: ['Desease1'],
  ),
  plant(
    plantname: "PINE APPLES",
    imageUrl: "images/pic/img4.png",
    backImage: "images/box/box4.png",
    color: kYellow,
    Diseases: ['Desease1'],
  )
];
