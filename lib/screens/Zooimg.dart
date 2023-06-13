import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/screens/buy.dart';
import 'package:florida_app_store/screens/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class zoom extends StatefulWidget {
  final ProductsList shirtslist;

  const zoom({super.key, required this.shirtslist});

  @override
  State<zoom> createState() => _zoomState();
}

late int id;
String BIGimg = "";
String MAINimg = "";
String SM1 = "";
String SM2 = "";
String SM3 = "";
String name = "";
String itemId = "";
String detalis = "";
num price = 0;
IconData? _selectedIcon;
double _initialRating = 2.0;
bool _isVertical = false;
late List<String> Images = [];
late double _rating;
int _ratingBarMode = 1;

class _zoomState extends State<zoom> {
  @override
  void initState() {
    EasyLoading.dismiss();
    _rating = _initialRating;
    Images = [
      widget.shirtslist.Itemimage,
      widget.shirtslist.Itemimage1,
      widget.shirtslist.Itemimage2,
      widget.shirtslist.Itemimage3
    ];
    id = 0;
    MAINimg = Images[id];
    SM1 = Images[1];
    SM2 = Images[2];
    SM3 = Images[3];
    BIGimg = Images[id];
    name = widget.shirtslist.Itemname;
    price = widget.shirtslist.Itemprice;
    itemId = widget.shirtslist.Itemid;
    detalis = widget.shirtslist.Itemdetails;
    super.initState();
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
        title: Text(
          widget.shirtslist.Itemname,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Dance'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          if (id == 0) {
                          } else {
                            setState(() {
                              id = id - 1;
                              BIGimg = Images[id];
                            });
                          }
                        },
                        child: Tab(
                          icon: Image.asset("assets/images/Dleft.png"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/Loading.png",
                      image: BIGimg,
                      height: 200.00,
                      width: 200.00,
                      fit: BoxFit.contain,
                    )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          if (id == 3) {
                          } else {
                            setState(() {
                              id = id + 1;
                              BIGimg = Images[id];
                            });
                          }
                        },
                        child: Tab(
                          icon: Image.asset("assets/images/Dright.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 105, left: 105),
              child: Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipOval(
                          child: Container(
                              height: BIGimg == MAINimg ? 50 : 10,
                              width: BIGimg == MAINimg ? 50 : 10,
                              color: Colors.black,
                              child: FadeInImage.assetNetwork(
                                image: MAINimg,
                                placeholder: "assets/images/Loading.png",
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipOval(
                        child: Container(
                            height: BIGimg == SM1 ? 50 : 10,
                            width: BIGimg == SM1 ? 50 : 10,
                            color: Colors.black,
                            child: FadeInImage.assetNetwork(
                              image: SM1,
                              placeholder: "assets/images/Loading.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipOval(
                        child: Container(
                            height: BIGimg == SM2 ? 50 : 10,
                            width: BIGimg == SM2 ? 50 : 10,
                            color: Colors.black,
                            child: FadeInImage.assetNetwork(
                              image: SM2,
                              placeholder: "assets/images/Loading.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        height: BIGimg == SM3 ? 50 : 10,
                        width: BIGimg == SM3 ? 50 : 10,
                        color: Colors.black,
                        child: FadeInImage.assetNetwork(
                          image: SM3,
                          placeholder: "assets/images/Loading.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            //  _heading('Rating Bar'),
            _ratingBar(_ratingBarMode),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Card(
                            color: const Color.fromARGB(255, 238, 238, 238),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Detalies : ',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Muli"),
                                  ),
                                  Expanded(
                                    child: Text(
                                      detalis,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Muli"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen(
                                        shirtslist: ProductsList(
                                            '1',
                                            MAINimg,
                                            '',
                                            '',
                                            '',
                                            name,
                                            price,
                                            itemId,
                                            ''))));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 35, right: 35, top: 10, bottom: 15),
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Muli',
                                  fontSize: 20),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(int mode) {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 30.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
