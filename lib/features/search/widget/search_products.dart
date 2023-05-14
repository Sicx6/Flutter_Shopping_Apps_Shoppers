import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_shopping_apps/common/widgets/star_rating.dart';
import 'package:flutter_shopping_apps/models/product.dart';

class SearchProduct extends StatelessWidget {
  final Product product;

  const SearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 230,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Stars(rating: avgRating),
                      ),
                      Container(
                        width: 230,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          'RM ${product.price}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 230,
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: const Text(
                          'Eligible for Free Shipping',
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
            ],
          ),
        )
      ],
    );
  }
}
