import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/DialogBox/errorDialog.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:user_tiffin/Widgets/customTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditAddress extends StatefulWidget {
  final Map<String, dynamic> model;
  EditAddress({this.model});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctitle = TextEditingController();
  TextEditingController cName = TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController cFlatNumber = TextEditingController();
  TextEditingController carea = TextEditingController();
  TextEditingController cCity = TextEditingController();
  TextEditingController cState = TextEditingController();

  addaddresstodatabase() async {
    await Firestore.instance
        .collection('Users')
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection('address')
        .document(ctitle.text)
        .setData({
      "title": ctitle.text.trim(),
      "name": cName.text.trim(),
      "phone no": cPhoneNumber.text.trim(),
      "flatnumber": cFlatNumber.text.trim(),
      "area": carea.text.trim(),
      "city": cCity.text.trim(),
      "state": cState.text.trim(),
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).addressedit),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    ctitle.text = widget.model['title'];
    cName.text = widget.model['name'];
    cPhoneNumber.text = widget.model['phone no'];
    cFlatNumber.text = widget.model['flatnumber'];
    carea.text = widget.model['area'];
    cCity.text = widget.model['city'];
    cState.text = widget.model['state'];
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
            AppLocalizations.of(context).editaddress,
            style: TextStyle(color: valhalla),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: solitude),
            child: Column(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              message: AppLocalizations.of(context).cannotedit,
                            );
                          });
                    },
                    controller: ctitle,
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.title,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).title,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: cName,
                    onChanged: (text) {
                      widget.model['name'] = text;
                    },
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).name,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: cPhoneNumber,
                    onChanged: (text) {
                      widget.model['phone no'] = text;
                    },
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(new RegExp(('[0-9]'))),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    obscureText: false,
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).phone,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: cFlatNumber,
                    onChanged: (text) {
                      widget.model['flatnumber'] = text;
                    },
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.home,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).flatnumber,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: carea,
                    onChanged: (text) {
                      widget.model['area'] = text;
                    },
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.zoom_out_map,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).area,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: cCity,
                    onChanged: (text) {
                      widget.model['city'] = text;
                    },
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).city,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: cState,
                    onChanged: (text) {
                      widget.model['state'] = text;
                    },
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.map,
                        color: valhalla,
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      hintText: AppLocalizations.of(context).state,
                    ),
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
                        cCity.text.isNotEmpty &&
                                cFlatNumber.text.isNotEmpty &&
                                cName.text.isNotEmpty &&
                                cPhoneNumber.text.isNotEmpty &&
                                cState.text.isNotEmpty &&
                                carea.text.isNotEmpty &&
                                ctitle.text.isNotEmpty
                            ? cPhoneNumber.text.length == 10
                                ? addaddresstodatabase()
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text(AppLocalizations.of(context)
                                        .plswritephnnumber),
                                  ))
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)
                                    .pleasefillinfo),
                              ));
                      },
                      child: Text(
                        AppLocalizations.of(context).update,
                        style: TextStyle(
                            color: white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
