import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/account/screen/widgets/single_product.dart';
import 'package:flutter_shopping_apps/features/account/servicers/account_services.dart';
import 'package:flutter_shopping_apps/features/order%20details/orders_details.dart';
import 'package:flutter_shopping_apps/models/orders.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // List list = [
  //   'https://images.unsplash.com/photo-1680550032276-298a81250925?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  //   'https://images.unsplash.com/photo-1680550032276-298a81250925?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  //   'https://images.unsplash.com/photo-1680550032276-298a81250925?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  //   'https://images.unsplash.com/photo-1680550032276-298a81250925?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  // ];

  List<Order>? orderList;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orderList = await accountServices.fetchMyOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 18,
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orderList!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrdersDetails.routeName,
                            arguments: orderList![index]);
                      },
                      child: SingleProduct(
                          img: orderList![index].product[0].images[0]),
                    );
                  }),
                ),
              ),
            ],
          );
  }
}
