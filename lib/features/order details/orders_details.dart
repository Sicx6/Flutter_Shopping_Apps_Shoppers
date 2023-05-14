import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/customButton.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/admin/services/admin_services.dart';
import 'package:flutter_shopping_apps/features/search/search_screen.dart';
import 'package:flutter_shopping_apps/models/orders.dart';
import 'package:flutter_shopping_apps/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersDetails extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrdersDetails({super.key, required this.order});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
    changeOrderStatus(currentStep);
  }

  //for admin usage!!
  void changeOrderStatus(int status) async {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

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
            const Text('View Orders Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text('Order Date: ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(widget.order.orderAt),
                    )},'),
                    Text('Order ID: ${widget.order.id}'),
                    Text('Order Total Price: RM${widget.order.totalPrice}'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    for (int i = 0; i < widget.order.product.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.product[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.product[i].name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Quantity: ${widget.order.quantity[i]}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Tracking',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: ((context, details) {
                    if (user.type == 'admin') {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  }),
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text('Your Order is yet to delivered'),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                          'Your Order had been delivered, Please verify order'),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                          'Your Order had been delivered and confirmed'),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                          'Your Order had been delivered and verify'),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
