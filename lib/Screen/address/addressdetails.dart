import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Config/menumodel.dart';
import 'package:user_tiffin/Screen/address/addaddress.dart';
import 'package:user_tiffin/Screen/address/editaddress.dart';
import 'package:user_tiffin/Screen/ordering/checkout.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateAddress extends StatefulWidget {
  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  @override
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
                AppLocalizations.of(context).youraddress,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: screenwidth / 3,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: tyrianPurple,
                                                    width: 1.0)),
                                            child: FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditAddress(
                                                              model: dataSnapshot
                                                                  .data
                                                                  .documents[i]
                                                                  .data,
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .edit,
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: screenwidth / 3,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: red, width: 1.0)),
                                            child: FlatButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (c) {
                                                        return AlertDialog(
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .suredelete),
                                                          actions: <Widget>[
                                                            RaisedButton(
                                                              onPressed: () {
                                                                Firestore
                                                                    .instance
                                                                    .collection(
                                                                        "Users")
                                                                    .document(EcommerceApp
                                                                        .sharedPreferences
                                                                        .getString(EcommerceApp
                                                                            .userUID))
                                                                    .collection(
                                                                        "address")
                                                                    .document(dataSnapshot
                                                                        .data
                                                                        .documents[
                                                                            i]
                                                                        .documentID)
                                                                    .delete();
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      AppLocalizations.of(
                                                                              context)
                                                                          .addressdeleted),
                                                                ));
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .yes),
                                                              ),
                                                            ),
                                                            RaisedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .no),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .delete,
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                )),
                                          ),
                                        ),
                                      ],
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
                            Route route =
                                MaterialPageRoute(builder: (_) => AddAddress());
                            Navigator.pushReplacement(context, route);
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).addaddress,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
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
