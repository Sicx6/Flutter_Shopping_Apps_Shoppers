import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/features/account/address/screens/address_screen.dart';
import 'package:flutter_shopping_apps/features/auth/screens/auth_screen.dart';
import 'package:flutter_shopping_apps/features/home/screens/all_deals.dart';
import 'package:flutter_shopping_apps/features/home/screens/category_deals.dart';
import 'package:flutter_shopping_apps/features/order%20details/orders_details.dart';
import 'package:flutter_shopping_apps/features/product%20details/screens/produc_details_screen.dart';
import 'package:flutter_shopping_apps/features/search/search_screen.dart';
import 'package:flutter_shopping_apps/models/orders.dart';
import 'package:flutter_shopping_apps/models/product.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/admin/screen/add_products_screen.dart';
import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDeals.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDeals(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var search = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: search,
        ),
      );
    case DetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrdersDetails.routeName:
      var orders = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrdersDetails(
          order: orders,
        ),
      );
    case AllDealsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AllDealsScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen not available'),
          ),
        ),
      );
  }
}
