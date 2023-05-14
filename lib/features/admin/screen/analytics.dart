import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/loader.dart';
import 'package:flutter_shopping_apps/features/admin/model/sales.dart';
import 'package:flutter_shopping_apps/features/admin/services/admin_services.dart';
import 'package:http/http.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    fetchEarning();
  }

  fetchEarning() async {
    var earningData = await adminServices.fetchEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'RM $totalSales',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
  }
}
