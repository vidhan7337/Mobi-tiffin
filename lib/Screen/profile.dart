import 'package:flutter/material.dart';
import 'package:user_tiffin/Authentication/authentication.dart';
import 'package:user_tiffin/Config/config.dart';
import 'package:user_tiffin/Screen/address/addressdetails.dart';
import 'package:user_tiffin/Screen/home.dart';
import 'package:user_tiffin/Screen/language.dart';
import 'package:user_tiffin/Screen/myorders.dart';
import 'package:user_tiffin/Widgets/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_tiffin/Widgets/mydrawer.dart';
import 'editing/updateprofile.dart';

class Profie extends StatefulWidget {
  @override
  _ProfieState createState() => _ProfieState();
}

class _ProfieState extends State<Profie> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).account,
            style: TextStyle(
              color: valhalla,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userAvatarUrl) ==
                      null
                  ? Container(
                      height: screenwidth / 2 - 10.0,
                      width: screenwidth / 2 - 10.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0)),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
                        ),
                      ),
                    )
                  : Container(
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
              SizedBox(
                height: 4.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Card(
                  child: SizedBox(
                    width: screenwidth,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).name,
                              style: TextStyle(
                                color: tyrianPurple,
                                fontSize: 17.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                child: Text(
                                    EcommerceApp.sharedPreferences
                                        .getString(EcommerceApp.userName),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: valhalla,
                                      fontSize: 19.0,
                                    )),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Card(
                  child: SizedBox(
                    width: screenwidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context).email,
                              style: TextStyle(
                                color: tyrianPurple,
                                fontSize: 17.0,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text(
                                  EcommerceApp.sharedPreferences
                                      .getString(EcommerceApp.userEmail),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: valhalla,
                                    fontSize: 19.0,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: screenwidth,
                  decoration: BoxDecoration(
                      color: tyrianPurple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Updateprofile()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).updateprofile,
                      style: TextStyle(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  width: screenwidth,
                  decoration: BoxDecoration(
                      color: tyrianPurple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateAddress()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).myaddresses,
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
