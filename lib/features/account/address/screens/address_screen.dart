// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/customButton.dart';
import 'package:flutter_shopping_apps/common/widgets/customTextField.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/constant/utils.dart';
import 'package:flutter_shopping_apps/features/account/address/services/address_services.dart';
import 'package:flutter_shopping_apps/features/search/search_screen.dart';
import 'package:flutter_shopping_apps/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseBuildingController = TextEditingController();
  final TextEditingController areaStreetController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController townCityBuildingController =
      TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToUsed = '';
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    houseBuildingController.dispose();
    areaStreetController.dispose();
    postcodeController.dispose();
    townCityBuildingController.dispose();
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(context: context, address: addressToUsed);
    }
    addressServices.placeOrders(
      context: context,
      address: addressToUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(context: context, address: addressToUsed);
    }
    addressServices.placeOrders(
      context: context,
      address: addressToUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressProvider) {
    addressToUsed = '';

    bool isForm = houseBuildingController.text.isNotEmpty ||
        areaStreetController.text.isNotEmpty ||
        postcodeController.text.isNotEmpty ||
        townCityBuildingController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToUsed ==
            '${houseBuildingController}, ${areaStreetController}, ${postcodeController}, ${townCityBuildingController}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressProvider.isNotEmpty) {
      addressToUsed = addressProvider;
    } else {
      showSnackBar(context, 'Error');
    }
    print(addressToUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _addressFormKey,
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            address,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                CustomTextField(
                  controller: houseBuildingController,
                  hintText: 'House/Building No.',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: areaStreetController,
                  hintText: 'Area, Street',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: postcodeController,
                  hintText: 'Postcode',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: townCityBuildingController,
                  hintText: 'Town/City',
                ),
                const SizedBox(
                  height: 10,
                ),
                GooglePayButton(
                  onPressed: () => payPressed(address),
                  width: double.infinity,
                  paymentItems: paymentItems,
                  type: GooglePayButtonType.buy,
                  onPaymentResult: onGooglePayResult,
                  paymentConfigurationAsset: 'gpay.json',
                  height: 50,
                  margin: const EdgeInsets.only(top: 15),
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ApplePayButton(
                  onPressed: () => payPressed(address),
                  style: ApplePayButtonStyle.whiteOutline,
                  width: double.infinity,
                  onPaymentResult: onApplePayResult,
                  paymentItems: paymentItems,
                  paymentConfigurationAsset: 'applepay.json',
                  height: 50,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
