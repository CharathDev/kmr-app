import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/STAFF_user_request.dart';
import 'material.dart';

class STAFFHomePage extends StatefulWidget {
  const STAFFHomePage({super.key});

  @override
  State<STAFFHomePage> createState() => _STAFFHomePageState();
}

class _STAFFHomePageState extends State<STAFFHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  reviewedUser(name, doctors, id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .update({'doctors': doctors});
    });
  }

  Future<List<Map<String, dynamic>>> getUserList() async {
    final List<Map<String, dynamic>> userList = [];
    await FirebaseFirestore.instance
        .collection("Appointments")
        .get()
        .then((querySnapshot) async {
      for (var docSnapshot in querySnapshot.docs) {
        if (docSnapshot.data()["staffID"] == user.uid) {
          var userInfo = await FirebaseFirestore.instance
              .collection('users')
              .doc(docSnapshot.data()["userID"])
              .get()
              .then((value) => value.data());
          var date = docSnapshot.data()["date"].toString().split(" ");
          var finalDate = date[0] + "/" + date[1] + "/" + date[2];
          var tempData = {
            "id": docSnapshot.id,
            "fullName": userInfo!["fullName"],
            "email": userInfo["email"],
            "icNumber": userInfo["icNumber"],
            "BSSK": userInfo["BSSK"],
            "phoneNumber": userInfo["phoneNumber"],
            "date": finalDate,
            "timeSlot": docSnapshot.data()["timeSlots"],
          };
          userList.add(tempData);
        }
      }
    });
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Map<String, dynamic>>>(
      future: getUserList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Appointment Tracking",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: (snapshot.data!.isNotEmpty)
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: 20,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: UserRecords(
                                id: snapshot.data![index]['id'],
                                name: snapshot.data![index]['fullName'],
                                email: snapshot.data![index]['email'],
                                ic: snapshot.data![index]['icNumber'],
                                values: snapshot.data![index]['BSSK'],
                                phoneNumber: snapshot.data![index]
                                    ['phoneNumber'],
                                date: snapshot.data![index]['date'],
                                timeSlot: snapshot.data![index]['timeSlot'],
                                reviewedUser: reviewedUser,
                              ),
                            );
                          })
                      : Expanded(
                          child: Container(
                            child: Center(
                              child: Text("No new user requests found."),
                            ),
                          ),
                        ),
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}

class UserRecords extends StatelessWidget {
  UserRecords({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.ic,
    required this.values,
    required this.reviewedUser,
    required this.phoneNumber,
    required this.date,
    required this.timeSlot,
  });
  final String name;
  final String email;
  final String ic;
  final String id;
  final String phoneNumber;
  final String date;
  final int timeSlot;
  final Map<String, dynamic> values;
  final Function reviewedUser;

  final List<String> _timeSlots = [
    '9:00 am - 10:00 am',
    '10:00 am - 11:00 am',
    '11:00 am - 12:00 pm',
    '1:00 pm - 2:00 pm',
    '2:00 pm - 3:00 pm',
    '3:00 pm - 3:45 pm',
    '3:00 pm - 4:00 pm',
    '4:00 pm - 5:00 pm',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => STAFFUserRequestPage(
                        id: id,
                        name: name,
                        email: email,
                        ic: ic,
                        values: values,
                        reviewedUser: reviewedUser,
                      )));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xffe7ffce),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Color(0xff14213d),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                // Ensure the row takes the remaining height
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      // Makes the column take half the row space
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Adds space distribution
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.black54),
                              const SizedBox(width: 10),
                              Expanded(child: Text(phoneNumber)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.black54),
                              const SizedBox(width: 10),
                              Expanded(child: Text(date)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      // Makes the column take half the row space
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Adds space distribution
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email, color: Colors.black54),
                              const SizedBox(width: 10),
                              Expanded(child: Text(email)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.black54),
                              const SizedBox(width: 10),
                              Expanded(child: Text(_timeSlots[timeSlot])),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
