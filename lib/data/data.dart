// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, unused_import, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Listing {
  List info;
  List<String> images;

  Listing(this.info, this.images);
}

List<String> catIds = [];
List<String> cats = [];
List<String> altCats = [];
List<String> altCatIds = [];
List<String> regionIds = [];
List<String> regions = [];
List<String> cities = [];
List<String> cityIds = [];
Map<String, List<String>> districts = {};
bool showAlt = false;
String lang = 'en'.tr;
String locale0 = 'tr', locale1 = 'Tr';

Future getCategories(List<String> _catIds, List<String> _cats) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString('locale0') != null &&
      preferences.getString('locale1') != null) {
    locale0 = preferences.getString('locale0')!;
    locale1 = preferences.getString('locale1')!;
  }

  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/category/all/' +
          locale0 +
          '_' +
          locale1;
  var response = await http.get(Uri.parse(url));
  var content = json.decode(response.body);
  content.forEach((s) => _catIds.add(s["pk_i_id"]));
  content.forEach((s) => _cats.add(s["s_name"]));
  catIds = _catIds;
  cats = _cats;
}

Future getAlts(
    List<String> _altCatIds, List<String> _altCats, String category) async {
  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/category/' +
          catIds[cats.indexOf(category)] +
          '/' +
          locale0 +
          '_' +
          locale1;
  var response = await http.get(Uri.parse(url));
  var content = json.decode(response.body);
  content.forEach((s) => _altCatIds.add(s["pk_i_id"]));
  content.forEach((s) => _altCats.add(s["s_name"]));
  altCatIds = _altCatIds;
  altCats = _altCats;
}

Future getRegions(List<String> _regions, List<String> _regionIds) async {
  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/location/region/all';
  var response = await http.get(Uri.parse(url));
  var content = json.decode(response.body);
  content.forEach((s) => _regionIds.add(s["pk_i_id"]));
  content.forEach((s) => _regions.add(s["s_name"]));
  regionIds = _regionIds;
  regions = _regions;
  //print(regionIds + regions);
}

Future getLang() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  lang = prefs.getString('locale0') as String;
  await Future.delayed(const Duration(seconds: 5), () {});
  //print(lang);
}

String getPrice(String price, String currency) {
  if (price != null) {
    if (price == "0") {
      return 'No Price'.tr;
    }
    int len = price.length;
    len = len - 6;
    getLang();
    if (lang == 'tr') {
      String str = price.substring(0, len);
      if (len > 3 && len < 7) {
        str = str.substring(0, len - 3) + '.' + str.substring(len - 3, len);
      } else if (len >= 7 && len < 10) {
        str = str.substring(0, len - 6) +
            '.' +
            str.substring(len - 6, len - 3) +
            '.' +
            str.substring(len - 3, len);
      } else if (len >= 10 && len < 13) {
        str = str.substring(0, len - 9) +
            '.' +
            str.substring(len - 9, len - 6) +
            '.' +
            str.substring(len - 6, len - 3) +
            '.' +
            str.substring(len - 3, len);
      }
      //print(str + currency);
      return (currency == 'TRY') ? str + ' TL' : str + ' ' + currency;
    } else {
      return (currency == 'TRY')
          ? price.substring(0, len) + ' TL'
          : price.substring(0, len) + ' ' + currency;
    }
  } else {
    return "500 TL";
  }
}

Future getProperties() async {
  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/attr/130';
  var response = await http.get(Uri.parse(url));
  var content = json.decode(response.body);
  print(content);
  if (content.length != 0) {
    for (int i = 0; i < content.length; i++) {}
  }
}

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

List<String> categories = [
  'Konut'.tr,
  'İşyeri'.tr,
  'Arsa'.tr,
  'Turistik İşletme'.tr,
  'Devremülk'.tr
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

List<String> systemLanguages = [
  "en_US",
  "tr_TR",
  "de_DE",
];
