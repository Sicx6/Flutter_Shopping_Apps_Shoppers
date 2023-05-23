import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/features/home/services/home_services.dart';
import 'package:flutter_shopping_apps/models/product.dart';

import '../../../product details/screens/produc_details_screen.dart';

class RecommendProduct extends StatefulWidget {
  Product product;
  RecommendProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<RecommendProduct> createState() => _RecommendProductState();
}

class _RecommendProductState extends State<RecommendProduct> {
  List<Product>? productList;

  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();

    allDeals();
  }

  allDeals() async {
    productList = await homeServices.AllDeals(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (productList == null) {
      return Loader();
    }
    return SizedBox(
      height: 400,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList!.length >= 4 ? 4 : productList!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) {
            final product = productList![index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailScreen.routeName,
                  arguments: product,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //     color: Color.fromARGB(255, 212, 211, 211)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 238, 235, 235),
                              offset: Offset(
                                4.0,
                                8.0,
                              ),
                              blurRadius: 9.0,
                              spreadRadius: 1.5,
                            ),
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 255, 255),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 223, 246, 255),
                              ),
                              child: Image.network(
                                product.images[0],
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 230,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 230,
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 5,
                                  ),
                                  child: Text(
                                    'Rm ${product.price}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 230,
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: const Text(
                                    'In Stock',
                                    style: TextStyle(color: Colors.blue),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
