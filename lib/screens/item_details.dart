import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemDetalis extends StatefulWidget {
  ItemDetalis(this.img1, {super.key});

  String img1 = '';

  @override
  State<ItemDetalis> createState() => _ItemDetalisState();
}

class _ItemDetalisState extends State<ItemDetalis> {
  String category = "";
  bool hasBeenTpressed = false;
  bool hasBeenPpressed = false;
  bool hasBeenSpressed = false;

  final CollectionReference referenceT =
      FirebaseFirestore.instance.collection('shirts_list');
  final CollectionReference referenceP =
      FirebaseFirestore.instance.collection('pants_list');
  final CollectionReference referenceS =
      FirebaseFirestore.instance.collection('shoes_list');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'More detalis',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
