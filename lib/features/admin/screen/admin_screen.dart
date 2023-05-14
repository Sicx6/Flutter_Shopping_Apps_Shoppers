import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/admin/screen/analytics.dart';
import 'package:flutter_shopping_apps/features/admin/screen/orders_screen.dart';
import 'package:flutter_shopping_apps/features/admin/screen/post_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostScreen(),
    const AnalyticScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 120,
                  color: Colors.black,
                ),
              ),
              const Text(
                'admin',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ],
          ),
        ),
      ),
      body: Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          iconSize: 23,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth,
                      ),
                    ),
                  ),
                  child: const Icon(Icons.inbox_outlined)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
