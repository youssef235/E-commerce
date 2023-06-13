import 'dart:io';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDetails = TextEditingController();

  String category = "";
  int price = 0;
  bool _hasBeenTpressed = false;
  bool _hasBeenPpressed = false;
  bool _hasBeenSpressed = false;

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _referenceT =
      FirebaseFirestore.instance.collection('shirts_list');
  final CollectionReference _referenceP =
      FirebaseFirestore.instance.collection('pants_list');
  final CollectionReference _referenceS =
      FirebaseFirestore.instance.collection('shoes_list');

  String imageUrl = '';
  String imageUrl_1 = '';
  String imageUrl_2 = '';
  String imageUrl_3 = '';
  File? _photo, _photo1, _photo2, _photo3;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(int check) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null && check == 1) {
        _photo = File(pickedFile.path);
        uploadFile(check);
      } else if (pickedFile != null && check == 2) {
        _photo1 = File(pickedFile.path);
        uploadFile(check);
      }
      if (pickedFile != null && check == 3) {
        _photo2 = File(pickedFile.path);
        uploadFile(check);
      }
      if (pickedFile != null && check == 4) {
        _photo3 = File(pickedFile.path);
        uploadFile(check);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future imgFromCamera(int check) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null && check == 1) {
        _photo = File(pickedFile.path);
        uploadFile(check);
      } else if (pickedFile != null && check == 2) {
        _photo1 = File(pickedFile.path);
        uploadFile(check);
      }
      if (pickedFile != null && check == 3) {
        _photo2 = File(pickedFile.path);
        uploadFile(check);
      }
      if (pickedFile != null && check == 4) {
        _photo3 = File(pickedFile.path);
        uploadFile(check);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future uploadFile(int check) async {
    if (_photo == null) return;

    try {
      if (check == 1 && _photo != null) {
        final fileName = basename(_photo!.path);
        final destination = 'files/$fileName';
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/');
        await ref.putFile(_photo!);
        imageUrl = await ref.getDownloadURL();
      } else if (check == 2 && _photo1 != null) {
        final fileName1 = basename(_photo1!.path);
        final destination1 = 'files/$fileName1';
        final ref1 = firebase_storage.FirebaseStorage.instance
            .ref(destination1)
            .child('file/');
        await ref1.putFile(_photo1!);
        imageUrl_1 = await ref1.getDownloadURL();
      } else if (check == 3 && _photo2 != null) {
        final fileName2 = basename(_photo2!.path);
        final destination2 = 'files/$fileName2';
        final ref2 = firebase_storage.FirebaseStorage.instance
            .ref(destination2)
            .child('file/');
        await ref2.putFile(_photo2!);
        imageUrl_2 = await ref2.getDownloadURL();
      } else if (check == 4 && _photo3 != null) {
        final fileName3 = basename(_photo3!.path);
        final destination3 = 'files/$fileName3';
        final ref3 = firebase_storage.FirebaseStorage.instance
            .ref(destination3)
            .child('file/');
        await ref3.putFile(_photo3!);
        imageUrl_3 = await ref3.getDownloadURL();
      }
    } catch (e) {
      if (kDebugMode) {
        print('error occured');
      }
    }
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
        title: const Text(
          "Add an item",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Dance'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ClipRRect(
                    child: _photo != null
                        ? ClipRRect(
                            child: Image.file(
                              _photo!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 231, 231),
                                borderRadius: BorderRadius.circular(25)),
                            width: 100,
                            height: 100,
                            child: IconButton(
                                onPressed: () async {
                                  _showPicker(context, 1);
                                },
                                icon: const Icon(Icons.add_a_photo_outlined))),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 90, left: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          child: _photo1 != null
                              ? ClipRRect(
                                  child: Image.file(
                                    _photo1!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 232, 231, 231),
                                      borderRadius: BorderRadius.circular(15)),
                                  width: 50,
                                  height: 50,
                                  child: IconButton(
                                      onPressed: () async {
                                        _showPicker(context, 2);
                                      },
                                      icon: const Icon(
                                          Icons.add_a_photo_outlined))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          child: _photo2 != null
                              ? ClipRRect(
                                  child: Image.file(
                                    _photo2!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 232, 231, 231),
                                      borderRadius: BorderRadius.circular(15)),
                                  width: 50,
                                  height: 50,
                                  child: IconButton(
                                      onPressed: () async {
                                        _showPicker(context, 3);
                                      },
                                      icon: const Icon(
                                          Icons.add_a_photo_outlined))),
                        ),
                      ),
                      ClipRRect(
                        child: _photo3 != null
                            ? ClipRRect(
                                child: Image.file(
                                  _photo3!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 232, 231, 231),
                                    borderRadius: BorderRadius.circular(15)),
                                width: 50,
                                height: 50,
                                child: IconButton(
                                    onPressed: () async {
                                      _showPicker(context, 4);
                                    },
                                    icon: const Icon(
                                        Icons.add_a_photo_outlined))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _controllerName,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    labelText: "Item Name",
                    hintText: ("Maximum 20 characters"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Item Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _controllerQuantity,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: InputDecoration(
                    labelText: "Item Size",
                    hintText: ("Maximum 8 characters"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Item Size cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _controllerPrice,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                  ],
                  decoration: InputDecoration(
                    labelText: "Item Price",
                    hintText: ("Maximum 5 characters"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  onChanged: (value) {
                    price = int.parse(value);
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Item Price cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _controllerDetails,
                  decoration: InputDecoration(
                    labelText: "More details",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  onChanged: (value) {
                    price = int.parse(value);
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Details cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hasBeenTpressed
                              ? Colors.deepOrange
                              : const Color.fromARGB(
                                  255, 189, 135, 119), // Background color
                        ),
                        onPressed: () {
                          setState(() {
                            _hasBeenPpressed = false;
                            _hasBeenSpressed = false;
                            _hasBeenTpressed = !_hasBeenTpressed;
                            category = "T-shirt";
                          });
                        },
                        child: const Text('T-shirt'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hasBeenPpressed
                              ? Colors.deepOrange
                              : const Color.fromARGB(
                                  255, 189, 135, 119), // Background color
                        ),
                        onPressed: () {
                          setState(() {
                            _hasBeenTpressed = false;
                            _hasBeenSpressed = false;
                            _hasBeenPpressed = !_hasBeenPpressed;
                            category = "Pants";
                          });
                        },
                        child: const Text('Pants'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hasBeenSpressed
                              ? Colors.deepOrange
                              : const Color.fromARGB(255, 189, 135, 119),
                          // Background color
                        ),
                        onPressed: () {
                          setState(() {
                            _hasBeenPpressed = false;
                            _hasBeenTpressed = false;
                            _hasBeenSpressed = !_hasBeenSpressed;
                            category = "Shoes";
                          });
                        },
                        child: const Text('Shoes'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)),
                    ),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        String id = const Uuid().v1();
                        String itemName = _controllerName.text;
                        String itemQuantity = _controllerQuantity.text;
                        String itemDetails = _controllerDetails.text;

                        Map<String, dynamic> dataToSend = {
                          'id': id,
                          'name': itemName,
                          'quantity': itemQuantity,
                          'price': price,
                          'details': itemDetails,
                          'image': imageUrl,
                          'image_1': imageUrl_1,
                          'image_2': imageUrl_2,
                          'image_3': imageUrl_3,
                        };
                        if (_photo == null ||
                            _photo1 == null ||
                            _photo2 == null ||
                            _photo3 == null) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Wrap(
                                    children: const <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.error),
                                        title:
                                            Text('Error : Select all photos'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else if (_hasBeenPpressed == false &&
                            _hasBeenTpressed == false &&
                            _hasBeenSpressed == false) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Wrap(
                                    children: const <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.error),
                                        title: Text(
                                            'Error : Choose item Category'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else if (category.contains("T-shirt")) {
                          _referenceT.add(dataToSend);
                          Navigator.of(context).pop();
                        } else if (category.contains("Pants")) {
                          _referenceP.add(dataToSend);
                          Navigator.of(context).pop();
                        } else if (category.contains("Shoes")) {
                          _referenceS.add(dataToSend);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context, int check) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery(check);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera(check);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
