import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kmrapp/screens/login.dart';

class STAFFProfilePage extends StatefulWidget {
  const STAFFProfilePage({super.key});

  @override
  State<STAFFProfilePage> createState() => _STAFFProfilePageState();
}

class _STAFFProfilePageState extends State<STAFFProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController icController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

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
          nameController.text = data["name"];
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'Full Name',
                          hintText: "test",
                        ),
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            labelText: 'IC Number',
                            hintText: "test"),
                        controller: icController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelText: 'Phone Number',
                            hintText: "test"),
                        controller: phoneNumberController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            labelText: 'E-mail',
                            hintText: "test"),
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                print("updated user");
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
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff966FD6),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text(
                                'Update Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text(
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
                      const SizedBox(
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
