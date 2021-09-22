import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:e_shop/Admin/adminLogin.dart';
import '../Widgets/customTextField.dart';
import '../DialogBox/errorDialog.dart';
import '../DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../Store/storehome.dart';
import '../Config/config.dart';
import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 200.0,
                width: 200.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context).logintoyouracc,
                style: TextStyle(color: valhalla, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailtextEditingController,
                    data: Icons.email,
                    hintText: AppLocalizations.of(context).email,
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    data: Icons.vpn_key,
                    hintText: AppLocalizations.of(context).password,
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            Container(
              width: _screenwidth - 100.0,
              decoration: BoxDecoration(
                  color: tyrianPurple,
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextButton(
                onPressed: () {
                  _emailtextEditingController.text.isNotEmpty &&
                          _passwordtextEditingController.text.isNotEmpty
                      ? loginUser()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              message: AppLocalizations.of(context)
                                  .plsentercorrectdetails,
                            );
                          });
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userName));
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userEmail));
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userUID));
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userpassword));
                },
                child: Text(
                  AppLocalizations.of(context).signin,
                  style: TextStyle(
                      color: white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenwidth * 0.8,
              color: tyrianPurple,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  // FirebaseAuth _auth = FirebaseAuth.instance;
  // void loginUser() async {
  //   showDialog(
  //       context: context,
  //       builder: (c) {
  //         return LoadingAlertDialog(
  //           message: "authenticating wait...",
  //         );
  //       });
  //   // FirebaseUser firebaseUser;
  //   // await _auth
  //   //     .signInWithEmailAndPassword(
  //   //         email: _emailtextEditingController.text.trim(),
  //   //         password: _passwordtextEditingController.text.trim())
  //   //     .then((authUser) {
  //   //   firebaseUser = authUser.user;
  //   // }).catchError((error) {
  //   //   Navigator.pop(context);
  //   //   showDialog(
  //   //       context: context,
  //   //       builder: (c) {
  //   //         return ErrorAlertDialog(
  //   //           message: error.message.toString(),
  //   //         );
  //   //       });
  //   // });
  //   // if (firebaseUser != null) {
  //   //   readData(firebaseUser).then((s) {
  //   //     Navigator.pop(context);

  //   //     Route route = MaterialPageRoute(builder: (c) => HomeScreen());
  //   //     Navigator.pushReplacement(context, route);
  //   //   });
  //   // }
  // }
  loginUser() async {
    var a = await Firestore.instance
        .collection("Users")
        .document(_emailtextEditingController.text)
        .get();

    var b = a.data;

    if (a.data == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: AppLocalizations.of(context).plsentercorrectdetails,
            );
          });
    } else if (_emailtextEditingController.text != b['email']) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: AppLocalizations.of(context).plsentercorrectemail,
            );
          });
    } else if (_passwordtextEditingController.text != b['password']) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: AppLocalizations.of(context).pleaseentercorrectpass,
            );
          });
    } else {
      setState(() {
        _emailtextEditingController.text = "";
        _passwordtextEditingController.text = "";
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userUID, b['uid']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userEmail, b['email']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userName, b['User Name']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userpassword, b['password']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.language, "English");
      });

      Route route = MaterialPageRoute(builder: (c) => HomeScreen());
      Navigator.pushReplacement(context, route);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context).signedsucc),
      ));
    }
    // Firestore.instance.collection("Users").getDocuments().then((snapshot) {
    //   snapshot.documents.forEach((result) {
    //     if (result.data["email"] != _emailtextEditingController.text.trim()) {
    //       Scaffold.of(context).showSnackBar(SnackBar(
    //         content: Text("your id is not correct."),
    //       ));
    //     } else if (result.data["password"] !=
    //         _passwordtextEditingController.text.trim()) {
    //       Scaffold.of(context).showSnackBar(SnackBar(
    //         content: Text("your password is not correct."),
    //       ));
    //     } else {
    //       Scaffold.of(context).showSnackBar(SnackBar(
    //         content: Text("Welcome Dear User, " + result.data["User name"]),
    //       ));

    //       setState(() {
    //         _emailtextEditingController.text = "";
    //         _passwordtextEditingController.text = "";
    //       });

    //       Route route = MaterialPageRoute(builder: (c) => HomeScreen());
    //       Navigator.pushReplacement(context, route);
    //     }
    //   });
    // });
  }

  // Future readData(FirebaseUser fUser) async {
  //   Firestore.instance
  //       .collection("Users")
  //       .document(fUser.uid)
  //       .get()
  //       .then((dataSnapshot) async {
  //     await EcommerceApp.sharedPreferences
  //         .setString("uid", dataSnapshot.data[EcommerceApp.userUID]);
  //     await EcommerceApp.sharedPreferences.setString(
  //         EcommerceApp.userEmail, dataSnapshot.data[EcommerceApp.userEmail]);
  //     await EcommerceApp.sharedPreferences
  //         .setString(EcommerceApp.userName, dataSnapshot.data['User Name']);

  //     // print(EcommerceApp.sharedPreferences.getString(EcommerceApp.userName));
  //     // print(EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail));
  //     // print(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID));
  //     // print(
  //     //     EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl));
  //     // print(EcommerceApp.sharedPreferences.getString(EcommerceApp.userphone));
  //     // print(EcommerceApp.sharedPreferences.getString(EcommerceApp.addressID));

  //     // List<String> cartlist =
  //     //     dataSnapshot.data[EcommerceApp.userCartList].cast<String>();
  //     // await EcommerceApp.sharedPreferences
  //     //     .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  //   });
  // }
}
