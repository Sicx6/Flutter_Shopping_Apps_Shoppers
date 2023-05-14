import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/home/screens/category_deals.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({Key? key}) : super(key: key);

  void navigateCategory(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDeals.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemExtent: 75,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () => navigateCategory(
                context, GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
