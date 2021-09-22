import 'dart:io';

import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_tiffin/DialogBox/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/DialogBox/errorDialog.dart';
import 'package:user_tiffin/DialogBox/loadingDialog.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Screen/profile.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofile extends StatefulWidget {
  @override
  _UpdateprofileState createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  TextEditingController _nametextEditingController = TextEditingController();
  String userImageUrl = "";
  File _imageFile;
  bool uploading = false;
  // TextEditingController _phonetextEditingController = TextEditingController();
  // TextEditingController _addresstextEditingController = TextEditingController();
  // String userImageUrl = "";
  // File _imageFile;

  uploadToStorage() async {
    if (_imageFile == null) {
      saveUserInfoToFireStore().then((value) {
        Route route = MaterialPageRoute(builder: (_) => Profie());
        Navigator.pushReplacement(context, route);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context).profileupdated),
        ));
      });
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingAlertDialog(
              message: "'Updating, Please wait.....'",
            );
          });
      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(imageFileName);

      StorageUploadTask storageUploadTask =
          storageReference.putFile(_imageFile);

      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      await taskSnapshot.ref.getDownloadURL().then((urlImage) {
        userImageUrl = urlImage;
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userAvatarUrl, userImageUrl);
        saveUserInfoToFireStore().then((value) {
          Route route = MaterialPageRoute(builder: (_) => Profie());
          Navigator.pushReplacement(context, route);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context).profileupdated),
          ));
        });
      });
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  Future saveUserInfoToFireStore() async {
    Firestore.instance
        .collection("Users")
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .setData({
      "uid": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      "email": EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
      "User Name":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
      "password":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userpassword),
      "url":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),
    });
    setState(() {
      uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _nametextEditingController.text =
        EcommerceApp.sharedPreferences.getString(EcommerceApp.userName);

    // _phonetextEditingController.text =
    //     EcommerceApp.sharedPreferences.getString(EcommerceApp.userphone);
    // _addresstextEditingController.text =
    //     EcommerceApp.sharedPreferences.getString(EcommerceApp.addressID);
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        title: Text(
          AppLocalizations.of(context).updateprofile,
          style: TextStyle(color: valhalla),
        ),
      ),
      body: uploading
          ? LoadingDialog()
          : ListView(
              children: [
                SizedBox(
                  height: 8.0,
                ),
                EcommerceApp.sharedPreferences
                            .getString(EcommerceApp.userAvatarUrl) ==
                        null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenwidth / 2 - 10.0,
                          width: screenwidth / 2 - 10.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0)),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenwidth / 2 - 10.0,
                          width: screenwidth / 2 - 10.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0)),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              EcommerceApp.sharedPreferences
                                  .getString(EcommerceApp.userAvatarUrl),
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: FlatButton(
                      onPressed: () async {
                        _imageFile = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                      },
                      color: tyrianPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Text(
                        AppLocalizations.of(context).selectimage,
                        style: TextStyle(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Text(
                    AppLocalizations.of(context).username,
                    style: TextStyle(
                      color: tyrianPurple,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
                  child: TextField(
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                    ),
                    controller: _nametextEditingController,
                    onChanged: (text) {
                      EcommerceApp.sharedPreferences
                          .setString(EcommerceApp.userName, text);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                //   child: Text("Email ",
                //       style: TextStyle(
                //         color: tyrianPurple,
                //         fontSize: 20.0,
                //       )),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                //   child: TextField(
                //     cursorColor: valhalla,
                //     decoration: InputDecoration(
                //       focusColor: Theme.of(context).primaryColor,
                //     ),
                //     controller: _emailtextEditingController,
                //     onChanged: (text) {
                //       EcommerceApp.sharedPreferences
                //           .setString(EcommerceApp.userEmail, text);
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                //   child: Text("Phone Number",
                //       style: TextStyle(color: tyrianPurple, fontSize: 20.0)),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       focusColor: Theme.of(context).primaryColor,
                //     ),
                //     cursorColor: valhalla,
                //     controller: _phonetextEditingController,
                //     keyboardType: TextInputType.numberWithOptions(decimal: true),
                //     inputFormatters: [
                //       WhitelistingTextInputFormatter(new RegExp(('[0-9]'))),
                //       LengthLimitingTextInputFormatter(10),
                //     ],
                //     onChanged: (text) {
                //       EcommerceApp.sharedPreferences
                //           .setString(EcommerceApp.userphone, text);
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                //   child: Text("Address",
                //       style: TextStyle(color: tyrianPurple, fontSize: 20.0)),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                //   child: TextField(
                //     cursorColor: valhalla,
                //     decoration: InputDecoration(
                //       focusColor: Theme.of(context).primaryColor,
                //     ),
                //     controller: _addresstextEditingController,
                //     onChanged: (text) {
                //       EcommerceApp.sharedPreferences
                //           .setString(EcommerceApp.addressID, text);
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenwidth,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          uploading = true;
                        });
                        _nametextEditingController.text.isNotEmpty
                            ? uploadToStorage()
                            : displayDialog(
                                AppLocalizations.of(context).pleasefillinfo);
                      },
                      color: tyrianPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Text(
                        AppLocalizations.of(context).update,
                        style: TextStyle(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
