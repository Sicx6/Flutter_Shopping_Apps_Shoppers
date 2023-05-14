import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/home/services/home_services.dart';
import 'package:flutter_shopping_apps/features/product%20details/screens/produc_details_screen.dart';
import 'package:flutter_shopping_apps/models/product.dart';

class CategoryDeals extends StatefulWidget {
  static const String routeName = '/category-Deals';

  final String category;
  const CategoryDeals({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    productList = await homeServices.fetchCategoryProduct(
        context: context, category: widget.category);

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
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep Shopping for ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product.images[0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
