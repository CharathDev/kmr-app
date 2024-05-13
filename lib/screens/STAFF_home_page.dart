import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/STAFF_user_request.dart';
import 'material.dart';
import 'ADMIN_user_request.dart';

class STAFFHomePage extends StatefulWidget {
  const STAFFHomePage({super.key});
  static final List<Map<String, dynamic>> newRecords = [
    {
      'doctors': [],
      'name': 'Andrew Lee',
      'email': 'andrewlee@gmail.com',
      'ic': "098340923494",
      'reviewed': false,
      'values': {
        'a1': 'Lew Jia Jin',
        'a2': 'Male',
        'a3': '09/09/2008',
        'a4': '0809039123',
        'a5': 'Malaysia',
        'a5ii': 'unset',
        'a6': 'Chinese',
        'a7': 'Secondary',
        'a8': 'studying',
        'a8i': 'unset',
        'a8ii': 'FC',
        'a9': 'married',
        'a9i': '100',
        'a9ii': 'unset',
        'a10': '6, Washington',
        'a11a': '431243242',
        'a11b': '423423',
        'a12': 'logan@gmail.com',
        'a13': 'unset',
        'b1a': ['b1ai'],
        'b1b': [],
        'b1c': ['b1ci', 'b1cii'],
        'b1d': [],
        'b1e': [],
        'b1f': ['b1fii'],
        'b2': 'n',
        'b3a': 'n',
        'b3b': 'y',
        'b3bi': 'dsd',
        'b4': 'y',
        'b4i': 'dd',
        'c1': 'n',
        'd1a': 'y',
        'd1b': 'y',
        'd1c': 'n',
        'd2a': 'y',
        'd2b': 'n',
        'd2c': 'y',
        'd2d': 'n',
        'd2e': 'y',
        'd3': 'Fat',
        'e1': 'n',
        'e2': 'n',
        'f1a': 'y',
        'f1b': 'n',
        'f1c': 'y',
        'f1d': 'y',
        'f1di': 'dsd',
        'f2a': 'y',
        'f2b': 'n',
        'f3': 'n',
        'f4': 'n',
        'f5': 'n',
        'f6': 'n',
        'f7a': 'n',
        'f7b': 'n',
        'f7c': 'n',
        'f8': 'unset',
        'f9': 'unset',
        'f10': 'unset',
        'f11': 'unset',
        'f12': 'unset',
        'g1a': 'y',
        'g1b': 'n',
        'g1c': 'y',
        'g1d': 'y',
        'g1di': 'dsd',
        'h1a': 'n',
        'h1b': 'y',
        'h1c': 'n',
        'h1d': 'n',
        'h2a': 'y',
        'h2b': 'n',
        'h2c': 'y',
        'h2d': 'n',
        'h2e': 'n',
        'h2f': 'n',
        'i1': 'n',
        'j1': ["j1a", "j1b"],
        'j2': 'n',
        'j3a': 'y',
        'j3b': 'n',
        'j3c': 'y',
        'j3d': 'n',
        'j3e': 'n',
        'j3f': 'y',
        'j3g': 'y',
        'k1': 'n',
      }
    },
    {
      'doctors': [],
      'name': 'Edward Teoh',
      'email': 'teohedward@gmail.com',
      'ic': "09301238009",
      'reviewed': false,
      'values': {
        'a1': 'unset',
        'a2': 'unset',
        'a3': 'unset',
        'a4': 'unset',
        'a5': 'unset', //a5 == "Others" => check a5ii
        'a5ii': 'unset',
        'a6': 'unset',
        'a7': 'unset',
        'a8':
            'unset', //a8 == "working" => check a8i elif (a8 == "school") check a8ii
        'a8i': 'unset',
        'a8ii': 'unset',
        'a9':
            'unset', //a9 =="married" => check a9i elif (a9 == "widow/widower") check a9ii
        'a9i': 'unset',
        'a9ii': 'unset',
        'a10': 'unset',
        'a11a': 'unset',
        'a11b': 'unset',
        'a12': 'unset',
        'a13': 'unset',
        'b1ai': 'n',
        'b1aii': 'n',
        'b1bi': 'n',
        'b1bii': 'n',
        'b1ci': 'n',
        'b1cii': 'n',
        'b1di': 'n',
        'b1dii': 'n',
        'b1ei': 'n',
        'b1eii': 'n',
        'b1fi': 'n',
        'b1fii': 'n',
        'b2': 'unset',
        'b3a': 'unset',

        'b3b': 'unset',
        'b3bi': 'unset', // if b3b yes
        'b4': 'unset',
        'b4i': 'unset', //if b4 yes
        'c1': 'unset',
        'd1a': 'unset',
        'd1b': 'unset',
        'd1c': 'unset',
        'd2a': 'unset',
        'd2b': 'unset',
        'd2c': 'unset',
        'd2d': 'unset',
        'd2e': 'unset',
        'd3': 'unset',
        'e1': 'unset',
        'e2': 'unset',
        'f1a': 'unset',
        'f1b': 'unset',
        'f1c': 'unset',
        'f1d': 'unset',
        'f1di': 'unset', // if f1d yes
        'f2a': 'unset',
        'f2b': 'unset',
        'f3': 'unset',
        'f4': 'unset',
        'f5': 'unset',
        'f6': 'unset',
        'f7a': 'unset',
        'f7b': 'unset',
        'f7c': 'unset',
        'f8': 'unset',
        'f9': 'unset',
        'f10': 'unset',
        'f11': 'unset',
        'f12': 'unset',
        'g1a': 'unset',
        'g1b': 'unset',
        'g1c': 'unset',
        'g1d': 'unset',
        'g1di': 'unset', //if g1d yes
        'h1a': 'unset',
        'h1b': 'unset',
        'h1c': 'unset',
        'h1d': 'unset',
        'h2a': 'unset',
        'h2b': 'unset',
        'h2c': 'unset',
        'h2d': 'unset',
        'h2e': 'unset',
        'h2f': 'unset',
        'i1': 'unset',
        'j1a': 'unset',
        'j1b': 'unset',
        'j1c': 'unset',
        'j1d': 'unset',
        'j1e': 'unset',
        'j1f': 'unset',
        'j1g': 'unset',
        'j1h': 'unset',
        'j2': 'unset',
        'j3a': 'unset',
        'j3b': 'unset',
        'j3c': 'unset',
        'j3d': 'unset',
        'j3e': 'unset',
        'j3f': 'unset',
        'j3g': 'unset',
        'k1': 'unset',
      },
    },
  ];
  static final List<Map<String, dynamic>> oldRecords = [
    {
      'doctors': ['Occupational Therapist'],
      'name': 'Andrew Lee',
      'email': 'andrewlee@gmail.com',
      'ic': "098340923494",
      'reviewed': true,
      'values': {
        'a1': 'unset',
        'a2': 'unset',
        'a3': 'unset',
        'a4': 'unset',
        'a5': 'unset', //a5 == "Others" => check a5ii
        'a5ii': 'unset',
        'a6': 'unset',
        'a7': 'unset',
        'a8':
            'unset', //a8 == "working" => check a8i elif (a8 == "school") check a8ii
        'a8i': 'unset',
        'a8ii': 'unset',
        'a9':
            'unset', //a9 =="married" => check a9i elif (a9 == "widow/widower") check a9ii
        'a9i': 'unset',
        'a9ii': 'unset',
        'a10': 'unset',
        'a11a': 'unset',
        'a11b': 'unset',
        'a12': 'unset',
        'a13': 'unset',
        'b1ai': 'n',
        'b1aii': 'n',
        'b1bi': 'n',
        'b1bii': 'n',
        'b1ci': 'n',
        'b1cii': 'n',
        'b1di': 'n',
        'b1dii': 'n',
        'b1ei': 'n',
        'b1eii': 'n',
        'b1fi': 'n',
        'b1fii': 'n',
        'b2': 'unset',
        'b3a': 'unset',

        'b3b': 'unset',
        'b3bi': 'unset', // if b3b yes
        'b4': 'unset',
        'b4i': 'unset', //if b4 yes
        'c1': 'unset',
        'd1a': 'unset',
        'd1b': 'unset',
        'd1c': 'unset',
        'd2a': 'unset',
        'd2b': 'unset',
        'd2c': 'unset',
        'd2d': 'unset',
        'd2e': 'unset',
        'd3': 'unset',
        'e1': 'unset',
        'e2': 'unset',
        'f1a': 'unset',
        'f1b': 'unset',
        'f1c': 'unset',
        'f1d': 'unset',
        'f1di': 'unset', // if f1d yes
        'f2a': 'unset',
        'f2b': 'unset',
        'f3': 'unset',
        'f4': 'unset',
        'f5': 'unset',
        'f6': 'unset',
        'f7a': 'unset',
        'f7b': 'unset',
        'f7c': 'unset',
        'f8': 'unset',
        'f9': 'unset',
        'f10': 'unset',
        'f11': 'unset',
        'f12': 'unset',
        'g1a': 'unset',
        'g1b': 'unset',
        'g1c': 'unset',
        'g1d': 'unset',
        'g1di': 'unset', //if g1d yes
        'h1a': 'unset',
        'h1b': 'unset',
        'h1c': 'unset',
        'h1d': 'unset',
        'h2a': 'unset',
        'h2b': 'unset',
        'h2c': 'unset',
        'h2d': 'unset',
        'h2e': 'unset',
        'h2f': 'unset',
        'i1': 'unset',
        'j1a': 'unset',
        'j1b': 'unset',
        'j1c': 'unset',
        'j1d': 'unset',
        'j1e': 'unset',
        'j1f': 'unset',
        'j1g': 'unset',
        'j1h': 'unset',
        'j2': 'unset',
        'j3a': 'unset',
        'j3b': 'unset',
        'j3c': 'unset',
        'j3d': 'unset',
        'j3e': 'unset',
        'j3f': 'unset',
        'j3g': 'unset',
        'k1': 'unset',
      },
    },
    {
      'doctors': ['Counsellor'],
      'name': 'Edward Teoh',
      'email': 'teohedward@gmail.com',
      'ic': "09301238009",
      'reviewed': true,
      'values': {
        'a1': 'unset',
        'a2': 'unset',
        'a3': 'unset',
        'a4': 'unset',
        'a5': 'unset', //a5 == "Others" => check a5ii
        'a5ii': 'unset',
        'a6': 'unset',
        'a7': 'unset',
        'a8':
            'unset', //a8 == "working" => check a8i elif (a8 == "school") check a8ii
        'a8i': 'unset',
        'a8ii': 'unset',
        'a9':
            'unset', //a9 =="married" => check a9i elif (a9 == "widow/widower") check a9ii
        'a9i': 'unset',
        'a9ii': 'unset',
        'a10': 'unset',
        'a11a': 'unset',
        'a11b': 'unset',
        'a12': 'unset',
        'a13': 'unset',
        'b1ai': 'n',
        'b1aii': 'n',
        'b1bi': 'n',
        'b1bii': 'n',
        'b1ci': 'n',
        'b1cii': 'n',
        'b1di': 'n',
        'b1dii': 'n',
        'b1ei': 'n',
        'b1eii': 'n',
        'b1fi': 'n',
        'b1fii': 'n',
        'b2': 'unset',
        'b3a': 'unset',

        'b3b': 'unset',
        'b3bi': 'unset', // if b3b yes
        'b4': 'unset',
        'b4i': 'unset', //if b4 yes
        'c1': 'unset',
        'd1a': 'unset',
        'd1b': 'unset',
        'd1c': 'unset',
        'd2a': 'unset',
        'd2b': 'unset',
        'd2c': 'unset',
        'd2d': 'unset',
        'd2e': 'unset',
        'd3': 'unset',
        'e1': 'unset',
        'e2': 'unset',
        'f1a': 'unset',
        'f1b': 'unset',
        'f1c': 'unset',
        'f1d': 'unset',
        'f1di': 'unset', // if f1d yes
        'f2a': 'unset',
        'f2b': 'unset',
        'f3': 'unset',
        'f4': 'unset',
        'f5': 'unset',
        'f6': 'unset',
        'f7a': 'unset',
        'f7b': 'unset',
        'f7c': 'unset',
        'f8': 'unset',
        'f9': 'unset',
        'f10': 'unset',
        'f11': 'unset',
        'f12': 'unset',
        'g1a': 'unset',
        'g1b': 'unset',
        'g1c': 'unset',
        'g1d': 'unset',
        'g1di': 'unset', //if g1d yes
        'h1a': 'unset',
        'h1b': 'unset',
        'h1c': 'unset',
        'h1d': 'unset',
        'h2a': 'unset',
        'h2b': 'unset',
        'h2c': 'unset',
        'h2d': 'unset',
        'h2e': 'unset',
        'h2f': 'unset',
        'i1': 'unset',
        'j1a': 'unset',
        'j1b': 'unset',
        'j1c': 'unset',
        'j1d': 'unset',
        'j1e': 'unset',
        'j1f': 'unset',
        'j1g': 'unset',
        'j1h': 'unset',
        'j2': 'unset',
        'j3a': 'unset',
        'j3b': 'unset',
        'j3c': 'unset',
        'j3d': 'unset',
        'j3e': 'unset',
        'j3f': 'unset',
        'j3g': 'unset',
        'k1': 'unset',
      },
    },
  ];

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
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 3.5,
                      ),
                      primary: false,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: 20,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 180,
                          margin: const EdgeInsets.all(1.0),
                          child: UserRecords(
                            id: snapshot.data![index]['id'],
                            name: snapshot.data![index]['fullName'],
                            email: snapshot.data![index]['email'],
                            ic: snapshot.data![index]['icNumber'],
                            values: snapshot.data![index]['BSSK'],
                            phoneNumber: snapshot.data![index]['phoneNumber'],
                            date: snapshot.data![index]['date'],
                            timeSlot: snapshot.data![index]['timeSlot'],
                            reviewedUser: reviewedUser,
                          ),
                        );
                      }),
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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
                              Text(phoneNumber),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.black54),
                              const SizedBox(width: 10),
                              Text(date),
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
