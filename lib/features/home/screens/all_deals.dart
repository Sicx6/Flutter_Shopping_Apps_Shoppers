import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/home/services/home_services.dart';
import 'package:flutter_shopping_apps/features/product%20details/screens/produc_details_screen.dart';
import 'package:flutter_shopping_apps/models/product.dart';

class AllDealsScreen extends StatefulWidget {
  static const String routeName = '/All-Deals';

  const AllDealsScreen({super.key});

  @override
  State<AllDealsScreen> createState() => _AllDealsScreenState();
}

class _AllDealsScreenState extends State<AllDealsScreen> {
  List<Product>? productList;

  final HomeServices homeServices = HomeServices();

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 700,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 5),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
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
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 230,
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 238, 235, 235),
                                        offset: Offset(
                                          4.0,
                                          8.0,
                                        ),
                                        blurRadius: 5.0,
                                        spreadRadius: 5.0,
                                      ),
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
                                        padding: const EdgeInsets.all(8),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 223, 246, 255),
                                        ),
                                        child: Image.network(
                                          product.images[0],
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 230,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                              style:
                                                  TextStyle(color: Colors.blue),
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
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
