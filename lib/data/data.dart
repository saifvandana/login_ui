// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, unused_import, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final String BASEURL = 'http://192.168.0.105/localconnect/';

class Listing {
  List info;
  List<String> images;

  Listing(this.info, this.images);
}

List<String> catIds = [];
List<String> cats = [];
List<String> altCats = [];
List<String> altCatIds = [];
bool showAlt = false;

Future getCategories(List<String> _catIds, List<String> _cats) async {
  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/category/all';
  var response = await http.get(Uri.parse(url));
  var content = json.decode(response.body);
  content.forEach((s) => _catIds.add(s["pk_i_id"]));
  content.forEach((s) => _cats.add(s["s_name"]));
  catIds = _catIds;
  cats = _cats;
  // print(catIds);
  // print(cats);
}

Future getAlts(
    List<String> _altCatIds, List<String> _altCats, String category) async {
  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/category/' +
          catIds[cats.indexOf(category)];
  var response = await http.get(Uri.parse(url));
  var content = json.decode(response.body);
  content.forEach((s) => _altCatIds.add(s["pk_i_id"]));
  content.forEach((s) => _altCats.add(s["s_name"]));
  altCatIds = _altCatIds;
  altCats = _altCats;
  //showAlt = true;
  //showAlts(category);
  // print(altCatIds.isEmpty);
  // print(altCats.isEmpty);
  //print(altCatIds[altCats.indexOf(altCategory as String)]);
  //return true;
}

// void showAlts(String category) {
//   List<String> altCats = [];
//   List<String> altCatIds = [];
//   getAlts(altCatIds, altCats, category);
//   showAlt = true;
// }

class Property {
  String label;
  String name;
  String price;
  String location;
  String sqm;
  String review;
  String description;
  String frontImage;
  String ownerImage;
  List<String> images;

  Property(
      this.label,
      this.name,
      this.price,
      this.location,
      this.sqm,
      this.review,
      this.description,
      this.frontImage,
      this.ownerImage,
      this.images);
}

List<Property> getPropertyList() {
  return <Property>[
    Property(
      "SALE".tr,
      "Clinton Villa",
      "4875000.00",
      "Ankara",
      "2,456",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_01.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "RENT".tr,
      "Salu House",
      "5875000.00",
      "Mamak",
      "3,300",
      "4.6",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/images/house_04.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "RENT".tr,
      "Hilton House",
      "3891000.00",
      "Istanbul",
      "2,100",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_02.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "SALE".tr,
      "Ibe House",
      "4585000.00",
      "Antalya",
      "4,100",
      "4.5",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_03.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "SALE".tr,
      "Aventura",
      "5992000.00",
      "Istanbul",
      "3,100",
      "4.2",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_05.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "SALE".tr,
      "North House",
      "3995000.00",
      "Izmir",
      "3,700",
      "4.0",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_06.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "RENT".tr,
      "Rasmus Resident",
      "2999000.00",
      "Ankara",
      "2,700",
      "4.3",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_07.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
    Property(
      "RENT".tr,
      "Simone House",
      "3999000.00",
      "Ankara",
      "3,700",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf."
          .tr,
      "assets/images/house_08.jpg",
      "assets/images/owner.jpg",
      [
        "assets/images/kitchen.jpg",
        "assets/images/bath_room.jpg",
        "assets/images/swimming_pool.jpg",
        "assets/images/bed_room.jpg",
        "assets/images/living_room.jpg",
      ],
    ),
  ];
}

List<String> locations = [
  'Ankara',
  'Istanbul',
  'Antalya',
  'Izmir',
];

List<String> categories = [
  'Konut',
  'İşyeri'.tr,
  'Arsa'.tr,
  'Turistik İşletme'.tr,
  'Devremülk'
];

List<String> processes = [
  'Sell'.tr,
  'Rent'.tr,
  'Exchange'.tr,
  'All'.tr,
];

List<String> states = [
  'New'.tr,
  'Used'.tr,
  'All'.tr,
];

List<String> currencies = [
  "EUR",
  "GBP",
  "TRY",
  "USD",
];
