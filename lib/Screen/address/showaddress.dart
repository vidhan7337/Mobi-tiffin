import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Config/menumodel.dart';
import 'package:user_tiffin/Screen/address/addaddress.dart';
import 'package:user_tiffin/Screen/ordering/checkout.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowAddress extends StatefulWidget {
  final Menumodel kitchen;
  final Map<dynamic, dynamic> mealmodel;
  final int quantity;
  final String dilvertime;
  final String notes;
  final String price;
  final Iterable<Map<dynamic, dynamic>> otheritem;
  ShowAddress(
      {this.mealmodel,
      this.kitchen,
      this.otheritem,
      this.quantity,
      this.dilvertime,
      this.notes,
      this.price});
  @override
  _ShowAddressState createState() => _ShowAddressState();
}

class _ShowAddressState extends State<ShowAddress> {
  Stream<QuerySnapshot> a = Firestore.instance
      .collection("Users")
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection('address')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("Users")
          .document(
              EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
          .collection('address')
          .snapshots(),
      builder: (context, dataSnapshot) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Container(
                decoration: new BoxDecoration(color: carrotOrange),
              ),
              title: Text(
                AppLocalizations.of(context).selectaddress,
                style: TextStyle(color: valhalla),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < dataSnapshot.data.documents.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenwidth,
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkout(
                                            kitchen: widget.kitchen,
                                            mealmodel: widget.mealmodel,
                                            quantity: widget.quantity,
                                            dilvertime: widget.dilvertime,
                                            notes: widget.notes,
                                            otheritem: widget.otheritem,
                                            address: dataSnapshot
                                                    .data
                                                    .documents[i]
                                                    .data['flatnumber'] +
                                                ' , ' +
                                                dataSnapshot.data.documents[i]
                                                    .data['area'] +
                                                ' , ' +
                                                dataSnapshot.data.documents[i]
                                                    .data['city'] +
                                                ' , ' +
                                                dataSnapshot.data.documents[i]
                                                    .data['state'],
                                            phoneno: dataSnapshot.data
                                                .documents[i].data['phone no'],
                                            price: widget.price,
                                          )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, right: 10.0),
                                      child: Text(
                                        dataSnapshot
                                            .data.documents[i].data['title'],
                                        style: TextStyle(
                                            color: tyrianPurple,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, right: 10.0),
                                      child: Text(
                                        dataSnapshot.data.documents[i]
                                                .data['flatnumber'] +
                                            ' , ' +
                                            dataSnapshot.data.documents[i]
                                                .data['area'] +
                                            ' , ' +
                                            dataSnapshot.data.documents[i]
                                                .data['city'] +
                                            ' , ' +
                                            dataSnapshot.data.documents[i]
                                                .data['state'],
                                        style: TextStyle(
                                          color: valhalla,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, right: 10.0),
                                      child: Text(
                                        " 📞 " +
                                            dataSnapshot.data.documents[i]
                                                .data['phone no'],
                                        style: TextStyle(
                                          color: valhalla,
                                          fontSize: 17.0,
                                        ),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: tyrianPurple,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddAddress()),
                            );
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).addaddress,
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
