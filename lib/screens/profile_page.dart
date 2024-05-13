import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/login.dart';
import 'material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController nameController = new TextEditingController();

  final TextEditingController icController = new TextEditingController();

  final TextEditingController phoneNumberController =
      new TextEditingController();

  final TextEditingController emailController = new TextEditingController();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData &&
            snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        } else {
          final data = snapshot.data!.data()!;
          nameController.text = data["fullName"];
          icController.text = data["icNumber"];
          phoneNumberController.text = data["phoneNumber"];
          emailController.text = data["email"];
          return Column(
            children: [
              Image.asset(
                'lib/assets/images/profile.png',
                width: 200,
              ),
              Expanded(
                child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  labelText: 'Full Name',
                                  hintText: data["fullName"],
                                ),
                                controller: nameController,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    labelText: 'IC Number',
                                    hintText: data["icNumber"]),
                                controller: icController,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    labelText: 'Phone Number',
                                    hintText: data["phoneNumber"]),
                                controller: phoneNumberController,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    labelText: 'E-mail',
                                    hintText: data["email"]),
                                controller: emailController,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                onPressed: () {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .update({
                                      "fullName": nameController.text,
                                      "icNumber": icController.text,
                                      "phoneNumber": phoneNumberController.text,
                                      "email": emailController.text,
                                    });
                                  });
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 50),
                                  decoration: BoxDecoration(
                                    color: Color(0xff966FD6),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    'Update Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  });
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[600],
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                                ],
                              ),
                              
                              
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
              ),
            ],
          );
        }
      },
    ));
  }
}
