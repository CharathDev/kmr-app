import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'material.dart';
import 'ADMIN_user_request.dart';

class ADMINHomePage extends StatefulWidget {
  const ADMINHomePage({super.key});
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
  State<ADMINHomePage> createState() => _ADMINHomePageState();
}

class _ADMINHomePageState extends State<ADMINHomePage> {
  reviewedUser(name, doctors, id) {
    setState(() {
      FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .update({'doctors': doctors});
      for (Map<String, dynamic> i in ADMINHomePage.newRecords) {
        if (i['name'] == name) {
          ADMINHomePage.newRecords[ADMINHomePage.newRecords.indexOf(i)]
              ['doctors'] = doctors;
          break;
        }
      }
    });
  }

  Future<List<Map<String, dynamic>>> getUserList() async {
    final List<Map<String, dynamic>> userList = [];
    await FirebaseFirestore.instance
        .collection("reviews")
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        userList.add(docSnapshot.data());
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
              children: [
                Text(
                  "User Requests",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        leadingWidth: 0,
                        toolbarHeight: 0,
                        bottom: MyTabBar(
                          child: TabBar(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.15,
                                0,
                                MediaQuery.of(context).size.width * 0.15,
                                0),
                            tabs: [
                              Tab(text: "New"),
                              Tab(text: "Reviewed"),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.008,
                                right:
                                    MediaQuery.of(context).size.width * 0.008,
                                top: 20,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: UserRecords(
                                    id: snapshot.data![index]['id'],
                                    name: snapshot.data![index]['fullName'],
                                    email: snapshot.data![index]['email'],
                                    ic: snapshot.data![index]['icNumber'],
                                    values: snapshot.data![index]['BSSK'],
                                    reviewed: snapshot.data![index]['reviewed'],
                                    colour: Color(0xffe7ffce),
                                    reviewedUser: reviewedUser,
                                  ),
                                );
                              }),
                          ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.008,
                                right:
                                    MediaQuery.of(context).size.width * 0.008,
                                top: 20,
                              ),
                              itemCount: ADMINHomePage.oldRecords.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: UserRecords(
                                    name: ADMINHomePage.oldRecords[index]
                                        ['name'],
                                    email: ADMINHomePage.oldRecords[index]
                                        ['email'],
                                    ic: ADMINHomePage.oldRecords[index]['ic'],
                                    values: ADMINHomePage.oldRecords[index]
                                        ['values'],
                                    reviewed: ADMINHomePage.oldRecords[index]
                                        ['reviewed'],
                                    colour: Color(0xffd9d9d9),
                                    reviewedUser: reviewedUser,
                                    id: "",
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
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
  const UserRecords({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.ic,
    required this.values,
    required this.reviewed,
    required this.colour,
    required this.reviewedUser,
  });
  final String name;
  final String email;
  final String ic;
  final String id;
  final Map<String, dynamic> values;
  final bool reviewed;
  final Color colour;
  final Function reviewedUser;

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
                  builder: (context) => ADMINUserRequestPage(
                        id: id,
                        name: name,
                        email: email,
                        ic: ic,
                        values: values,
                        reviewed: reviewed,
                        reviewedUser: reviewedUser,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: colour),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: Color(0xff14213d),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
