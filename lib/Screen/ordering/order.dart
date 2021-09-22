import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Config/menumodel.dart';
import 'package:user_tiffin/Screen/address/addaddress.dart';
import 'package:user_tiffin/Screen/address/showaddress.dart';
import 'package:user_tiffin/Screen/ordering/deliverydetails.dart';
import 'package:user_tiffin/Screen/providerdetail.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_tiffin/Widgets/loadingWidget.dart';

class Order extends StatefulWidget {
  final Menumodel kitchen;

  final Map<dynamic, dynamic> dinnermodel;
  final Map<dynamic, dynamic> lunchmodel;
  Order({this.lunchmodel, this.dinnermodel, this.kitchen});
  @override
  _OrderState createState() => _OrderState();
}

enum DeliveryTime { a, b, c }
enum Mealtime { lunch, dinner }

class _OrderState extends State<Order> {
  @override
  void initState() {
    // TODO: implement initState
    getorderdata();

    super.initState();
  }

  var address;
  var addressmodel;
  List<Map<String, bool>> checklunchanddinner = [
    {"lunch": false},
    {"dinner": false},
  ];
  List orderitem;
  var checkitem;
  var menuitem;

  int _itemCount = 1;

  getdataaddress(String a) async {
    address = await Firestore.instance
        .collection('Users')
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection('address')
        .document(a)
        .get();

    setState(() {
      addressmodel = address.data;
    });
  }

  getorderdata() async {
    var menuitems = await Firestore.instance
        .collection('serviceprovider')
        .document(widget.kitchen.uid)
        .collection("dailymenu")
        .getDocuments();

    // for (int i = 0; i < menuitem.documents.length; i++) {
    //   var temp1 = {"title":menuitem.documents[i].};
    // }

    var temp = new List();

    checkitem = menuitems.documents.map((doc) => temp.add(doc.data)).toList();

    var finalData = temp
        .map((e) => ({
              ...e,
              'quantity': 0,
              'isSelect': false,
            }))
        .toList();

    setState(() {
      menuitem = finalData;
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
            widget.kitchen.kitchenName,
            style: TextStyle(color: valhalla),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: valhalla),
                        borderRadius: BorderRadius.circular(15.0)),
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
                                AppLocalizations.of(context)
                                    .whatwouldyouliketohave,
                                style: TextStyle(
                                    color: tyrianPurple,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        widget.lunchmodel == null
                            ? Text("")
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: screenwidth / 6,
                                            child: Checkbox(
                                              value: checklunchanddinner[0]
                                                  ["lunch"],
                                              onChanged: (val) {
                                                if (checklunchanddinner[1]
                                                        ["dinner"] ==
                                                    true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .ucanolnychooseone),
                                                  ));
                                                } else {
                                                  setState(() {
                                                    checklunchanddinner[0]
                                                        .update("lunch",
                                                            (value) => val);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                lunchmodel['thumbnailUrl'],
                                                fit: BoxFit.cover,
                                                height: screenwidth / 5,
                                                width: screenwidth / 5,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenwidth / 20,
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    lunchmodel['title'],
                                                    overflow: TextOverflow.clip,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.0,
                                                        color: valhalla),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7.0,
                                                ),
                                                Container(
                                                  child: Text(
                                                    lunchmodel['Description'],
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                    overflow: TextOverflow.clip,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  '₹' +
                                                      lunchmodel['price']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0,
                                                      color: valhalla),
                                                ),
                                                checklunchanddinner[0]
                                                            ['lunch'] ==
                                                        true
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 8.0),
                                                        child: Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25.0),
                                                                  border: Border
                                                                      .all(
                                                                    color:
                                                                        valhalla,
                                                                  )),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          tyrianPurple,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0)),
                                                                  child:
                                                                      IconButton(
                                                                    iconSize:
                                                                        15.0,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          white,
                                                                    ),
                                                                    onPressed: () =>
                                                                        setState(
                                                                            () {
                                                                      if (_itemCount <
                                                                          2) {
                                                                        _itemCount =
                                                                            1;
                                                                      } else {
                                                                        _itemCount--;
                                                                      }
                                                                    }),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                _itemCount
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.0),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        tyrianPurple,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0),
                                                                  ),
                                                                  child: IconButton(
                                                                      iconSize: 15.0,
                                                                      icon: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color:
                                                                            white,
                                                                      ),
                                                                      onPressed: () => setState(() => _itemCount++)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Text(""),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                        widget.dinnermodel == null
                            ? Text("")
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 8.0,
                                    top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: screenwidth / 6,
                                            child: Checkbox(
                                              value: checklunchanddinner[1]
                                                  ["dinner"],
                                              onChanged: (val) {
                                                if (checklunchanddinner[0]
                                                        ["lunch"] ==
                                                    true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .ucanolnychooseone),
                                                  ));
                                                } else {
                                                  setState(() {
                                                    checklunchanddinner[1]
                                                        .update("dinner",
                                                            (value) => val);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                dinnermodel['thumbnailUrl'],
                                                fit: BoxFit.cover,
                                                height: screenwidth / 5,
                                                width: screenwidth / 5,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenwidth / 20,
                                          ),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    dinnermodel['title'],
                                                    overflow: TextOverflow.clip,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.0,
                                                        color: valhalla),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7.0,
                                                ),
                                                Container(
                                                  child: Text(
                                                    dinnermodel['Description'],
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                    overflow: TextOverflow.clip,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  '₹' +
                                                      dinnermodel['price']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0,
                                                      color: valhalla),
                                                ),
                                                checklunchanddinner[1]
                                                            ["dinner"] ==
                                                        true
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 8.0),
                                                        child: Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25.0),
                                                                  border: Border
                                                                      .all(
                                                                    color:
                                                                        valhalla,
                                                                  )),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          tyrianPurple,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0)),
                                                                  child:
                                                                      IconButton(
                                                                    iconSize:
                                                                        15.0,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          white,
                                                                    ),
                                                                    onPressed: () =>
                                                                        setState(
                                                                            () {
                                                                      if (_itemCount <
                                                                          2) {
                                                                        _itemCount =
                                                                            1;
                                                                      } else {
                                                                        _itemCount--;
                                                                      }
                                                                    }),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                _itemCount
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.0),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        tyrianPurple,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0),
                                                                  ),
                                                                  child: IconButton(
                                                                      iconSize: 15.0,
                                                                      icon: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color:
                                                                            white,
                                                                      ),
                                                                      onPressed: () => setState(() => _itemCount++)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Text(""),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: valhalla),
                        borderRadius: BorderRadius.circular(15.0)),
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
                                AppLocalizations.of(context).otheritems,
                                style: TextStyle(
                                    color: tyrianPurple,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        menuitem == null
                            ? circularProgress()
                            : Column(
                                children: [
                                  for (int i = 0; i < menuitem.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          bottom: 8.0,
                                          top: 8.0),
                                      child: menuitem.elementAt(i)['status'] ==
                                              false
                                          ? Padding(
                                              padding: EdgeInsets.all(0.0))
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: screenwidth / 6,
                                                        child: Checkbox(
                                                          value: menuitem
                                                                  .elementAt(i)[
                                                              'isSelect'],
                                                          onChanged: (val) {
                                                            print(val);
                                                            if (val) {
                                                              setState(() {
                                                                menuitem.elementAt(
                                                                            i)[
                                                                        'isSelect'] =
                                                                    val;
                                                                menuitem.elementAt(
                                                                        i)[
                                                                    'quantity'] = 1;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                menuitem.elementAt(
                                                                            i)[
                                                                        'isSelect'] =
                                                                    val;
                                                                menuitem.elementAt(
                                                                        i)[
                                                                    'quantity'] = 0;
                                                              });
                                                            }

                                                            // var x = menuitem.map((e) => e[
                                                            //             'publishedDate'] ==
                                                            //         menuitem.elementAt(
                                                            //                 i)[
                                                            //             'publishedDate']
                                                            //     ? {
                                                            //         ...e,
                                                            //         'isSelect': val
                                                            //       }
                                                            //     : e);
                                                            // setState(() {
                                                            //   menuitem = x;
                                                            // });
                                                            // print(x);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            menuitem.elementAt(
                                                                    i)[
                                                                'thumbnailUrl'],
                                                            fit: BoxFit.cover,
                                                            height:
                                                                screenwidth / 5,
                                                            width:
                                                                screenwidth / 5,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenwidth / 20,
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                menuitem.elementAt(
                                                                    i)['title'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17.0,
                                                                    color:
                                                                        valhalla),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 7.0,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                menuitem.elementAt(
                                                                        i)[
                                                                    'Description'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17.0),
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Text(
                                                              '₹' +
                                                                  menuitem
                                                                      .elementAt(
                                                                          i)['price']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      17.0,
                                                                  color:
                                                                      valhalla),
                                                            ),
                                                            menuitem.elementAt(
                                                                            i)[
                                                                        'isSelect'] ==
                                                                    true
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(25.0),
                                                                          border: Border.all(
                                                                            color:
                                                                                valhalla,
                                                                          )),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              height: 30.0,
                                                                              width: 30.0,
                                                                              decoration: BoxDecoration(color: tyrianPurple, borderRadius: BorderRadius.circular(15.0)),
                                                                              child: IconButton(
                                                                                iconSize: 15.0,
                                                                                icon: Icon(
                                                                                  Icons.remove,
                                                                                  color: white,
                                                                                ),
                                                                                onPressed: () => setState(() {
                                                                                  if (menuitem.elementAt(i)['quantity'] < 2) {
                                                                                    menuitem.elementAt(i)['quantity'] = 1;
                                                                                  } else {
                                                                                    menuitem.elementAt(i)['quantity']--;
                                                                                  }
                                                                                }),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            menuitem.elementAt(i)['quantity'].toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 18.0),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Container(
                                                                              height: 30.0,
                                                                              width: 30.0,
                                                                              decoration: BoxDecoration(
                                                                                color: tyrianPurple,
                                                                                borderRadius: BorderRadius.circular(50.0),
                                                                              ),
                                                                              child: IconButton(
                                                                                  iconSize: 15.0,
                                                                                  icon: Icon(
                                                                                    Icons.add,
                                                                                    color: white,
                                                                                  ),
                                                                                  onPressed: () => setState(() => menuitem.elementAt(i)['quantity']++)),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Text(""),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                    ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenwidth - 50.0,
                    decoration: BoxDecoration(
                        color: tyrianPurple,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextButton(
                      onPressed: () {
                        var filterData = menuitem
                            .where((value) => value['isSelect'] == true);

                        if (checklunchanddinner[1]["dinner"] == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryDetails(
                                      kitchen: widget.kitchen,
                                      mealmodel: widget.dinnermodel,
                                      quantity: _itemCount,
                                      otheritem: filterData,
                                    )),
                          );
                        } else if (checklunchanddinner[0]["lunch"] == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryDetails(
                                      kitchen: widget.kitchen,
                                      mealmodel: widget.lunchmodel,
                                      quantity: _itemCount,
                                      otheritem: filterData,
                                    )),
                          );
                        }
                        // else if (checklunchanddinner[0]["lunch"] == false &&
                        //     checklunchanddinner[1]["dinner"] == false &&
                        //     filterData == null) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text("Please choose item to proceed"),
                        //   ));
                        // }
                        else if (checklunchanddinner[0]["lunch"] == false &&
                            checklunchanddinner[1]["dinner"] == false) {
                          if (filterData.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .plschooseitemtoproceed),
                            ));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeliveryDetails(
                                        kitchen: widget.kitchen,
                                        otheritem: filterData,
                                      )),
                            );
                          }
                        }

                        // if (_character == Mealtime.lunch) {
                        //   if (_deliveryTime == DeliveryTime.a) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShowAddress(
                        //                 kitchen: widget.kitchen,
                        //                 mealmodel: widget.lunchmodel,
                        //                 quantity: _itemCount,
                        //                 dilvertime: "11:30 AM - 12:30 PM",
                        //                 notes: _notescontroller.text,
                        //                 price:
                        //                     ((lunchmodel['price'] * _itemCount) +
                        //                             30)
                        //                         .toString(),
                        //               )),
                        //     );
                        //   } else if (_deliveryTime == DeliveryTime.b) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShowAddress(
                        //                 kitchen: widget.kitchen,
                        //                 mealmodel: widget.lunchmodel,
                        //                 quantity: _itemCount,
                        //                 dilvertime: "12:30 PM - 01:30 PM",
                        //                 notes: _notescontroller.text,
                        //                 price:
                        //                     ((lunchmodel['price'] * _itemCount) +
                        //                             30)
                        //                         .toString(),
                        //               )),
                        //     );
                        //   } else if (_deliveryTime == DeliveryTime.c) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShowAddress(
                        //               kitchen: widget.kitchen,
                        //               mealmodel: widget.lunchmodel,
                        //               quantity: _itemCount,
                        //               dilvertime: "01:30 PM - 02:30 PM",
                        //               notes: _notescontroller.text,
                        //               price: ((lunchmodel['price'] * _itemCount) +
                        //                       30)
                        //                   .toString())),
                        //     );
                        //   }
                        // } else {
                        //   if (_deliveryTime == DeliveryTime.a) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShowAddress(
                        //                 kitchen: widget.kitchen,
                        //                 mealmodel: widget.dinnermodel,
                        //                 quantity: _itemCount,
                        //                 dilvertime: "06:30 PM - 07:30 PM",
                        //                 notes: _notescontroller.text,
                        //                 price:
                        //                     ((dinnermodel['price'] * _itemCount) +
                        //                             30)
                        //                         .toString(),
                        //               )),
                        //     );
                        //   } else if (_deliveryTime == DeliveryTime.b) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShowAddress(
                        //                 kitchen: widget.kitchen,
                        //                 mealmodel: widget.dinnermodel,
                        //                 quantity: _itemCount,
                        //                 dilvertime: "07:30 PM - 08:30 PM",
                        //                 notes: _notescontroller.text,
                        //                 price:
                        //                     ((dinnermodel['price'] * _itemCount) +
                        //                             30)
                        //                         .toString(),
                        //               )),
                        //     );
                        //   } else if (_deliveryTime == DeliveryTime.c) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShowAddress(
                        //                 kitchen: widget.kitchen,
                        //                 mealmodel: widget.dinnermodel,
                        //                 quantity: _itemCount,
                        //                 dilvertime: "08:30 PM - 09:30 PM",
                        //                 notes: _notescontroller.text,
                        //                 price:
                        //                     ((dinnermodel['price'] * _itemCount) +
                        //                             30)
                        //                         .toString(),
                        //               )),
                        //     );
                        //   }
                        // }
                      },
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
              ],
            ),
          ),
        ));
  }
}
