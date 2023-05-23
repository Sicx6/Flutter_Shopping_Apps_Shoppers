import 'package:flutter/material.dart';

String uri = 'http://192.168.1.220:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 149, 234, 255),
      Color.fromARGB(255, 223, 246, 255),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(92, 198, 224, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 80, 82, 235);
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/iphone.png',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/hygiene.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliance.png',
    },
    {
      'title': 'Books',
      'image': 'assets/images/book-stack.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/dress.png',
    },
  ];
}
