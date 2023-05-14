import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shopping_apps/common/widgets/customButton.dart';
import 'package:flutter_shopping_apps/common/widgets/star_rating.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/product%20details/services/product_details_service.dart';
import 'package:flutter_shopping_apps/features/search/search_screen.dart';
import 'package:flutter_shopping_apps/models/product.dart';
import 'package:flutter_shopping_apps/provider/user_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';

  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ProductDetailService productDetailService = ProductDetailService();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;

      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailService.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search here',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(builder: (BuildContext context) {
                  return Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 400,
                  );
                });
              }).toList(),
              options: CarouselOptions(viewportFraction: 1, height: 200),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deals Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'RM ${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
                color: Color.fromARGB(250, 44, 51, 116),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  productDetailService.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
