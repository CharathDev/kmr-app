import 'dart:math';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});
  static final List<Map<String, dynamic>> records = [
    {
      'BMI': '31.1',
      'status': 'Overweight',
      'date': '14/03/2024',
      'time': '2:30pm',
      'gender': 'Male',
      'age': '20',
      'height': '170',
      'weight': '90',
      'healthyweight1': '53.5',
      'healthyweight2': '72',
    },
  ];

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class BMIDataUpload {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadBMI(Map<String, dynamic> bmiData) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser.uid).collection('bmiRecords').add({
        ...bmiData,
        'timestamp': FieldValue.serverTimestamp() // Adds the time of data upload
      });
      print('Firebase: Data successfully uploaded for user ${currentUser.uid}');
    } else {
      throw Exception('No user logged in');
    }
  }
}


class _BMIPageState extends State<BMIPage> {
  late int month;
  late String year;
  late ValueNotifier<int> monthValue = ValueNotifier<int>(month);
  late ValueNotifier<String> yearValue = ValueNotifier<String>(year);
  late bool calculated;
  late String gender;
  late String age;
  late String height;
  late String weight;
  late String date;
  late String status;
  late double BMI;
  late double healthyweight1;
  late double healthyweight2;
  ScrollController listScrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  selectmonth(newmonth) {
    setState(() {
      month = newmonth;
      monthValue = ValueNotifier<int>(month);
    });
  }

  selectyear(newyear) {
    setState(() {
      year = newyear;
      yearValue = ValueNotifier<String>(year);
    });
  }

  selectage(newage) {
    setState(() {
      age = newage;
    });
  }

  selectgender(newgender) {
    setState(() {
      gender = newgender;
    });
  }

  selectheight(newheight) {
    setState(() {
      height = newheight;
    });
  }

  selectweight(newweight) {
    setState(() {
      weight = newweight;
    });
  }

  @override
  void initState() {
    super.initState();
    calculated = false;
    month = 2;
    year = "2024";
    gender = "Male";
    age = "20";
    height = "170";
    weight = "60";
    date = "23/3/2024";
    status = "Normal";
    BMI = 20.8;
    healthyweight1 = 55.2;
    healthyweight2 = 78;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                Tab(text: "New Record"),
                Tab(text: "History"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            calculated
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView(
                      controller: listScrollController,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Container(
                              child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.8,
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                  showAxisLine: false,
                                  showTicks: false,
                                  showLabels: false,
                                  backgroundImage:
                                      AssetImage("lib/assets/images/bmi.png"),
                                  startAngle: 180,
                                  endAngle: 360,
                                  minimum: 15.0,
                                  maximum: 45.0,
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                        value: BMI < 25 && BMI > 18.4
                                            ? 24.9 -
                                                ((24.9 - BMI) / (6.4 / 4.9))
                                            : BMI < 18.5 && BMI > 15
                                                ? 15 +
                                                    ((BMI - 15) / (3.4 / 4.9))
                                                : BMI)
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                            child: Text("$BMI",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: BMI < 18.5
                                                        ? Color(0xff87ADC7)
                                                        : BMI < 25.0
                                                            ? Color(0xff70C099)
                                                            : BMI < 30.0
                                                                ? Color(
                                                                    0xffF9D230)
                                                                : BMI < 35
                                                                    ? Color(
                                                                        0xffEF9852)
                                                                    : BMI < 40
                                                                        ? Color(
                                                                            0xffDF434A)
                                                                        : Color(
                                                                            0xffBD2B37),
                                                    fontWeight:
                                                        FontWeight.w400))),
                                        angle: 90,
                                        positionFactor: 0.4)
                                  ])
                            ]),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10.0,
                                  spreadRadius: -5,
                                )
                              ],
                            ),
                            child: Stack(
                              children: [
                                Card(
                                    color: Color(0xFFffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container()),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "$gender | ${age}y/o | ${height}cm | ${weight}kg",
                                            style: TextStyle(
                                                fontFamily: "LeagueSpartan",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Weight Status",
                                                style: TextStyle(
                                                    fontFamily: "LeagueSpartan",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xffa6a6a6)),
                                              ),
                                              Text(
                                                BMI < 18.5
                                                    ? "Underweight"
                                                    : BMI < 25.0
                                                        ? "Normal"
                                                        : BMI < 30.0
                                                            ? "Overweight"
                                                            : BMI < 35
                                                                ? "Obese"
                                                                : BMI < 40
                                                                    ? "Moderately Obese"
                                                                    : "Extremely Obese",
                                                style: TextStyle(
                                                  fontFamily: "LeagueSpartan",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                  color: BMI < 18.5
                                                      ? Color(0xff87ADC7)
                                                      : BMI < 25.0
                                                          ? Color(0xff70C099)
                                                          : BMI < 30.0
                                                              ? Color(
                                                                  0xffF9D230)
                                                              : BMI < 35
                                                                  ? Color(
                                                                      0xffEF9852)
                                                                  : BMI < 40
                                                                      ? Color(
                                                                          0xffDF434A)
                                                                      : Color(
                                                                          0xffBD2B37),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Calculation Date",
                                                style: TextStyle(
                                                    fontFamily: "LeagueSpartan",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xffa6a6a6)),
                                              ),
                                              Text(
                                                date,
                                                style: TextStyle(
                                                  fontFamily: "LeagueSpartan",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Healthy Weight for You",
                                                style: TextStyle(
                                                    fontFamily: "LeagueSpartan",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xffa6a6a6)),
                                              ),
                                              Text(
                                                "${healthyweight1}kg - ${healthyweight2}kg",
                                                style: TextStyle(
                                                  fontFamily: "LeagueSpartan",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                  color: Color(0xff00bf63),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 140,
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff966fd6),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                   Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(40),
                                      onTap: () async {
                                        // Define the recordData outside of setState to use it for Firebase upload.
                                        var recordData = {
                                          'BMI': BMI.toString(),
                                          'status': BMI < 18.5 ? "Underweight" : BMI < 25.0 ? "Normal" : BMI < 30.0 ? "Overweight" : BMI >= 35 ? "Obese" : "Extremely Obese",
                                          'date': date,
                                          'time': '2:30pm',
                                          'gender': gender,
                                          'age': age,
                                          'height': height,
                                          'weight': weight,
                                          'healthyweight1': healthyweight1.toStringAsFixed(1),
                                          'healthyweight2': healthyweight2.toStringAsFixed(1),
                                        };

                                        setState(() {
                                          print('Data saved locally');
                                          // Save the full data into local list
                                          BMIPage.records.insert(0, recordData);

                                          // Reset calculator values back to default
                                          calculated = false;
                                          month = 2;
                                          year = "2024";
                                          gender = "Male";
                                          age = "20";
                                          height = "170";
                                          weight = "60";
                                          date = "23/3/2024";
                                          BMI = 20.8;
                                          healthyweight1 = 55.2;
                                          healthyweight2 = 78;
                                        });

                                        // Attempt to upload full data to Firebase
                                        try {
                                          await BMIDataUpload().uploadBMI(recordData);
                                          print('Data uploaded to Firebase');
                                        } catch (e) {
                                          print('Failed to upload data to Firebase: $e');
                                        }
                                      },
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              fontFamily: "LeagueSpartan",
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: ListView(
                      controller: listScrollController,
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 1.2,
                          primary: false,
                          padding: const EdgeInsets.only(bottom: 5),
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                          children: [
                            MyCard(
                              select: true,
                              label: 'Gender',
                              switches: false,
                              initialValue: "Male",
                              age: selectage,
                              gender: selectgender,
                              height: selectheight,
                              weight: selectweight,
                            ),
                            MyCard(
                              select: false,
                              label: 'Age',
                              switches: false,
                              initialValue: "20",
                              age: selectage,
                              gender: selectgender,
                              height: selectheight,
                              weight: selectweight,
                            ),
                            MyCard(
                              select: false,
                              label: 'Weight',
                              switches: true,
                              initialValue: "60",
                              age: selectage,
                              gender: selectgender,
                              height: selectheight,
                              weight: selectweight,
                            ),
                            MyCard(
                              select: false,
                              label: 'Height',
                              switches: true,
                              initialValue: "170",
                              age: selectage,
                              gender: selectgender,
                              height: selectheight,
                              weight: selectweight,
                            ),
                          ],
                        ),
                        GridView.count(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3.5),
                          primary: false,
                          crossAxisCount: 1,
                          shrinkWrap: true,
                          children: [
                            Stack(
                              fit: StackFit.expand,
                              children: [
                                Card(
                                    color: Color(0xFFEDEDEB),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container()),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Date",
                                              style: TextStyle(
                                                  fontFamily: "LeagueSpartan",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ValueListenableBuilder(
                                                  valueListenable: monthValue,
                                                  builder:
                                                      (BuildContext context,
                                                          int value,
                                                          Widget? child) {
                                                    return Expanded(
                                                      flex: 1,
                                                      child: MyDateCard(
                                                        type: "day",
                                                        initialValue: "14",
                                                        monthselected:
                                                            selectmonth,
                                                        month: monthValue.value,
                                                        yearselected:
                                                            selectyear,
                                                        year: year,
                                                      ),
                                                    );
                                                  }),
                                              Expanded(
                                                flex: 1,
                                                child: MyDateCard(
                                                  type: "month",
                                                  initialValue: "March",
                                                  monthselected: selectmonth,
                                                  month: month,
                                                  yearselected: selectyear,
                                                  year: year,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: MyDateCard(
                                                  type: "year",
                                                  initialValue: "2024",
                                                  monthselected: selectmonth,
                                                  month: month,
                                                  yearselected: selectyear,
                                                  year: year,
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 140,
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff966fd6),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(40),
                                        onTap: () {
                                          setState(() {
                                            calculated = true;
                                            BMI = double.parse((double.parse(
                                                        weight) /
                                                    pow(
                                                        double.parse(height) /
                                                            100,
                                                        2))
                                                .toStringAsFixed(1));
                                            healthyweight1 = double.parse(
                                                (18.5 *
                                                        pow(
                                                            double.parse(
                                                                    height) /
                                                                100,
                                                            2))
                                                    .toStringAsFixed(1));
                                            healthyweight2 = double.parse(
                                                (24.9 *
                                                        pow(
                                                            double.parse(
                                                                    height) /
                                                                100,
                                                            2))
                                                    .toStringAsFixed(1));
                                          });
                                          if (listScrollController.hasClients) {
                                            final position =
                                                listScrollController
                                                    .position.minScrollExtent;
                                            listScrollController.animateTo(
                                              position,
                                              duration: Duration(seconds: 1),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Calculate",
                                            style: TextStyle(
                                                fontFamily: "LeagueSpartan",
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.5,
                ),
                primary: false,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: 20,
                ),
                itemCount: BMIPage.records.length,
                itemBuilder: (BuildContext context, int index) {
                  return Records(
                    BMI: BMIPage.records[index]['BMI'],
                    status: BMIPage.records[index]['status'],
                    date: BMIPage.records[index]['date'],
                    time: BMIPage.records[index]['time'],
                    gender: BMIPage.records[index]['gender'],
                    age: BMIPage.records[index]['age'],
                    height: BMIPage.records[index]['height'],
                    weight: BMIPage.records[index]['weight'],
                    healthyweight1: BMIPage.records[index]['healthyweight1'],
                    healthyweight2: BMIPage.records[index]['healthyweight2'],
                    index: BMIPage.records.length - index,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  const MyCard(
      {super.key,
      required this.select,
      required this.label,
      required this.switches,
      required this.initialValue,
      required this.gender,
      required this.age,
      required this.weight,
      required this.height});

  final bool select;
  final String label;
  final bool switches;
  final String initialValue;
  final Function gender;
  final Function age;
  final Function weight;
  final Function height;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  late String statefulInitialValue;
  late int switchindex;

  @override
  void initState() {
    super.initState();
    statefulInitialValue = widget.initialValue;
    switchindex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Card(
            color: Color(0xFFEDEDEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container()),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.label,
                      style: const TextStyle(
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: widget.select
                            ? () {
                                setState(() {
                                  statefulInitialValue == "Male"
                                      ? statefulInitialValue = "Female"
                                      : statefulInitialValue = "Male";
                                  widget.gender(statefulInitialValue);
                                });
                              }
                            : () {
                                setState(() {
                                  statefulInitialValue =
                                      (int.parse(statefulInitialValue) - 1)
                                          .toString();
                                  widget.label == "Age"
                                      ? widget.age(statefulInitialValue)
                                      : widget.label == "Weight"
                                          ? widget.weight(statefulInitialValue)
                                          : widget.height(statefulInitialValue);
                                });
                              },
                        child: Icon(
                          widget.select
                              ? Icons.arrow_back_ios_new
                              : Icons.remove,
                          size: 24,
                          color: Color(0xffa6a6a6),
                        ),
                      ),
                      Text(
                        statefulInitialValue,
                        style: const TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: widget.select
                            ? () {
                                setState(() {
                                  statefulInitialValue == "Male"
                                      ? statefulInitialValue = "Female"
                                      : statefulInitialValue = "Male";
                                  widget.gender(statefulInitialValue);
                                });
                              }
                            : () {
                                setState(() {
                                  statefulInitialValue =
                                      (int.parse(statefulInitialValue) + 1)
                                          .toString();
                                  widget.label == "Age"
                                      ? widget.age(statefulInitialValue)
                                      : widget.label == "Weight"
                                          ? widget.weight(statefulInitialValue)
                                          : widget.height(statefulInitialValue);
                                });
                              },
                        child: Icon(
                          widget.select ? Icons.arrow_forward_ios : Icons.add,
                          size: 24,
                          color: Color(0xffa6a6a6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: widget.switches
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleSwitch(
                              minHeight: 30.0,
                              minWidth: 45.0,
                              initialLabelIndex: switchindex,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.black,
                              inactiveBgColor: Colors.white,
                              inactiveFgColor: Color(0xffa6a6a6),
                              totalSwitches: 2,
                              labels: widget.label == "Weight"
                                  ? ['kg', 'lb']
                                  : ['cm', 'in'],
                              radiusStyle: true,
                              activeBgColors: [
                                [Color(0xffd9d9d9)],
                                [Color(0xffd9d9d9)]
                              ],
                              onToggle: (index) {
                                setState(() {
                                  switchindex = index!;
                                  widget.label == "Weight"
                                      ? index == 0
                                          ? statefulInitialValue = "60"
                                          : statefulInitialValue = "132"
                                      : index == 0
                                          ? statefulInitialValue = "170"
                                          : statefulInitialValue = "67";
                                });
                              },
                            ),
                          ],
                        )
                      : SizedBox()),
            ],
          ),
        ),
      ],
    );
  }
}

class MyDateCard extends StatefulWidget {
  const MyDateCard(
      {super.key,
      required this.initialValue,
      required this.type,
      required this.monthselected,
      required this.yearselected,
      required this.month,
      required this.year});
  final String initialValue;
  final String type;
  final Function monthselected;
  final Function yearselected;
  final int month;
  final String year;
  static final List<String> months = <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  State<MyDateCard> createState() => _MyDateCardState();
}

class _MyDateCardState extends State<MyDateCard> {
  late String statefulInitialValue;
  late int monthsindex;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    statefulInitialValue = widget.initialValue;
    monthsindex = widget.month;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.type == "year"
              ? () {
                  setState(() {
                    statefulInitialValue =
                        (int.parse(statefulInitialValue) + 1).toString();
                    widget.yearselected(statefulInitialValue);
                  });
                }
              : widget.type == "month"
                  ? () {
                      setState(() {
                        monthsindex += 1;
                        monthsindex = monthsindex % 12;
                        statefulInitialValue = MyDateCard.months[monthsindex];
                        widget.monthselected(monthsindex);
                      });
                    }
                  : () {
                      setState(() {
                        statefulInitialValue =
                            (int.parse(statefulInitialValue) + 1).toString();
                        if (widget.type == "day") {
                          final int temp;
                          temp = widget.month + 1;
                          if (temp == 1 ||
                              temp == 3 ||
                              temp == 5 ||
                              temp == 7 ||
                              temp == 8 ||
                              temp == 10 ||
                              temp == 12) {
                            if (int.parse(statefulInitialValue) > 31) {
                              statefulInitialValue = (1).toString();
                            }
                            if (int.parse(statefulInitialValue) < 1) {
                              statefulInitialValue = (31).toString();
                            }
                          } else if (temp == 2) {
                            if (int.parse(widget.year) % 4 == 0) {
                              if (int.parse(widget.year) % 400 != 0) {
                                if (int.parse(statefulInitialValue) > 29) {
                                  statefulInitialValue = (1).toString();
                                }
                                if (int.parse(statefulInitialValue) < 1) {
                                  statefulInitialValue = (29).toString();
                                }
                              } else {
                                if (int.parse(statefulInitialValue) > 28) {
                                  statefulInitialValue = (1).toString();
                                }
                                if (int.parse(statefulInitialValue) < 1) {
                                  statefulInitialValue = (28).toString();
                                }
                              }
                            } else {
                              if (int.parse(statefulInitialValue) > 28) {
                                statefulInitialValue = (1).toString();
                              }
                              if (int.parse(statefulInitialValue) < 1) {
                                statefulInitialValue = (28).toString();
                              }
                            }
                          } else {
                            if (int.parse(statefulInitialValue) > 30) {
                              statefulInitialValue = (1).toString();
                            }
                            if (int.parse(statefulInitialValue) < 1) {
                              statefulInitialValue = (30).toString();
                            }
                          }
                        }
                      });
                    },
          child: const Icon(
            Icons.keyboard_arrow_up,
            size: 40,
            color: Color(0xffa6a6a6),
          ),
        ),
        Text(
          statefulInitialValue,
          style: const TextStyle(
              fontFamily: "LeagueSpartan",
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.black),
        ),
        GestureDetector(
          onTap: widget.type == "year"
              ? () {
                  setState(() {
                    statefulInitialValue =
                        (int.parse(statefulInitialValue) - 1).toString();
                    widget.yearselected(statefulInitialValue);
                  });
                }
              : widget.type == "month"
                  ? () {
                      setState(() {
                        monthsindex -= 1;
                        monthsindex = monthsindex % 12;
                        statefulInitialValue = MyDateCard.months[monthsindex];
                        widget.monthselected(monthsindex);
                      });
                    }
                  : () {
                      setState(() {
                        statefulInitialValue =
                            (int.parse(statefulInitialValue) - 1).toString();
                        if (widget.type == "day") {
                          final int temp;
                          temp = widget.month + 1;
                          if (temp == 1 ||
                              temp == 3 ||
                              temp == 5 ||
                              temp == 7 ||
                              temp == 8 ||
                              temp == 10 ||
                              temp == 12) {
                            if (int.parse(statefulInitialValue) > 31) {
                              statefulInitialValue = (1).toString();
                            }
                            if (int.parse(statefulInitialValue) < 1) {
                              statefulInitialValue = (31).toString();
                            }
                          } else if (temp == 2) {
                            if (int.parse(widget.year) % 4 == 0) {
                              if (int.parse(widget.year) % 400 != 0) {
                                if (int.parse(statefulInitialValue) > 29) {
                                  statefulInitialValue = (1).toString();
                                }
                                if (int.parse(statefulInitialValue) < 1) {
                                  statefulInitialValue = (29).toString();
                                }
                              }
                            } else {
                              if (int.parse(statefulInitialValue) > 28) {
                                statefulInitialValue = (1).toString();
                              }
                              if (int.parse(statefulInitialValue) < 1) {
                                statefulInitialValue = (28).toString();
                              }
                            }
                          } else {
                            if (int.parse(statefulInitialValue) > 30) {
                              statefulInitialValue = (1).toString();
                            }
                            if (int.parse(statefulInitialValue) < 1) {
                              statefulInitialValue = (30).toString();
                            }
                          }
                        }
                      });
                    },
          child: const Icon(
            Icons.keyboard_arrow_down,
            size: 40,
            color: Color(0xffa6a6a6),
          ),
        ),
      ],
    );
  }
}

class Records extends StatelessWidget {
  const Records(
      {super.key,
      required this.BMI,
      required this.status,
      required this.date,
      required this.time,
      required this.gender,
      required this.age,
      required this.height,
      required this.weight,
      required this.healthyweight1,
      required this.healthyweight2,
      required this.index});
  final String BMI;
  final String status;
  final String date;
  final String time;
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String healthyweight1;
  final String healthyweight2;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            color: Color(0xFFEDEDEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container()),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            BMI: double.parse(BMI),
                            gender: gender,
                            age: age,
                            date: date,
                            healthyweight1: healthyweight1,
                            healthyweight2: healthyweight2,
                            weight: weight,
                            height: height,
                            index: index,
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        BMI,
                        style: TextStyle(
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w300,
                          fontSize: 30,
                          color: double.parse(BMI) < 18.5
                              ? Color(0xff87ADC7)
                              : double.parse(BMI) < 25.0
                                  ? Color(0xff70C099)
                                  : double.parse(BMI) < 30.0
                                      ? Color(0xffF9D230)
                                      : double.parse(BMI) < 35
                                          ? Color(0xffEF9852)
                                          : double.parse(BMI) < 40
                                              ? Color(0xffDF434A)
                                              : Color(0xffBD2B37),
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontFamily: "LeagueSpartan",
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: double.parse(BMI) < 18.5
                              ? Color(0xff87ADC7)
                              : double.parse(BMI) < 25.0
                                  ? Color(0xff70C099)
                                  : double.parse(BMI) < 30.0
                                      ? Color(0xffF9D230)
                                      : double.parse(BMI) < 35
                                          ? Color(0xffEF9852)
                                          : double.parse(BMI) < 40
                                              ? Color(0xffDF434A)
                                              : Color(0xffBD2B37),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 40,
                    color: Color(0xffa6a6a6),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ResultsPage extends StatelessWidget {
  const ResultsPage(
      {super.key,
      required this.BMI,
      required this.gender,
      required this.age,
      required this.date,
      required this.healthyweight1,
      required this.healthyweight2,
      required this.weight,
      required this.height,
      required this.index});
  final double BMI;
  final String gender;
  final String age;
  final String date;
  final String healthyweight1;
  final String healthyweight2;
  final String weight;
  final String height;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Record $index",
                  style: TextStyle(
                    fontFamily: "LeagueSpartan",
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                  child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.8,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      showAxisLine: false,
                      showTicks: false,
                      showLabels: false,
                      backgroundImage: AssetImage("lib/assets/images/bmi.png"),
                      startAngle: 180,
                      endAngle: 360,
                      minimum: 15.0,
                      maximum: 45.0,
                      pointers: <GaugePointer>[
                        NeedlePointer(
                            value: BMI < 25 && BMI > 18.4
                                ? 24.9 - ((24.9 - BMI) / (6.4 / 4.9))
                                : BMI < 18.5 && BMI > 15
                                    ? 15 + ((BMI - 15) / (3.4 / 4.9))
                                    : BMI)
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text("$BMI",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: BMI < 18.5
                                            ? Color(0xff87ADC7)
                                            : BMI < 25.0
                                                ? Color(0xff70C099)
                                                : BMI < 30.0
                                                    ? Color(0xffF9D230)
                                                    : BMI < 35
                                                        ? Color(0xffEF9852)
                                                        : BMI < 40
                                                            ? Color(0xffDF434A)
                                                            : Color(0xffBD2B37),
                                        fontWeight: FontWeight.w400))),
                            angle: 90,
                            positionFactor: 0.4)
                      ])
                ]),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: -5,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    Card(
                        color: Color(0xFFffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container()),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$gender | ${age}y/o | ${height}cm | ${weight}kg",
                                style: const TextStyle(
                                    fontFamily: "LeagueSpartan",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Weight Status",
                                    style: TextStyle(
                                        fontFamily: "LeagueSpartan",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xffa6a6a6)),
                                  ),
                                  Text(
                                    BMI < 18.5
                                        ? "Underweight"
                                        : BMI < 25.0
                                            ? "Normal"
                                            : BMI < 30.0
                                                ? "Overweight"
                                                : BMI < 35
                                                    ? "Obese"
                                                    : BMI < 40
                                                        ? "Moderately Obese"
                                                        : "Extremely Obese",
                                    style: TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: BMI < 18.5
                                          ? const Color(0xff87ADC7)
                                          : BMI < 25.0
                                              ? const Color(0xff70C099)
                                              : BMI < 30.0
                                                  ? const Color(0xffF9D230)
                                                  : BMI < 35
                                                      ? const Color(0xffEF9852)
                                                      : BMI < 40
                                                          ? const Color(
                                                              0xffDF434A)
                                                          : const Color(
                                                              0xffBD2B37),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Calculation Date",
                                    style: TextStyle(
                                        fontFamily: "LeagueSpartan",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xffa6a6a6)),
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Healthy Weight for You",
                                    style: TextStyle(
                                        fontFamily: "LeagueSpartan",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xffa6a6a6)),
                                  ),
                                  Text(
                                    "${healthyweight1}kg - ${healthyweight2}kg",
                                    style: const TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Color(0xff00bf63),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff966fd6),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    fontFamily: "LeagueSpartan",
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
