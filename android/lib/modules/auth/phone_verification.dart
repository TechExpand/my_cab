import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../constance/global.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../../Language/appLocalizations.dart';
import '../../constance/constance.dart';
import '../../constance/themes.dart';
import '../home/home_screen.dart';


String _verificationCode;
var pin;
double lat;
double long;
class PhoneVerification extends StatefulWidget {
  final String email;
  final String phone;
  final String fullname;

  PhoneVerification(this.phone, this.fullname, this.email);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

  class _PhoneVerificationState extends State<PhoneVerification> with SingleTickerProviderStateMixin {
    AnimationController animationController;
    var otpController = new TextEditingController();
    Position currentPosition;

    void setUpGeolocation() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      currentPosition = position;
    }

    @override
    void initState() {
      setUpGeolocation();
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
                                                      Tween(
                                                          begin: 0.4, end: 1.0)
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
                                                      Tween(
                                                          begin: 0.8, end: 1.0)
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
                              _emailUI(),
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
                                AppLocalizations.of('Phone Verification'),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline3
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
            child: getOtpTextUI(otptxt: otpController.text),
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
                              keyboardType: TextInputType.number,
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
        padding: const EdgeInsets.only(
            left: 24, right: 16, top: 30, bottom: 30),
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
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode,
                      smsCode: otpController.text))
                      .then((value) async {
                    if (value.user != null) {
                      await value.user.updateProfile(
                          displayName: widget.fullname);
                      final user1 = FirebaseAuth.instance.currentUser;
                      await value.user.reload();
                      DatabaseReference newUserRef = FirebaseDatabase.instance
                          .reference().child('user/${value.user.uid}');
                      Map userMap = {
                        'fullname': widget.fullname,
                        'email': widget.email,
                        'phone': widget.phone,
                      };
                      newUserRef.set(userMap);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            HomeScreen(currentPosition.latitude,
                                currentPosition.longitude)),
                      );
                    }
                  });
                } catch (err) {
                  print(err);
                  switch (err.code) {
                    case "ERROR_EMAIL_ALREADY_IN_USE":
                    case "account-exists-with-different-credential":
                    case "email-already-in-use":
                      return "";
                      //   Fluttertoast.showToast(
                      //     msg: "Phone already used. Go to login page.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    case "ERROR_WRONG_PASSWORD":
                    case "wrong-password":
                      return "";
                      //   Fluttertoast.showToast(
                      //     msg: "Wrong email/password combination.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    case "ERROR_USER_NOT_FOUND":
                    case "user-not-found":
                      return "";
                      // Fluttertoast.showToast(
                      //     msg: "No user found with this phone number.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    case "ERROR_USER_DISABLED":
                    case "user-disabled":
                      return "";
                      // Fluttertoast.showToast(
                      //     msg: "User disabled.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    case "ERROR_TOO_MANY_REQUESTS":
                    case "operation-not-allowed":
                      return "";
                      // Fluttertoast.showToast(
                      //     msg: "Too many requests to log into this account.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    case "ERROR_OPERATION_NOT_ALLOWED":
                    case "operation-not-allowed":
                      return "";
                      // Fluttertoast.showToast(
                      //     msg: "Server error, please try again later.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    case "ERROR_INVALID_EMAIL":
                    case "invalid-email":
                      return "";
                      // Fluttertoast.showToast(
                      //     msg: "Email address is invalid.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                    default:
                      return "";
                      // Fluttertoast.showToast(
                      //     msg: "Login failed. Please try again.",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 6,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0
                      // );
                      break;
                  }
                }
              },
              child: Center(
                child: Text(
                  AppLocalizations.of("Verify now"),
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                        .headline3
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
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: widget.phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              print(value);
              if (value.user != null) {
                await value.user.updateProfile(displayName: widget.fullname);
                final user1 = FirebaseAuth.instance.currentUser;
                await value.user.reload();
                print(user1);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      HomeScreen(
                          currentPosition.latitude, currentPosition.longitude)),
                );
              }
            });
          },

          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
            // Fluttertoast.showToast(
            //     msg: e.message,
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 20,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );
          },
          codeSent: (String verficationID, int resendToken) {
            setState(() {
              _verificationCode = verficationID;
            });
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            setState(() {
              _verificationCode = verificationID;
            });
          },
          timeout: Duration(seconds: 20));
    }
  }