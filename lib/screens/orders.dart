import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/Constants/size_config.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key) {
    CollectionReference _reference =
        FirebaseFirestore.instance.collection('orders');
    _stream = _reference.snapshots();
  }

  late Stream<QuerySnapshot> _stream;

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
  }

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
        title: const Text(
          "Orders",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Dance'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget._stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            List<Map> items = documents.map((e) => e.data() as Map).toList();

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  Map thisItem = items[index];
                  return thisItem.containsKey('image')
                      ? Card(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: FadeInImage.assetNetwork(
                                        image: '${thisItem['image']}',
                                        placeholder:
                                            "assets/images/Loading.png",
                                        height: 150.00,
                                        width: 100.00,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  '${thisItem['customer name']}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            18),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  '${thisItem['customer phone']}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            18),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  '${thisItem['customer adress']}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            18),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  '${thisItem['orderdate']}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            18),
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  '${thisItem['Quanity']} items with total price ${thisItem['price']} LE',
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            18),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Card(
                                                color: kPrimaryColor,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0,
                                                      right: 15.0,
                                                      top: 3.0,
                                                      bottom: 5.0),
                                                  child: Center(
                                                    child: Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Muli',
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
