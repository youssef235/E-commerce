import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/Constants/enums.dart';
import 'package:florida_app_store/screens/buy.dart';
import 'package:florida_app_store/screens/products_list.dart';
import 'package:florida_app_store/Constants/size_config.dart';
import 'package:flutter/material.dart';
import '../components/coustom_bottom_nav_bar.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key) {
    CollectionReference _reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Cart');
    _stream = _reference.snapshots();
  }

  late Stream<QuerySnapshot> _stream;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late bool showdialog;
  bool activeSearch = false;
  num sum = 0.0;
  int products = 0;

  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> results = [];
  List<Map<String, dynamic>> totalprice = [];

  @override
  initState() {
    _foundUsers = items;
    showdialog = false;
    _numProduct();
    _sumCarta();
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      results = items;
    } else {
      results = items
          .where((item) =>
              item["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      activeSearch = true;
      _foundUsers = results;
    });
  }

  Future _sumCarta() async {
    await _firestore
        .collection("users")
        .doc(uid!)
        .collection('Cart')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        setState(() {
          num value = element.data()["price"];
          sum = sum + value;
        });
      });
    });
    print(sum);
  }

  Future _numProduct() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid!)
        .collection('Cart')
        .get()
        .then((value) => {products = value.docs.length});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xFFFF7950), Colors.red])),
        ),
        // backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Dance',
                  fontSize: 30),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 20, bottom: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Subtotal ",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      Text(
                        '$sum',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const Text(
                        "EGP",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen(
                                        shirtslist: ProductsList(
                                            '2',
                                            '',
                                            products.toString(),
                                            '',
                                            '',
                                            "",
                                            sum,
                                            "",
                                            ''))));
                          },
                          child: Card(
                            color: kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  "Proceed to Buy ($products items) ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      fontFamily: 'Muli'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(color: Colors.black),
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget._stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Some error occurred ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                  items = documents
                      .map((e) => e.data() as Map<String, dynamic>)
                      .toList();

                  if (!activeSearch) {
                    _foundUsers = items;
                  }
                  return ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, Index) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return CircularProgressIndicator();

                        Map thisItem = _foundUsers[Index];

                        return thisItem.containsKey('image')
                            ? Row(children: [
                                Card(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: FadeInImage.assetNetwork(
                                        image: '${thisItem['image']}',
                                        placeholder:
                                            "assets/images/Loading.png",
                                        height: 190.00,
                                        width: 200.00,
                                      )),
                                )),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Text(
                                            '${thisItem['name']}',
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      18),
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${thisItem['size']}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${thisItem['price']}' " LE",
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      18),
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFFFA53E),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                    child: InkWell(
                                                  onTap: () async {
                                                    await _firestore
                                                        .collection('users')
                                                        .doc(uid)
                                                        .collection('Cart')
                                                        .doc(thisItem['id'])
                                                        .delete();
                                                    _showPicker(context,
                                                        "Removed from Cart");
                                                  },
                                                  child: const Card(
                                                      color: Color.fromARGB(
                                                          255, 207, 206, 206),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Center(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Remove from cart",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Muli'),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ])
                            : Container();
                      });
                }

                //Show loader
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }

  void _showPicker(context, String msg) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: ListTile(
                title: Text(msg),
                onTap: () {
                  Navigator.of(context).pop();
                }),
          );
        });
  }
}
