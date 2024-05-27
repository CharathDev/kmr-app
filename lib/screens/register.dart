import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kmrapp/screens/login.dart';
import 'package:kmrapp/screens/consent_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String nameErrorText = "";
  String emailErrorText = "";
  String icErrorText = "";
  String phoneErrorText = "";
  String passwordErrorText = "";
  String formErrorText = "";
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final icNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool filledConsentForm = false;

  void filledForm() {
    setState(() {
      filledConsentForm = true;
      formErrorText = "";
    });
  }

  void handleRegister() async {
    String fullName = fullNameController.text;
    String email = emailController.text;
    String icNumber = icNumberController.text;
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    int error = 0;

    if (password != confirmPassword) {
      setState(() {
        passwordErrorText = "Password does not match";
        error += 1;
      });
      return;
    }

    if (fullName.isEmpty) {
      setState(() {
        nameErrorText = "Required";
        error += 1;
      });
    }

    if (email.isEmpty) {
      setState(() {
        emailErrorText = "Required";
        error += 1;
      });
    }

    if (icNumber.isEmpty) {
      setState(() {
        icErrorText = "Required";
        error += 1;
      });
    }

    if (phoneNumber.isEmpty) {
      setState(() {
        phoneErrorText = "Required";
        error += 1;
      });
    }

    if (password.isEmpty) {
      setState(() {
        passwordErrorText = "Required";
        error += 1;
      });
    }

    if (!filledConsentForm) {
      setState(() {
        formErrorText = "Required";
        error += 1;
      });
    }

    if (error == 0) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the newly registered user's ID
        String userId = userCredential.user!.uid;

        // Store user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'fullName': fullName,
          'email': email,
          'icNumber': icNumber,
          'phoneNumber': phoneNumber,
          'isStaff': false,
        });
        //can change this
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Alert"),
              content: const Text("User registered successfully."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        // if fail
        print('Failed to register user: $e');
        print(e.code);
        if (e.code == "invalid-email") {
          setState(() {
            emailErrorText = "Invalid e-mail";
          });
        } else if (e.code == "weak-password") {
          setState(() {
            passwordErrorText = "Password should be at least 6 characters";
          });
        } else if (e.code == "email-already-in-use") {
          setState(() {
            emailErrorText = "E-mail already taken";
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffDFCEFA),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 14,
        ),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xffDFCEFA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'User Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff966FD6)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please fill in your personal informations required below',
                  style: TextStyle(color: Color(0xff966FD6), fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    errorText: nameErrorText.isNotEmpty ? nameErrorText : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Full Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      nameErrorText = "";
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                    errorText:
                        emailErrorText.isNotEmpty ? emailErrorText : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      emailErrorText = "";
                    });
                  },
                  controller: emailController, //initial value: "test@gmail.com"
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: icNumberController,
                  decoration: InputDecoration(
                    errorText: icErrorText.isNotEmpty ? icErrorText : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'IC Number',
                  ),
                  onChanged: (value) {
                    setState(() {
                      icErrorText = "";
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                      errorText:
                          phoneErrorText.isNotEmpty ? phoneErrorText : null,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: 'Phone Number'),
                  onChanged: (value) {
                    setState(() {
                      phoneErrorText = "";
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      passwordErrorText = "";
                    });
                  },
                  decoration: InputDecoration(
                    errorText:
                        passwordErrorText.isNotEmpty ? passwordErrorText : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      passwordErrorText = "";
                    });
                  },
                  decoration: InputDecoration(
                      errorText: passwordErrorText.isNotEmpty
                          ? passwordErrorText
                          : null,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: 'Confirm Password'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: filledConsentForm,
                      onChanged: (bool? value) {
                        if (value!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ConsentPage(
                                        filledForm: filledForm,
                                      ))));
                        } else {
                          setState(() {
                            filledConsentForm = false;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "I have filled up the consent form.",
                      ),
                    ),
                  ],
                ),
                if (formErrorText.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      formErrorText,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff966FD6),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: handleRegister, // Call the function here
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              'GET STARTED',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Login here'))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
