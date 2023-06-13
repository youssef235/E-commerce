// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/modules/payment/ref_code_screen.dart';
import 'package:florida_app_store/modules/payment/visa_screen.dart';
import 'package:florida_app_store/modules/widgets/show_snack.dart';
import 'package:florida_app_store/screens/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../payment_core/components/component_screen.dart';
import '../modules/payment/cubit/cubit.dart';
import '../modules/payment/cubit/state.dart';
import '../modules/widgets/default_button.dart';
import '../modules/widgets/default_textformfiled.dart';

class RegisterScreen extends StatefulWidget {
  final ProductsList shirtslist;

  RegisterScreen({Key? key, required this.shirtslist}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController adressController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  String img = "";
  String itemName = "";
  String itemid = "";
  String cORp = "";
  bool product = true;
  late num price;
  late num totalprice;
  int itemNum = 1;
  String quantity = "";

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cORp = widget.shirtslist.Category;
    quantity = widget.shirtslist.Itemimage1;
    img = widget.shirtslist.Itemimage;
    price = widget.shirtslist.Itemprice;
    itemName = widget.shirtslist.Itemname;
    itemid = widget.shirtslist.Itemid;
    if (cORp == "1") {
      setState(() {
        product = true;
      });
    } else if (cORp == "2") {
      setState(() {
        img = "https://i.postimg.cc/1XBZfy17/Cart.jpg";
        itemid = " ";
        itemName = " ";
        product = false;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit()..getAuthToken(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 25,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Color(0xFFFF7950), Colors.red])),
          ),
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Buy Now',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Dance',
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<PaymentCubit, PaymentStates>(
          listener: (context, state) {
            if (state is PaymentRequestTokenSuccessStates) {
              showSnackBar(
                context: context,
                text: 'Success get final token',
                color: Colors.green,
              );
              //  navigateTo(context, const ToggleScreen());
            }
          },
          builder: (context, state) {
            var cubit = PaymentCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: product == true,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        itemNum = itemNum + 1;
                                        totalprice = price * itemNum;
                                      });
                                    },
                                    child: Tab(
                                      icon:
                                          Image.asset("assets/images/ado.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                  child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/Loading.png",
                                image: img,
                                height: 200.00,
                                width: 200.00,
                                fit: BoxFit.fitHeight,
                              )),
                            ),
                            Expanded(
                              child: Visibility(
                                visible: product == true,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (itemNum == 1) {
                                        } else {
                                          itemNum = itemNum - 1;
                                          totalprice = price * itemNum;
                                        }
                                      });
                                    },
                                    child: Tab(
                                      icon:
                                          Image.asset("assets/images/mio.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: const Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Quantity :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3.0, left: 3.0),
                                    child: product
                                        ? Text(
                                            '$itemNum',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Muli',
                                                fontSize: 28,
                                                color: kPrimaryColor),
                                          )
                                        : Text(
                                            quantity,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Muli',
                                                fontSize: 28,
                                                color: kPrimaryColor),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Total price =  ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Muli',

                                        fontSize: 21,
                                        //   color: kPrimaryColor
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${price * itemNum} LE",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        fontFamily: 'Muli',
                                        color: kPrimaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DefaultTextFormFiled(
                                  controller: firstNameController,
                                  type: TextInputType.name,
                                  hintText: 'First name',
                                  prefix: Icons.person,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your first name!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DefaultTextFormFiled(
                                  controller: lastNameController,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your last name !';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.name,
                                  hintText: 'Last name',
                                  prefix: Icons.person,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DefaultTextFormFiled(
                            controller: emailController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email  !';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                            hintText: 'Email',
                            prefix: Icons.email,
                          ),
                          const SizedBox(height: 10),
                          DefaultTextFormFiled(
                            controller: phoneController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone !';
                              }
                              return null;
                            },
                            type: TextInputType.number,
                            hintText: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 10),
                          DefaultTextFormFiled(
                            controller: adressController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your adress !';
                              }
                              return null;
                            },
                            type: TextInputType.streetAddress,
                            hintText: 'Adress',
                            prefix: Icons.maps_home_work_rounded,
                          ),
                          const SizedBox(height: 20),
                          DefaultButton(
                            buttonWidget:
                                state is! PaymentRequestTokenLoadingStates
                                    ? const Text(
                                        'Buy now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          letterSpacing: 1.6,
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.getOrderRegistrationID(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  price: '${price * itemNum}',
                                  adress: adressController.text,
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0)), //this right here
                                        child: Container(
                                          height: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Choose payment method : ',
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    var date = DateTime.now();
                                                    var dateformat =
                                                        "${date.year}-${date.month}-${date.day}";

                                                    await _firestore
                                                        .collection('users')
                                                        .doc(uid)
                                                        .collection('Purched')
                                                        .doc(product
                                                            ? uid! + itemid
                                                            : uid! +
                                                                quantity +
                                                                (price *
                                                                        itemNum)
                                                                    .toString())
                                                        .set({
                                                      "id": product
                                                          ? uid! + itemid
                                                          : uid! +
                                                              quantity +
                                                              (price * itemNum)
                                                                  .toString(),
                                                      "Quanity": product
                                                          ? itemNum
                                                          : quantity,
                                                      "name": product
                                                          ? itemName
                                                          : "Cart",
                                                      'price': price * itemNum,
                                                      'image': img,
                                                      'orderdate': dateformat
                                                    });
                                                    await _firestore
                                                        .collection('orders')
                                                        .doc(product
                                                            ? uid! + itemid
                                                            : uid! +
                                                                quantity +
                                                                (price *
                                                                        itemNum)
                                                                    .toString())
                                                        .set({
                                                      "customer name":
                                                          firstNameController
                                                                  .text +
                                                              " " +
                                                              lastNameController
                                                                  .text,
                                                      "Userid": uid,
                                                      "customer adress":
                                                          adressController.text,
                                                      "customer phone":
                                                          phoneController.text,
                                                      "id": product
                                                          ? uid! + itemid
                                                          : uid! +
                                                              quantity +
                                                              (price * itemNum)
                                                                  .toString(),
                                                      "Quanity": product
                                                          ? itemNum
                                                          : quantity,
                                                      "name": product
                                                          ? itemName
                                                          : "Cart",
                                                      'price': price * itemNum,
                                                      'orderdate': dateformat,
                                                      'image': img,
                                                    });
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                    _showAlertDialog();
                                                  },
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child: Image.asset(
                                                                "assets/images/payment-method.png"),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          const Text(
                                                            "Cash",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "Muli"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                InkWell(
                                                  onTap: () =>
                                                      navigateAndFinish(context,
                                                          const VisaScreen()),
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child: Image.asset(
                                                                "assets/images/credit-card.png"),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          const Text(
                                                            "Credit-card",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "Muli"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                InkWell(
                                                  onTap: () {
                                                    cubit.getRefCode();

                                                    navigateAndFinish(context,
                                                        const ReferenceScreen());
                                                  },
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child: Image.asset(
                                                                "assets/images/ref.png"),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          const Text(
                                                            "Ref Code",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "Muli"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                            width: MediaQuery.of(context).size.width,
                            radius: 10.0,
                            backgroundColor: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Purchase completed successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Check your Purchased products for more detalies'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
