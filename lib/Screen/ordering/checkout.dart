import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Config/menumodel.dart';
import 'package:user_tiffin/DialogBox/loading.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Screen/myorders.dart';
import 'package:user_tiffin/Screen/providerdetail.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Checkout extends StatefulWidget {
  final Menumodel kitchen;
  final Map<dynamic, dynamic> mealmodel;
  final int quantity;
  final String dilvertime;
  final String notes;
  final String address;
  final String phoneno;
  final Iterable<Map<dynamic, dynamic>> otheritem;
  final String price;
  Checkout(
      {this.mealmodel,
      this.kitchen,
      this.otheritem,
      this.quantity,
      this.dilvertime,
      this.notes,
      this.address,
      this.phoneno,
      this.price});
  @override
  _CheckoutState createState() => _CheckoutState();
}

enum Paymentoption { cash_on_delivery, online }

class _CheckoutState extends State<Checkout> {
  Paymentoption _type = Paymentoption.cash_on_delivery;
  bool uploading = false;
  String a = "COD";
  List<Map<dynamic, dynamic>> orderitem =
      List<Map<dynamic, dynamic>>.empty(growable: true);
  DocumentReference docs = Firestore.instance.collection('Orders').document();
  uploadorder(String b) async {
    await docs.setData({
      "c_id": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      "c_name": EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
      "c_phone": widget.phoneno,
      "c_address": widget.address,
      "sp_id": widget.kitchen.uid,
      "sp_name": widget.kitchen.kitchenName,
      "sp_phone": widget.kitchen.phoneNo,
      "sp_address": widget.kitchen.address,
      "order_totalprice": int.parse(widget.price),
      "time_slot": widget.dilvertime,
      "payment_option": b,
      if (b == "Online") "payment_status": "Done",
      if (b == "COD") "payment_status": "Pending",
      "order_status": "1",
      "rejection_reason": null,
      "notes": widget.notes,
      "publishedDate": DateTime.now(),
      "kitchen_image": widget.kitchen.url,
      "id": docs.documentID
    });
  }

  additemdata() async {
    // List ordertitle = [title];
    // List orderdes = [des];
    // List orderprice = [price];
    // List orderquantity = [quantity];
    // List orderimage = [img];
    await docs.updateData({
      // "order_itemimage": FieldValue.arrayUnion(orderimage),
      // "order_itemdescription": FieldValue.arrayUnion(orderdes),
      // "order_itemprice": FieldValue.arrayUnion(orderprice),
      // "order_itemtitle": FieldValue.arrayUnion(ordertitle),
      // "order_itemquantity": FieldValue.arrayUnion(orderquantity)
      "order_item": FieldValue.arrayUnion(orderitem)
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
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
          AppLocalizations.of(context).checkout,
          style: TextStyle(color: valhalla),
        ),
      ),
      body: uploading
          ? LoadingDialog()
          : Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  AppLocalizations.of(context).payoption,
                                  style: TextStyle(
                                      color: tyrianPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).cod,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            leading: Container(
                              width: screenwidth / 6,
                              child: Radio<Paymentoption>(
                                value: Paymentoption.cash_on_delivery,
                                autofocus: true,
                                activeColor: carrotOrange,
                                groupValue: _type,
                                onChanged: (Paymentoption value) {
                                  setState(() {
                                    _type = value;
                                    a = "COD";
                                  });
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).online,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            leading: Container(
                              width: screenwidth / 6,
                              child: Radio<Paymentoption>(
                                value: Paymentoption.online,
                                autofocus: true,
                                activeColor: carrotOrange,
                                groupValue: _type,
                                onChanged: (Paymentoption value) {
                                  setState(() {
                                    _type = value;
                                    a = "Online";
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenwidth,
                      decoration: BoxDecoration(
                          color: tyrianPurple,
                          borderRadius: BorderRadius.circular(10.0)),
                      height: 40.0,
                      child: Card(
                        elevation: 5.0,
                        color: tyrianPurple,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              uploading = true;
                            });
                            await uploadorder(a);
                            if (widget.mealmodel != null &&
                                widget.otheritem != null) {
                              for (int i = 0;
                                  i < widget.otheritem.length;
                                  i++) {
                                orderitem.add({
                                  "order_itemtitle":
                                      widget.otheritem.elementAt(i)['title'],
                                  "order_itemimage": widget.otheritem
                                      .elementAt(i)['thumbnailUrl'],
                                  "order_itemdescription": widget.otheritem
                                      .elementAt(i)['Description'],
                                  "order_itemprice":
                                      widget.otheritem.elementAt(i)['price'],
                                  "order_itemquantity":
                                      widget.otheritem.elementAt(i)['quantity']
                                });
                              }

                              orderitem.add({
                                "order_itemtitle": widget.mealmodel['title'],
                                "order_itemimage":
                                    widget.mealmodel['thumbnailUrl'],
                                "order_itemdescription":
                                    widget.mealmodel['Description'],
                                "order_itemprice": widget.mealmodel['price'],
                                "order_itemquantity": widget.quantity
                              });

                              additemdata();
                            } else if (widget.mealmodel != null &&
                                widget.otheritem == null) {
                              orderitem.add({
                                "order_itemtitle": widget.mealmodel['title'],
                                "order_itemimage":
                                    widget.mealmodel['thumbnailUrl'],
                                "order_itemdescription":
                                    widget.mealmodel['Description'],
                                "order_itemprice": widget.mealmodel['price'],
                                "order_itemquantity": widget.quantity.toString()
                              });

                              additemdata();
                            } else if (widget.mealmodel == null &&
                                widget.otheritem != null) {
                              for (int i = 0;
                                  i < widget.otheritem.length;
                                  i++) {
                                orderitem.add({
                                  "order_itemtitle":
                                      widget.otheritem.elementAt(i)['title'],
                                  "order_itemimage": widget.otheritem
                                      .elementAt(i)['thumbnailUrl'],
                                  "order_itemdescription": widget.otheritem
                                      .elementAt(i)['Description'],
                                  "order_itemprice":
                                      widget.otheritem.elementAt(i)['price'],
                                  "order_itemquantity":
                                      widget.otheritem.elementAt(i)['quantity']
                                });
                              }
                              additemdata();
                            }
                            setState(() {
                              uploading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .orderisplacedyoucancheck),
                            ));
                            print(orderitem);
                            Route route =
                                MaterialPageRoute(builder: (_) => MyOrder());
                            Navigator.pushReplacement(context, route);
                            // print(widget.address);
                            // print(widget.dilvertime);
                            // print(widget.notes);
                            // print(widget.quantity);
                            // print(widget.kitchen.uid);
                            // print(widget.phoneno);
                            // print(widget.mealmodel['title']);
                            // print(widget.price);
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).order,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
