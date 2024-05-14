import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kmrapp/screens/tca_appointment_review.dart';
import 'package:table_calendar/table_calendar.dart';

class TCAAppointmentPage extends StatefulWidget {
  final DocumentReference staffData;
  final DocumentReference userData;
  const TCAAppointmentPage(
      {super.key, required this.staffData, required this.userData});

  @override
  _TCAAppointmentPageState createState() => _TCAAppointmentPageState();
}

class _TCAAppointmentPageState extends State<TCAAppointmentPage> {
  final user = FirebaseAuth.instance.currentUser!;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> userInfo = [];
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allAppointments = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTimeSlot;
  late String staffID;

  // Dummy time slots for the sake of example.
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getStaffInfo() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userInfoTemp = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> allAppointmentsTemp = [];
    FirebaseFirestore.instance
        .collection('Appointments')
        .get()
        .then((value) async {
      for (var docSnapshot in value.docs) {
        if (docSnapshot.data()["userID"] == user.uid) {
          userInfoTemp.add(docSnapshot);
        }
        allAppointmentsTemp.add(docSnapshot);
      }
    });
    userInfo = userInfoTemp;
    allAppointments = allAppointmentsTemp;
    return await widget.staffData.get()
        as DocumentSnapshot<Map<String, dynamic>>;
  }

  void bookAppointment(Map<String, dynamic> data) async {
    var staffId = await widget.staffData.get().then((value) => value.id);
    String doc = _selectedDay!.day.toString() +
        " " +
        _selectedDay!.month.toString() +
        " " +
        _selectedDay!.year.toString();
    FirebaseFirestore.instance.collection('Appointments').doc().set({
      "timeSlots": _timeSlots.indexOf(_selectedTimeSlot!),
      "date": doc,
      "userID": user.uid,
      "staffID": staffId,
    }, SetOptions(merge: true));
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> isFreeList() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
    staffID = await widget.staffData.get().then((value) => value.id);
    await FirebaseFirestore.instance
        .collection('Appointments')
        .get()
        .then((value) {
      for (var docSnapshot in value.docs) {
        var data = docSnapshot.data();
        if (data['staffID'] == staffID) list.add(docSnapshot);
      }
    });

    return list;
  }

  bool isFree(DateTime day, Map<String, dynamic> staffData,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> list) {
    String dbDoc = day.day.toString() +
        " " +
        day.month.toString() +
        " " +
        day.year.toString();

    var timeSlotsLength = {};

    for (var docSnapshot in allAppointments) {
      final data = docSnapshot.data();
      if ((data["userID"] == user.uid || data["staffID"] == staffID) &&
          data["date"] == dbDoc) {
        if (!timeSlotsLength.containsKey(docSnapshot.id)) {
          timeSlotsLength[docSnapshot.id] = data["timeSlots"];
        }
      }
      if (timeSlotsLength.length == staffData["timeSlots"].length) {
        return false;
      }
    }

    return true;
  }

  bool isTimeSlotFree(DateTime day, Map<String, dynamic> staffData,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> list, int i) {
    String dbDoc = day.day.toString() +
        " " +
        day.month.toString() +
        " " +
        day.year.toString();
    for (var docSnapshot in list) {
      final data = docSnapshot.data();
      if ((data["staffID"] == staffID || data["userID"] == user.uid) &&
          data["date"] == dbDoc) {
        if (data["timeSlots"] == staffData["timeSlots"][i]) {
          return false;
        }
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          titleSpacing: 0,
          centerTitle: true,
          title: _buildAppBarTitle(),
        ),
        body: FutureBuilder(
            future: getStaffInfo(),
            builder: (context, snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              } else {
                final data = snapshot.data!.data();
                _selectedDay = _focusedDay;
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            "Schedule your appointment with",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            data!["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          _buildTableCalendar(data),
                          _buildTimeSlots(data),
                          const SizedBox(height: 100),
                          _buildBookAppointmentButton(data),
                        ],
                      ),
                    ));
              }
            }));
  }

  Widget _buildAppBarTitle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xffDFCEFA),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 24,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 24.0,
                  color: Color.fromARGB(255, 150, 111, 214),
                ),
              ),
            ),
            const Text(
              'TCA / BSSK',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff966FD6),
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendar(Map<String, dynamic> data) {
    return Column(
      children: [
        FutureBuilder(
            future: isFreeList(),
            builder: (context, list) {
              if (!list.hasData &&
                  list.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              } else {
                return TableCalendar(
                  daysOfWeekHeight: 30,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  enabledDayPredicate: (day) {
                    bool isFreeBool = isFree(day, data, list.data!);
                    for (int dayDB in data["days"]) {
                      if (dayDB == day.weekday && isFreeBool) {
                        return true;
                      }
                    }

                    return false;
                  },
                  onPageChanged: (focusedDay) =>
                      setState(() => _focusedDay = focusedDay),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronVisible: true,
                    rightChevronVisible: true,
                    headerMargin: const EdgeInsets.only(
                        bottom:
                            30), // Creates a gap between the header title and the calendar grid
                    leftChevronPadding: const EdgeInsets.only(
                        left: 16), // Adds padding to the left chevron
                    rightChevronPadding: const EdgeInsets.only(
                        right: 16), // Adds padding to the right chevron

                    titleTextStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  Widget _buildTimeSlots(Map<String, dynamic> data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the width of the buttons based on the screen width and desired padding
        double buttonWidth = (constraints.maxWidth - 10) /
            2; // Subtracting the spacing between the buttons

        return FutureBuilder(
            future: isFreeList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              } else {
                final list = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: buttonWidth /
                        48, // Adjust based on your button's height
                  ),
                  itemCount: data["timeSlots"].length,
                  itemBuilder: (context, index) {
                    if (isTimeSlotFree(_selectedDay!, data, list, index)) {
                      bool isSelected = _selectedTimeSlot ==
                          _timeSlots[data["timeSlots"][index]];
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTimeSlot =
                                _timeSlots[data["timeSlots"][index]];
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              isSelected ? Colors.white : Colors.black,
                          backgroundColor:
                              isSelected ? Colors.deepPurple : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          _timeSlots[data["timeSlots"][index]],
                          style: const TextStyle(
                            fontSize: 12, // This is your font size
                          ),
                        ),
                      );
                    }
                  },
                  padding: EdgeInsets.zero, // No additional padding
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              }
            });
      },
    );
  }

  Widget _buildBookAppointmentButton(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      width:
          double.infinity, // Ensure the button takes the full width available
      child: ElevatedButton(
        onPressed: () {
          if (_selectedDay != null && _selectedTimeSlot != null) {
            bookAppointment(data);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TCAAppointmentReview(
                      day: _selectedDay!,
                      timeSlot: _selectedTimeSlot!,
                      name: data["name"])),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(
            vertical: 35.0,
          ), // Add more vertical padding for height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                50.0), // Match the border radius as per design
          ),
        ),
        child: const Text(
          'Book Appointment',
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
