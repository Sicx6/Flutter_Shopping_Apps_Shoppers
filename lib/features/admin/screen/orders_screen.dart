import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/features/account/screen/widgets/single_product.dart';
import 'package:flutter_shopping_apps/features/admin/services/admin_services.dart';
import 'package:flutter_shopping_apps/features/order%20details/orders_details.dart';
import 'package:flutter_shopping_apps/models/orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders = [];
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrdersDetails.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(img: orderData.product[0].images[0]),
                ),
              );
            });
  }
}
