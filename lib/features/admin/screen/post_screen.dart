import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/features/account/screen/widgets/single_product.dart';
import 'package:flutter_shopping_apps/features/admin/screen/add_products_screen.dart';
import 'package:flutter_shopping_apps/features/admin/services/admin_services.dart';
import 'package:flutter_shopping_apps/models/product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(img: productData.images[0]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  deleteProduct(productData, index);
                                },
                                icon: const Icon(Icons.delete_outline)),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateAddProduct,
              tooltip: 'Add a Products',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
