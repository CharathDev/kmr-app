import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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

  Future<List<Map<String, dynamic>>> appointmentList(String userId) async {
    List<Map<String, dynamic>> list = [];
    await FirebaseFirestore.instance
        .collection('Appointments')
        .get()
        .then((value) async {
      for (var docSnapshot in value.docs) {
        Map<String, dynamic> tempData = {};
        var data = docSnapshot.data();
        if (data["userID"] == userId) {
          var tempInfo = await FirebaseFirestore.instance
              .collection('users')
              .doc(data["staffID"])
              .get()
              .then((value) => value.data());
          tempData["name"] = tempInfo!["name"];
          tempData["occupation"] = tempInfo["occupation"];
          tempData["timeSlot"] = data["timeSlots"];
          var date = data["date"].toString().split(' ');
          var finalDate = date[0] + "/" + date[1] + "/" + date[2];
          tempData["date"] = finalDate;
          list.add(tempData);
        }
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder(
        future: appointmentList(user.uid),
        builder: (context, list) {
          if (list.connectionState != ConnectionState.done && !list.hasData) {
            return CircularProgressIndicator();
          } else {
            var appointmentListData = list.data!;
            if (appointmentListData.isEmpty) {
              return Text('You do not have any upcoming appointments');
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 0, bottom: 14),
                itemCount: appointmentListData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22),
                          decoration: BoxDecoration(
                              color: const Color(0xff966FD6),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'lib/assets/images/profile.png',
                                    width: 60,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          appointmentListData[index]["name"],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        appointmentListData[index]
                                            ["occupation"],
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Ionicons.calendar,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        appointmentListData[index]["date"],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Ionicons.time_outline,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        _timeSlots[appointmentListData[index]
                                            ["timeSlot"]],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  );
                },
              );
            }
          }
        });
  }
}
