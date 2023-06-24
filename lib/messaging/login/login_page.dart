import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/common/extension_method.dart';
import 'package:halo/messaging/home/home_page.dart';
import 'package:halo/services/provider.dart';
import 'package:halo/util/custom_button.dart';
import 'package:halo/shared_preference/shared_preference.dart';

import '../../models/user_data.dart';
import '../landing/custom_cricle.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with TickerProviderStateMixin {
  bool isOtpSend = false;
  bool isNewAccount = false;
  String verificationIdVerify = "";
  late AnimationController _controller;
  late Animation<double> _animation;
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _otpController = TextEditingController();

  bool isLoading = false, otpVerify = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  _toggleContainer() {
    if (kDebugMode) {
      print(_animation.status);
    }
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      Positioned(
        right: 120,
        top: -20,
        child: CustomCircle(color: Theme.of(context).colorScheme.primary),
      ),
      Positioned(
        left: 120,
        top: 220,
        child: CustomCircle(color: Theme.of(context).colorScheme.onSurface),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Hi, Welcome to\nHalo chat!✌",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 35, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 1,
              maxLength: 10,
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                labelText: "Phone Number",
                labelStyle: Theme.of(context).textTheme.headlineMedium,
              ),
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (isOtpSend)
              SizeTransition(
                sizeFactor: _animation,
                axis: Axis.vertical,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "We have sent OTP on 8239379028",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 200,
                        child: Center(
                          child: TextField(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              maxLength: 6,
                              style: Theme.of(context).textTheme.headlineMedium,
                              decoration: InputDecoration(
                                hintText: "Enter OTP here",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    borderRadius: BorderRadius.circular(15)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 0),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              keyboardType: TextInputType.phone,
                              controller: _otpController),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      )
                    ],
                  ),
                ),
              ),
            GestureDetector(
                onTap: () async {
                  if (isLoading) return;
                  if (!isOtpSend) {
                    if(_phoneController.text.isNotEmpty && _phoneController.text.length>=10) {
                      setState(() {
                        isLoading = true;
                      });
                      registerUser("+91${_phoneController.text.trim()}");
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        _toggleContainer();
                      });
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      CommonMethod.showFlushBar(context, "Please enter valid phone number...");
                    }
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    verifyOtp("+91${_phoneController.text.trim()}", _otpController.text);
                  }
                },
                child: CustomButton(
                  size: MediaQuery.of(context).size.width * 0.9,
                  text: "Sign In",
                  isLoading: isLoading,
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_box,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  "I agree to terms and conditions ",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    ]));
  }

  Future createAccount(String mobile) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  }

  Future registerUser(String mobile) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: mobile,
      verificationCompleted: (AuthCredential authCredential) {
        firebaseAuth
            .signInWithCredential(authCredential)
            .then((UserCredential result) {})
            .catchError((e) {
          if (kDebugMode) {
            print("Error$e");
          }
        });
      },
      verificationFailed: (Exception authException) {
        CommonMethod.showToast(context, 'Failed, ${authException.toString()}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          isOtpSend = true;
        });
        verificationIdVerify = verificationId;
        CommonMethod.showToast(context, 'OTP Sent Successful');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        CommonMethod.showToast(context, 'Time Out. Try again...');
      },
    );
  }

  Future verifyOtp(String phoneNumber, String otp) async {
    if (otp.isEmpty) {
      CommonMethod.showToast(context, "Please enter Otp");
      setState(() {
        isLoading = false;
      });
      return;
    }
    if (otp.length < 6) {
      CommonMethod.showToast(context, "Please enter 6 digit otp");
      setState(() {
        isLoading = false;
      });
      return;
    }
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationIdVerify, smsCode: otp);
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);
      User? user = userCredential.user;
      bool? isNewUSer = userCredential.additionalUserInfo?.isNewUser;
      if (isNewUSer != null && isNewUSer) {
        setState(() {
          isLoading = false;
        });
        showModalBottomSheet(
            context: context,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            elevation: 10,
            barrierColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            builder: (BuildContext context) {
              return showModalBottomSheetName(user);
            }
        );
        if (isNewAccount) {
        }
      } else {
        if (user != null) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }), ModalRoute.withName("home"));
          setState(() {
            isLoading = false;
          });
          SharedPreference.setUserLogin(true);
          SharedPreference.setUserName(phoneNumber);
        } else {
          CommonMethod.showToast(context, "Wrong Otp. Please try again...");
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (exception) {
      CommonMethod.showToast(context, "Went something wrong! try again...");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget showModalBottomSheetName(User? user) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 10,
            width: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          TextField(
            maxLines: 1,
            maxLength: 15,
            style: Theme.of(context).textTheme.displayMedium,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(15)),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              labelText: "Full Name",
              hintText: "Enter full name here...",
              labelStyle: Theme.of(context).textTheme.headlineMedium,
            ),
            keyboardType: TextInputType.text,
            controller: _fullNameController,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if(_fullNameController.text.isEmpty) {
                CommonMethod.showFlushBar(
                    context, "Please Enter Your Name..");
              } else {
                Navigator.pop(context);
                setState(() {
                  isLoading = true;
                  try {
                    ref.read(nameProvider).setName(_fullNameController.text);
                    final database = ref.read(databaseProvider);
                    if (kDebugMode) {
                      print("database");
                    }
                    String? userId = user?.uid;
                    if (userId != null) {
                      if (kDebugMode) {
                        print("userId not null $userId");
                      }
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      firestore.collection("users").doc(userId).set(
                          UserData(name: ref
                              .read(nameProvider)
                              .name,
                              uid: userId,
                              phoneNumber: "+91${_phoneController.text.trim()}")
                              .toMap());
                      if (kDebugMode) {
                        print("database not null $database");
                      }
                    } else {
                      if (kDebugMode) {
                        print("userId  null ");
                      }
                    }
                    if (kDebugMode) {
                      print("created with email and password success");
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print("found error$e");
                    }
                  }
                  if (user != null) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }), ModalRoute.withName("home"));
                    setState(() {
                      isLoading = false;
                    });
                    SharedPreference.setUserLogin(true);
                    SharedPreference.setUserName(_fullNameController.text);
                  } else {
                    CommonMethod.showToast(
                        context, "Wrong Otp. Please try again...");
                    setState(() {
                      isLoading = false;
                    });
                  }
                });
              }
            },
            child: CustomButton(
              size: MediaQuery.of(context).size.width * 0.9,
              text: "Save Name",
              isLoading: isLoading,
            ),
          )
        ],
      ),
    );
  }
}
