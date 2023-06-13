import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/screens/home/home_screen.dart';
import 'package:florida_app_store/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  CollectionReference _referenceS =
      FirebaseFirestore.instance.collection('users');

  String imageUrl = '';
  String? Username = 'Loading ...';
  File? _photo;
  String ProfimageUrl = '';
  late bool imageAvilable = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        Username = value.data()!["userName"];
      });
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        ProfimageUrl = value.data()!["profileimage"];
        if (value.data()!["profileimage"] != null) {
          imageAvilable = true;
        } else {
          imageAvilable = false;
        }
      });
    });

    super.initState();
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);

        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      imageUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({"profileimage": imageUrl});
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(55.0),
          child: SizedBox(
            height: 115,
            width: 115,
            child: InkWell(
              onTap: () {
                _showPicker(context);
              },
              child: imageAvilable
                  ? ClipRect(
                      child: Image.network(
                      ProfimageUrl,
                      fit: BoxFit.cover,
                    ))
                  : ClipRect(
                      child: Image.asset(
                      "assets/icons/Cadd.png",
                      fit: BoxFit.cover,
                    )),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            Username!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'Muli',
            ),
          ),
        )
      ],
    );
  }

  void _showPicker(context) {
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
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
