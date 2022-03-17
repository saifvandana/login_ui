import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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

  Property(this.label, this.name, this.price, this.location, this.sqm, this.review, this.description, this.frontImage, this.ownerImage, this.images);

}

List<Property> getPropertyList(){
  return <Property>[
    Property(
      "SALE".tr,
      "Clinton Villa",
      "3,5000.00",
      "Ankara",
      "2,456",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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
      "3,5000.00",
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
      "3,1000.00",
      "Istanbul",
      "2,100",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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
      "4,5000.00",
      "Antalya",
      "4,100",
      "4.5",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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
      "5,2000.00",
      "Istanbul",
      "3,100",
      "4.2",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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
      "3,5000.00",
      "Izmir",
      "3,700",
      "4.0",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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
      "2,9000.00",
      "Ankara",
      "2,700",
      "4.3",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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
      "3,9000.00",
      "Ankara",
      "3,700",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.".tr,
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

List categories = [
  {
    "name" : "All".tr,
    "icon" :  FontAwesomeIcons.boxes
  },
  // {
  //   "name" : "Villa",
  //   "icon" :  FontAwesomeIcons.university
  // },
  // {
  //   "name" : "Shop",
  //   "icon" :  FontAwesomeIcons.storeAlt
  // },
  // {
  //   "name" : "Building",
  //   "icon" :  FontAwesomeIcons.building
  // },
  {
    "name" : "Rent".tr,
    "icon" :  FontAwesomeIcons.home
  },
  {
    "name" : "Buy".tr,
    "icon" :  FontAwesomeIcons.building
  },
];