import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_tiffin/Config/menumodel.dart';
import 'package:user_tiffin/Screen/address/showaddress.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryDetails extends StatefulWidget {
  final Menumodel kitchen;
  final Map<dynamic, dynamic> mealmodel;
  final int quantity;
  final Iterable<Map<dynamic, dynamic>> otheritem;

  DeliveryDetails(
      {this.kitchen, this.mealmodel, this.quantity, this.otheritem});

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < widget.otheritem.length; i++) {
        total = total +
            (widget.otheritem.elementAt(i)['price'] *
                widget.otheritem.elementAt(i)['quantity']);
      }
      if (widget.mealmodel != null) {
        total = total + (widget.mealmodel['price'] * widget.quantity);
      }
    });
    print(now.hour);
    setState(() {
      var c = now.hour + 1;
      var d = c + 1;
      dropdownValue = "$c:00 - $d:00";
      x = 21 - now.hour;
      listtimeslot = List.generate(x, (i) => getstring(i));
    });
    print(listtimeslot);

    super.initState();
  }

  getstring(int i) {
    var a = now.hour + 1 + i;
    var b = a + 1;
    return "$a:00 - $b:00";
  }

  int x;
  var now = DateTime.now();

  var total = 0;
  String dropdownValue;
  List listtimeslot;
  TextEditingController notes = TextEditingController();
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
          AppLocalizations.of(context).deliverydetail,
          style: TextStyle(color: valhalla),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: valhalla),
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    AppLocalizations.of(context).item,
                                    style: TextStyle(
                                        color: tyrianPurple,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    AppLocalizations.of(context).quantity,
                                    style: TextStyle(
                                        color: tyrianPurple,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        widget.mealmodel == null
                            ? Padding(padding: EdgeInsets.all(0.0))
                            : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenwidth / 1.5,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                widget
                                                    .mealmodel['thumbnailUrl'],
                                                fit: BoxFit.cover,
                                                height: screenwidth / 5,
                                                width: screenwidth / 5,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenwidth / 30,
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
                                                    widget.mealmodel['title'],
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
                                                    widget.mealmodel[
                                                        'Description'],
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
                                                      widget.mealmodel['price']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0,
                                                      color: valhalla),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20.0,
                                          left: 10.0,
                                          top: 10.0,
                                          bottom: 10.0),
                                      child: Text(
                                        widget.quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        widget.otheritem == null
                            ? Padding(padding: EdgeInsets.all(0.0))
                            : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    for (int i = 0;
                                        i < widget.otheritem.length;
                                        i++)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenwidth / 1.5,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      widget.otheritem
                                                              .elementAt(i)[
                                                          'thumbnailUrl'],
                                                      fit: BoxFit.cover,
                                                      height: screenwidth / 5,
                                                      width: screenwidth / 5,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenwidth / 30,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          widget.otheritem
                                                              .elementAt(
                                                                  i)['title'],
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.0,
                                                              color: valhalla),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 7.0,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          widget.otheritem
                                                                  .elementAt(i)[
                                                              'Description'],
                                                          style: TextStyle(
                                                              fontSize: 17.0),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        '₹' +
                                                            widget.otheritem
                                                                .elementAt(
                                                                    i)['price']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0,
                                                            color: valhalla),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0,
                                                left: 10.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            child: Text(
                                              widget.otheritem
                                                  .elementAt(i)['quantity']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Container(
                  width: screenwidth,
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
                                AppLocalizations.of(context).deliverytimeslot,
                                style: TextStyle(
                                    color: tyrianPurple,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        x <= 0 || x > 12
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .noslotavailable,
                                    style: TextStyle(
                                      fontSize: 19.0,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, right: 10.0, left: 10.0),
                                child: Center(
                                  child: Container(
                                    width: screenwidth - 75.0,
                                    child: DropdownButtonFormField(
                                      elevation: 5,
                                      value: dropdownValue,
                                      dropdownColor: solitude,
                                      icon: Icon(Icons.arrow_drop_down),
                                      onChanged: (newValue) async {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: listtimeslot.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                      ]),
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
                              AppLocalizations.of(context).totalprice,
                              style: TextStyle(
                                  color: tyrianPurple,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).itemprice,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  Text(
                                    "₹" + total.toString(),
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).deliveryprice,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  Text(
                                    "₹" + "30",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).totalprice,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  Text(
                                    "₹" + ((total) + 30).toString(),
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text(
                              AppLocalizations.of(context).anynote,
                              style: TextStyle(
                                  color: tyrianPurple,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          margin: EdgeInsets.only(
                              left: 10.0, bottom: 10.0, right: 10.0),
                          child: TextFormField(
                            maxLines: null,
                            cursorColor: valhalla,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context).typehere,
                              prefixIcon: Icon(
                                Icons.note,
                                color: valhalla,
                              ),
                            ),
                            controller: notes,
                          ),
                        ),
                      )
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
                      if (x <= 0 || x > 12) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppLocalizations.of(context)
                              .withouttimeslotucannotproceed),
                        ));
                      } else {
                        if (widget.mealmodel == null &&
                            widget.otheritem != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowAddress(
                                    kitchen: widget.kitchen,
                                    otheritem: widget.otheritem,
                                    dilvertime: dropdownValue,
                                    notes: notes.text,
                                    price: (total + 30).toString())),
                          );
                        } else if (widget.mealmodel != null &&
                            widget.otheritem != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowAddress(
                                    kitchen: widget.kitchen,
                                    quantity: widget.quantity,
                                    mealmodel: widget.mealmodel,
                                    otheritem: widget.otheritem,
                                    dilvertime: dropdownValue,
                                    notes: notes.text,
                                    price: (total + 30).toString())),
                          );
                        } else if (widget.mealmodel != null &&
                            widget.otheritem == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowAddress(
                                    kitchen: widget.kitchen,
                                    mealmodel: widget.mealmodel,
                                    quantity: widget.quantity,
                                    dilvertime: dropdownValue,
                                    notes: notes.text,
                                    price: (total + 30).toString())),
                          );
                        }
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).selectaddress,
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
      ),
    );
  }
}
