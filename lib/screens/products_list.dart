import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/screens/buy.dart';
import 'package:florida_app_store/Constants/size_config.dart';
import 'package:florida_app_store/screens/Zooimg.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  ProductsList(
      this.Category,
      this.Itemimage,
      this.Itemimage1,
      this.Itemimage2,
      this.Itemimage3,
      this.Itemname,
      this.Itemprice,
      this.Itemid,
      this.Itemdetails,
      {Key? key})
      : super(key: key) {
    late CollectionReference _reference;

    if (Category == "SHIRT") {
      _reference = FirebaseFirestore.instance.collection('shirts_list');
      _stream = _reference.snapshots();
      appbarname = 'Shirts';
    } else if (Category == "PANTS") {
      _reference = FirebaseFirestore.instance.collection('pants_list');
      _stream = _reference.snapshots();
      appbarname = 'Pants';
    } else if (Category == "SHOES") {
      _reference = FirebaseFirestore.instance.collection('shoes_list');
      _stream = _reference.snapshots();
      appbarname = 'Shoes';
    }
  }

  late Stream<QuerySnapshot> _stream;
  String appbarname = '';
  String Category = '';
  String Itemimage = '';
  String Itemimage1 = '';
  String Itemimage2 = '';
  String Itemimage3 = '';
  String Itemname = '';
  String Itemid = '';
  String Itemdetails = '';
  late num Itemprice;

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late bool showdialog;
  bool activeSearch = false;

  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> results = [];

  @override
  initState() {
    _foundUsers = items;
    showdialog = false;

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
                  colors: <Color>[
                Color.fromRGBO(255, 121, 80, 1),
                Colors.red
              ])),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Text(
              widget.appbarname,
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
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 13.0),
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(9)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search product",
                    prefixIcon: Icon(Icons.search)),
              ),
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
                                  child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          widget.Itemimage = thisItem['image'];
                                          widget.Itemimage1 =
                                              thisItem['image_1'];
                                          widget.Itemimage2 =
                                              thisItem['image_2'];
                                          widget.Itemimage3 =
                                              thisItem['image_3'];
                                          widget.Itemname = thisItem['name'];
                                          widget.Itemprice = thisItem['price'];
                                          widget.Itemid = thisItem['id'];
                                        });

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => zoom(
                                                    shirtslist: ProductsList(
                                                        "",
                                                        thisItem['image'],
                                                        thisItem['image_1'],
                                                        thisItem['image_2'],
                                                        thisItem['image_3'],
                                                        thisItem['name'],
                                                        thisItem['price'],
                                                        thisItem['id'],
                                                        thisItem['details']))));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                              fit: BoxFit.fitHeight,
                                            )),
                                      )),
                                ),
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
                                            '${thisItem['quantity']}',
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
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Muli',
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
                                              Container(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => RegisterScreen(
                                                                shirtslist: ProductsList(
                                                                    '1',
                                                                    thisItem[
                                                                        'image'],
                                                                    '',
                                                                    '',
                                                                    '',
                                                                    thisItem[
                                                                        'name'],
                                                                    thisItem[
                                                                        'price'],
                                                                    thisItem[
                                                                        'id'],
                                                                    ''))));
                                                  },
                                                  child: const Card(
                                                    color: kPrimaryColor,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        "Buy",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily: 'Muli'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    child: InkWell(
                                                  onTap: () async {
                                                    _showPicker(context,
                                                        'Added Succefully to your Cart');
                                                    await _firestore
                                                        .collection('users')
                                                        .doc(uid)
                                                        .collection('Cart')
                                                        .doc(thisItem['id'])
                                                        .set({
                                                      "id": thisItem['id'],
                                                      "name": thisItem['name'],
                                                      'price':
                                                          thisItem['price'],
                                                      'image':
                                                          thisItem['image'],
                                                      'size':
                                                          thisItem['quantity'],
                                                    });
                                                  },
                                                  child: const Card(
                                                      color: Color.fromARGB(
                                                          255, 220, 220, 220),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Center(
                                                          child: Text(
                                                            "Add to Cart",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                // fontSize: 13,
                                                                fontFamily:
                                                                    'Muli'),
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
