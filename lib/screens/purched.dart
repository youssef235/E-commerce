import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/Constants/enums.dart';
import 'package:florida_app_store/Constants/size_config.dart';
import 'package:flutter/material.dart';
import '../components/coustom_bottom_nav_bar.dart';

class Purched extends StatefulWidget {
  Purched({Key? key}) : super(key: key) {
    CollectionReference _reference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Purched');
    _stream = _reference.snapshots();
  }

  late Stream<QuerySnapshot> _stream;

  @override
  State<Purched> createState() => _PurchedState();
}

class _PurchedState extends State<Purched> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<bool> isChecked = List.generate(10000, (index) => false);

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
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Your purchased products',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Dance',
              fontSize: 30),
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
                itemBuilder: (context, index) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return const CircularProgressIndicator();

                  Map thisItem = items[index];

                  return thisItem.containsKey('image')
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          child: FadeInImage.assetNetwork(
                                            image: '${thisItem['image']}',
                                            placeholder:
                                                "assets/images/Loading.png",
                                            height: 190.00,
                                            width: 200.00,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Product name : ',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${thisItem['name']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      20),
                                              color: Colors.black,
                                              fontFamily: 'Muli'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Purchased quantity : ',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${thisItem['Quanity']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                getProportionateScreenWidth(20),
                                            color: Colors.black,
                                            fontFamily: 'Muli',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Total price : ',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${thisItem['price']}' + " LE",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                getProportionateScreenWidth(20),
                                            color: Colors.black,
                                            fontFamily: 'Muli',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Order request date : ',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${thisItem['orderdate']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                getProportionateScreenWidth(20),
                                            color: Colors.black,
                                            fontFamily: 'Muli',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () async {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Sure!'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                            'The order will be completely cancelled'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('Yes'),
                                                      onPressed: () async {
                                                        await _firestore
                                                            .collection('users')
                                                            .doc(uid)
                                                            .collection(
                                                                'Purched')
                                                            .doc(thisItem['id'])
                                                            .delete();

                                                        await _firestore
                                                            .collection(
                                                                'orders')
                                                            .doc(thisItem['id'])
                                                            .delete();

                                                        Navigator.of(context)
                                                            .pop();

                                                        // ignore: use_build_context_synchronously
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    bc) {
                                                              return SafeArea(
                                                                child: ListTile(
                                                                    title: const Text(
                                                                        "Order cancelled"),
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }),
                                                              );
                                                            });
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Card(
                                            color: kPrimaryColor,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5.0,
                                                  top: 3.0,
                                                  bottom: 5.0),
                                              child: Text(
                                                "Cancel order",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Muli',
                                                    fontSize: 15),
                                              ),
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
                        )
                      : Container();
                });
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }
}
