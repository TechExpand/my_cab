import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:my_cab/Language/appLocalizations.dart';
// import 'package:my_cab/Language/appLocalizations.dart';
// import 'package:my_cab/constance/constance.dart';
import '../../constance/global.dart' as globals;
// import 'package:my_cab/constance/routes.dart';
// import 'package:my_cab/constance/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../Language/appLocalizations.dart';
import '../../constance/constance.dart';
import '../../constance/themes.dart';
String _verificationCode;
String fullname;
String email;
var pin;
Future<void> updateProfile({String displayName, String photoURL}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    final Future<void> user = _auth.currentUser.updateDisplayName(fullname);
    print(user);
  } catch (e) {
    print(e);
    //                    Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (Route<dynamic> route) => false);
    // Fluttertoast.showToast(
    //     msg: e,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 6,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
  }
}
  class AdditionDetails extends StatefulWidget {
    @override
    _AdditionDetails createState() => _AdditionDetails();
  }

  class _AdditionDetails extends State<AdditionDetails> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  var otpController = new TextEditingController();
  var fullnameController = new TextEditingController();
  var emailController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animationController..forward();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    globals.locale = Localizations.localeOf(context);
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: Container(
        constraints: BoxConstraints(minHeight: MediaQuery
            .of(context)
            .size
            .height, minWidth: MediaQuery
            .of(context)
            .size
            .width),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ClipRect(
                        child: Container(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          child: AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext context, Widget child) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  Transform(
                                    transform: new Matrix4.translationValues(
                                        0.0,
                                        160 *
                                            (1.0 -
                                                (AlwaysStoppedAnimation(
                                                    Tween(begin: 0.4, end: 1.0)
                                                        .animate(
                                                        CurvedAnimation(
                                                            parent: animationController,
                                                            curve: Curves
                                                                .fastOutSlowIn)))
                                                    .value)
                                                    .value) -
                                            16,
                                        0.0),
                                    child: Image.asset(
                                      ConstanceData.buildingImageBack,
                                      color: HexColor("#FF8B8B"),
                                    ),
                                  ),
                                  Transform(
                                    transform: new Matrix4.translationValues(
                                        0.0,
                                        160 *
                                            (1.0 -
                                                (AlwaysStoppedAnimation(
                                                    Tween(begin: 0.8, end: 1.0)
                                                        .animate(
                                                        CurvedAnimation(
                                                            parent: animationController,
                                                            curve: Curves
                                                                .fastOutSlowIn)))
                                                    .value)
                                                    .value),
                                        0.0),
                                    child: Image.asset(
                                      ConstanceData.buildingImage,
                                      color: HexColor("#FFB8B8"),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: (MediaQuery
                          .of(context)
                          .size
                          .height / 2) - (MediaQuery
                          .of(context)
                          .size
                          .width < 360 ? 124 : 86),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        margin: EdgeInsets.all(0),
                        elevation: 8,
                        child: Column(
                          children: <Widget>[
                            _loginTextUI(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 40.0, bottom: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: fullnameController,
                                onChanged: (String txt) {
                                  setState(() {
                                    txt = fullname;
                                  });
                                },
                                decoration: new InputDecoration(
                                  labelText: "Enter Fullname",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 40.0, bottom: 30.0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                onChanged: (String txt) {
                                  setState(() {
                                    txt = email;
                                  });
                                },
                                decoration: new InputDecoration(
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            _getVerifyUI(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .padding
                        .top,
                  ),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Container(
                      padding: EdgeInsets.only(top: 0, left: 8),
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: new BorderRadius.circular(
                                AppBar().preferredSize.height),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 26,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 8),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of('User Information'),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emailUI() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
          child: TextField(
            cursorColor: Colors.deepOrange,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Enter Fullname",
              fillColor: Colors.white,
              labelStyle: TextStyle(
                color: Colors.deepOrange,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.deepOrange, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Theme
                        .of(context)
                        .dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: otpController,
                            maxLength: 6,
                            onChanged: (String txt) {
                              setState(() {
                                txt = _verificationCode;
                                txt = pin;
                              });
                            },
                            onTap: () {},
                            cursorColor: Theme
                                .of(context)
                                .primaryColor,
                            decoration: new InputDecoration(
                              errorText: null,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Theme
                                    .of(context)
                                    .disabledColor,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _loginTextUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, top: 30, bottom: 30),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          AppLocalizations.of('Enter your OTP code here'),
          style: Theme
              .of(context)
              .textTheme
              .bodyText1
              .copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Widget _getVerifyUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () async {
              final FirebaseAuth _auth = FirebaseAuth.instance;
              try {
                final Future<void> user = _auth.currentUser.updateProfile(
                    displayName: fullname);
                print(user);
              } catch (e) {
                print(e);
                //                    Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (Route<dynamic> route) => false);
                // Fluttertoast.showToast(
                //     msg: e,
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.CENTER,
                //     timeInSecForIosWeb: 6,
                //     backgroundColor: Colors.red,
                //     textColor: Colors.white,
                //     fontSize: 16.0
                // );
              }
            },
            child: Center(
              child: Text(
                AppLocalizations.of("Verify now"),
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget getOtpTextUI({String otptxt = ""}) {
    List<Widget> otplist = List<Widget>();
    Widget getUI({String otxt = ""}) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Theme
                    .of(context)
                    .dividerColor, width: 1.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(otxt, style: Theme
                      .of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      );
    }
    for (var i = 0; i < 6; i++) {
      otplist.add(getUI(otxt: otptxt.length > i ? otptxt[i] : "-"));
    }
    return Row(
      children: otplist,
    );
  }
    _verifyPhone() async {

    }
  }