// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_shopping_apps/features/home/screens/all_deals.dart';
import 'package:flutter_shopping_apps/features/home/screens/widget/recommended_deals_screen.dart';
import 'package:flutter_shopping_apps/features/home/services/home_services.dart';
import 'package:flutter_shopping_apps/features/product%20details/screens/produc_details_screen.dart';
import 'package:flutter_shopping_apps/models/product.dart';

import '../../../../common/widgets/loader.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(context, DetailScreen.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal Of The day',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'RM ${product!.price.toString()}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                          left: 15, top: 5, right: 40, bottom: 20),
                      child: Text(
                        '${product!.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recommended Product',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AllDealsScreen.routeName);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ).copyWith(
                                left: 15,
                              ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'See All Deals',
                                style: TextStyle(color: Colors.cyan[800]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RecommendProduct(
                      product: product!,
                    ),
                  ],
                ),
              );
  }
}
