import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tiffin/Screen/myorders.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderRating extends StatefulWidget {
  final Map<String, dynamic> order;
  final String id;
  OrderRating({this.order, this.id});

  @override
  _OrderRatingState createState() => _OrderRatingState();
}

class _OrderRatingState extends State<OrderRating> {
  double r = 5.0;
  TextEditingController _review = TextEditingController();

  saveratingtodatabse() async {
    await Firestore.instance
        .collection("Orders")
        .document(widget.id)
        .updateData({
      "order_rating": r,
      "order_review": _review.text,
    });
    await Firestore.instance
        .collection('serviceprovider')
        .document(widget.order['sp_id'])
        .collection('ratings')
        .document()
        .setData({
      "order_id": widget.id,
      "c_id": widget.order['c_id'],
      "c_name": widget.order['c_name'],
      "publishedDate": DateTime.now(),
      "order_rating": r,
      "order_review": _review.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).orderrated),
    ));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyOrder()));
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
          AppLocalizations.of(context).orderrating,
          style: TextStyle(color: valhalla),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  AppLocalizations.of(context).selectstar,
                  style: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                    child: SmoothStarRating(
                  size: 50.0,
                  rating: r,
                  color: tyrianPurple,
                  borderColor: tyrianPurple,
                  onRated: (value) {
                    setState(() {
                      r = value;
                      print(r);
                    });
                  },
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context).writeyourrevie,
                  style: TextStyle(fontSize: 19.0),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                width: screenwidth - 50.0,
                decoration: BoxDecoration(
                    border: Border.all(color: valhalla),
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextFormField(
                  cursorColor: tyrianPurple,
                  cursorHeight: 30.0,
                  controller: _review,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).typehere),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenwidth - 100.0,
                  decoration: BoxDecoration(
                      color: tyrianPurple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                      onPressed: () {
                        saveratingtodatabse();
                      },
                      child: Text(
                        AppLocalizations.of(context).sunbmit,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: white),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
