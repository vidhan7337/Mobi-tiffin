import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Screen/ordering/orderdetails.dart';
import 'package:user_tiffin/Screen/rating/orderrating.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:user_tiffin/Widgets/loadingWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("Orders")
          .orderBy("publishedDate", descending: true)
          .snapshots(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Container(
            child: Center(
              child: circularProgress(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: dataSnapshot.data.documents.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        dataSnapshot.data.documents[i].data['c_id'] ==
                                EcommerceApp.sharedPreferences
                                    .getString(EcommerceApp.userUID)
                            ? dataSnapshot.data.documents[i]
                                            .data['order_status'] ==
                                        '3' ||
                                    dataSnapshot.data.documents[i]
                                            .data['order_status'] ==
                                        '5'
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: screenwidth,
                                      child: Card(
                                        elevation: 4.0,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail(
                                                        order: dataSnapshot.data
                                                            .documents[i].data,
                                                        id: dataSnapshot
                                                            .data
                                                            .documents[i]
                                                            .documentID,
                                                      )),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .orderid,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: screenwidth / 1.7,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0,
                                                                top: 8.0,
                                                                bottom: 8.0),
                                                        child: Text(
                                                          dataSnapshot
                                                              .data
                                                              .documents[i]
                                                              .documentID,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.0),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image.network(
                                                          dataSnapshot
                                                                  .data
                                                                  .documents[i]
                                                                  .data[
                                                              'kitchen_image'],
                                                          height:
                                                              screenwidth / 3.5,
                                                          width:
                                                              screenwidth / 3.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 8.0,
                                                        ),
                                                        child: Container(
                                                          width:
                                                              screenwidth / 1.8,
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Wrap(
                                                                    children: [
                                                                      for (int j =
                                                                              0;
                                                                          j < dataSnapshot.data.documents[i].data['order_item'].length;
                                                                          j++)
                                                                        Text(
                                                                          dataSnapshot.data.documents[i].data['order_item'][j]['order_itemtitle'] +
                                                                              ", ",
                                                                          style: TextStyle(
                                                                              color: tyrianPurple,
                                                                              fontSize: 17.0,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(context)
                                                                            .soldby +
                                                                        dataSnapshot
                                                                            .data
                                                                            .documents[i]
                                                                            .data['sp_name'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    softWrap:
                                                                        true,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    '₹' +
                                                                        dataSnapshot
                                                                            .data
                                                                            .documents[i]
                                                                            .data['order_totalprice']
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0),
                                                                  ),
                                                                ),
                                                                dataSnapshot
                                                                            .data
                                                                            .documents[i]
                                                                            .data['order_status'] ==
                                                                        '3'
                                                                    ? Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context).orderstatus +
                                                                              " : " +
                                                                              AppLocalizations.of(context).reject,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context).orderstatus +
                                                                              " : " +
                                                                              AppLocalizations.of(context).delivered,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    DateFormat.yMMMd().add_jm().format(DateTime.parse(dataSnapshot
                                                                        .data
                                                                        .documents[
                                                                            i]
                                                                        .data[
                                                                            'publishedDate']
                                                                        .toDate()
                                                                        .toString())),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              dataSnapshot.data.documents[i]
                                                                  .data[
                                                              'order_rating'] ==
                                                          null &&
                                                      dataSnapshot
                                                                  .data
                                                                  .documents[i]
                                                                  .data[
                                                              'order_status'] ==
                                                          '5'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child: Center(
                                                        child: Container(
                                                          width:
                                                              screenwidth / 3,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            border: Border.all(
                                                                color:
                                                                    valhalla),
                                                          ),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              OrderRating(
                                                                                order: dataSnapshot.data.documents[i].data,
                                                                                id: dataSnapshot.data.documents[i].documentID,
                                                                              )),
                                                                );
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .ratethisorder,
                                                                style: TextStyle(
                                                                    color:
                                                                        valhalla),
                                                              )),
                                                        ),
                                                      ),
                                                    )
                                                  : dataSnapshot
                                                                  .data
                                                                  .documents[i]
                                                                  .data[
                                                              'order_status'] ==
                                                          '3'
                                                      ? Text("")
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0,
                                                                  left: 8.0,
                                                                  right: 8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .rating,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                              SmoothStarRating(
                                                                color:
                                                                    tyrianPurple,
                                                                borderColor:
                                                                    tyrianPurple,
                                                                isReadOnly:
                                                                    true,
                                                                rating: dataSnapshot
                                                                        .data
                                                                        .documents[
                                                                            i]
                                                                        .data[
                                                                    'order_rating'],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                : Padding(padding: EdgeInsets.all(0.0))
                            : Padding(padding: EdgeInsets.all(0.0)),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
