// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/tca_appointment_page.dart';
import 'material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class TCABSSKPage extends StatefulWidget {
  bool submitted;
  TCABSSKPage({super.key, this.submitted = false});
  static final List<String> title = [
    "A. Biodata",
    "B. Medical/Surgical History",
    "C. Oral Health",
    "D. Dietary",
    "E. Physical Activity Assessment",
    "F. Sexual/Reproductive Health",
    "G. Comsumption of Substances",
    "H. Dangerous/High Risk Activities",
    "I. Spirituality",
    "J. Mental Health Assessment",
    "K. Abuse History",
  ];

  @override
  State<TCABSSKPage> createState() => _TCABSSKPageState();
}

class _TCABSSKPageState extends State<TCABSSKPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String recommendedStaff = '';

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getRecommendedStaffInfo(
      String doc) async {
    QueryDocumentSnapshot<Map<String, dynamic>> returnValue;
    return await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      for (var docSnapshot in value.docs) {
        var data = docSnapshot.data();
        if (data['isStaff']) {
          if (data['occupation'] == doc) {
            return docSnapshot;
          }
        }
      }

      throw "breh";
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getStaffInfo(
      String staffCateogry) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> staffList = [];
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var docSnapshot in value.docs) {
        var data = docSnapshot.data();
        if (data['isStaff']) {
          if (data['occupation'] == staffCateogry) {
            staffList.add(docSnapshot);
          }
        }
      }
    });
    return staffList;
  }

  Future<String> getRecommendedStaffListName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      var staffData = value.data()!;
      if (staffData['doctors'] != null) {
        for (var doctor in staffData['doctors']) {
          recommendedStaff += doctor + ", ";
        }
      }
    });
    return recommendedStaff;
  }

  int section = 0;
  ScrollController listScrollController = ScrollController();

  Map<String, dynamic> values = {
    'a1': "-",
    'a2': "-",
    'a3': "-",
    'a4': "-",
    'a5': "-", //a5 == "Others" => check a5ii
    'a5ii': "-",
    'a6': "-",
    'a7': "-",
    'a8': "-", //a8 == "working" => check a8i elif (a8 == "school") check a8ii
    'a8i': "-",
    'a8ii': "-",
    'a9':
        "-", //a9 =="married" => check a9i elif (a9 == "widow/widower") check a9ii
    'a9i': "-",
    'a9ii': "-",
    'a10': "-",
    'a11a': "-",
    'a11b': "-",
    'a12': "-",
    'a13': "-",
    'b1a': [],
    'b1b': [],
    'b1c': [],
    'b1d': [],
    'b1e': [],
    'b1f': [],
    'b2': "-",
    'b3a': "-",

    'b3b': "-",
    'b3bi': "-", // if b3b yes
    'b4': "-",
    'b4i': "-", //if b4 yes
    'c1': "-",
    'd1a': "-",
    'd1b': "-",
    'd1c': "-",
    'd2a': "-",
    'd2b': "-",
    'd2c': "-",
    'd2d': "-",
    'd2e': "-",
    'd3': "-",
    'e1': "-",
    'e2': "-",
    'f1a': "-",
    'f1b': "-",
    'f1c': "-",
    'f1d': "-",
    'f1di': "-", // if f1d yes
    'f2a': "-",
    'f2b': "-",
    'f3': "-",
    'f4': "-",
    'f5': "-",
    'f6': "-",
    'f7a': "-",
    'f7b': "-",
    'f7c': "-",
    'f8': "-",
    'f9': "-",
    'f10': "-",
    'f11': "-",
    'f12': "-",
    'g1a': "-",
    'g1b': "-",
    'g1c': "-",
    'g1d': "-",
    'g1di': "-", //if g1d yes
    'h1a': "-",
    'h1b': "-",
    'h1c': "-",
    'h1d': "-",
    'h2a': "-",
    'h2b': "-",
    'h2c': "-",
    'h2d': "-",
    'h2e': "-",
    'h2f': "-",
    'i1': "-",
    'j1': [],
    'j2': "-",
    'j3a': "-",
    'j3b': "-",
    'j3c': "-",
    'j3d': "-",
    'j3e': "-",
    'j3f': "-",
    'j3g': "-",
    'k1': "-",
  };

  changeValues(name, value) {
    values[name] = value;
  }

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Set<Map<String, dynamic>>> questions = [
      {
        {
          "text": "Full Name",
          "child": MyTextField(name: 'a1', callback: changeValues)
        },
        {
          "text": "Gender",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a2", value);
              },
              validator: (value) {
                if (value != 'Male' && value != 'Female') {
                  return 'Required';
                }
                return null;
              },
              name: "a2",
              wrapAlignment: WrapAlignment.start,
              wrapSpacing: 50,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: const <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Male',
                ),
                FormBuilderFieldOption(
                  value: 'Female',
                )
              ]),
        },
        {
          "text": "Date of Birth",
          "child": MyTextField(
            inputtype: TextInputType.phone,
            name: 'a3',
            callback: changeValues,
            hinttext: 'DD/MM/YYYY',
          )
        },
        {
          "text": "IC / Passport Number",
          "child": MyTextField(
            inputtype: TextInputType.number,
            name: 'a4',
            callback: changeValues,
          )
        },
        {
          "text": "Citizenship",
          "child": Column(
            children: [
              FormBuilderRadioGroup(
                  onChanged: (value) {
                    changeValues("a5", value);
                  },
                  validator: (value) {
                    if (values['a5'] == "-") {
                      return 'Required';
                    }
                    return null;
                  },
                  name: "a5",
                  wrapAlignment: WrapAlignment.start,
                  wrapSpacing: 100,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  options: <FormBuilderFieldOption>[
                    FormBuilderFieldOption(
                      value: 'Malaysia',
                    ),
                    FormBuilderFieldOption(
                      value: 'Other',
                      child: SizedBox(
                        width: 200,
                        child: FormBuilderTextField(
                          onChanged: (value) {
                            changeValues("a5ii", value);
                          },
                          validator: (value) {
                            if (values['a5'] == 'Other' &&
                                (values['a5ii'] == "-" ||
                                    values['a5ii'] == '')) {
                              return 'Required';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 14),
                          name: '',
                          decoration: InputDecoration(
                            hintText: "Others (Please state)",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                          ),
                        ),
                      ),
                    )
                  ]),
            ],
          )
        },
        {
          "text": "Race",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a6", value);
              },
              validator: (value) {
                if (value == null) {
                  return 'Required';
                }
                return null;
              },
              name: "a6",
              wrapAlignment: WrapAlignment.start,
              wrapSpacing: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: const <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Malay',
                ),
                FormBuilderFieldOption(
                  value: 'Native Sabah',
                ),
                FormBuilderFieldOption(
                  value: 'Chinese',
                ),
                FormBuilderFieldOption(
                  value: 'Native Sarawak',
                ),
                FormBuilderFieldOption(
                  value: 'Indian',
                ),
                FormBuilderFieldOption(
                  value: 'Orang Asli',
                ),
                FormBuilderFieldOption(
                  value: 'Others',
                ),
              ]),
        },
        {
          "text": "Level of Education",
          "child": FormBuilderRadioGroup(
              validator: (value) {
                if (value == null) {
                  return 'Required';
                }
                return null;
              },
              onChanged: (value) {
                changeValues("a7", value);
              },
              name: "a7",
              wrapAlignment: WrapAlignment.start,
              wrapSpacing: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: const <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Primary',
                ),
                FormBuilderFieldOption(
                  value: 'Secondary',
                ),
                FormBuilderFieldOption(
                  value: 'Tertiary',
                ),
                FormBuilderFieldOption(
                  value: 'No proper education',
                ),
              ]),
        },
        {
          "text": "Employment",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a8", value);
              },
              validator: (value) {
                if (values['a8'] == "-") {
                  return 'Required';
                }
                return null;
              },
              name: "a8",
              wrapAlignment: WrapAlignment.start,
              wrapRunAlignment: WrapAlignment.start,
              wrapSpacing: 300,
              wrapRunSpacing: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                    value: 'working',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Working, at: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            validator: (value) {
                              if (values['a8'] == 'working' &&
                                  (values['a8i'] == "-" ||
                                      values['a8i'] == '')) {
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              changeValues("a8i", value);
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "Your workplace",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
                FormBuilderFieldOption(
                    value: 'studying',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Still studying, at: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            onChanged: (value) {
                              changeValues("a8ii", value);
                            },
                            validator: (value) {
                              if (values['a8'] == 'studying' &&
                                  (values['a8ii'] == "-" ||
                                      values['a8ii'] == '')) {
                                return 'Required';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "Your school",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
                FormBuilderFieldOption(
                  value: 'Not working',
                ),
              ]),
        },
        {
          "text": "Marriage Status",
          "child": FormBuilderRadioGroup(
              onChanged: (value) {
                changeValues("a9", value);
              },
              name: "a9",
              wrapAlignment: WrapAlignment.start,
              wrapRunAlignment: WrapAlignment.start,
              wrapSpacing: 300,
              wrapRunSpacing: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'Single',
                ),
                FormBuilderFieldOption(
                    value: 'married',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Married, no. of children: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            validator: (value) {
                              if (values['a9'] == 'married' &&
                                  (values['a9i'] == "-" ||
                                      values['a9i'] == '')) {
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              changeValues("a9i", value);
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "No. of children",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
                FormBuilderFieldOption(
                    value: 'widow',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Widow/widower, no. of children: "),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            validator: (value) {
                              if (values['a9'] == 'widow' &&
                                  (values['a9ii'] == "-" ||
                                      values['a9ii'] == '')) {
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              changeValues("a9ii", value);
                            },
                            style: TextStyle(fontSize: 14),
                            name: '',
                            decoration: InputDecoration(
                              hintText: "No. of children",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
        },
        {
          "text": "Home address",
          "child": MyTextField(
            name: 'a10',
            callback: changeValues,
          )
        },
        {
          "text": "Phone number",
          "child": Row(
            children: [
              Expanded(
                  flex: 8,
                  child: MyTextField(
                    inputtype: TextInputType.phone,
                    name: 'a11a',
                    callback: changeValues,
                    hinttext: 'Home',
                  )),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                  flex: 8,
                  child: MyTextField(
                    inputtype: TextInputType.phone,
                    name: 'a11b',
                    callback: changeValues,
                    hinttext: 'Mobile',
                  )),
            ],
          )
        },
        {
          "text": "Email",
          "child": MyTextField(
            inputtype: TextInputType.emailAddress,
            name: 'a12',
            callback: changeValues,
            hinttext: 'e.g. johndoe@gmail.com',
          )
        },
        {
          "text": "Last Normal Menstrual Period (Female only)",
          "child": FormBuilderTextField(
            keyboardType: TextInputType.phone,
            name: 'a13',
            validator: (value) {
              if (value == null && values['a2'] == "Female") {
                return 'Required';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                changeValues('a13', value);
              });
            },
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'DD/MM/YYYY',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10),
            ),
          )
        },
      }.toSet(),
      {
        {
          "text":
              "Do you or a family member suffer from the following diseases:",
          "child": Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    flex: 12,
                    child: SizedBox(),
                  ),
                  Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "You",
                            style: TextStyle(fontSize: 10),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              "Family",
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("a."),
                    ),
                    Expanded(flex: 10, child: Text("Hypertension")),
                    Expanded(
                      flex: 8,
                      child: FormBuilderCheckboxGroup(
                          onChanged: (value) {
                            changeValues('b1a', value);
                          },
                          name: "s",
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          options: const <FormBuilderFieldOption>[
                            FormBuilderFieldOption(
                              value: 'b1ai',
                              child: SizedBox(),
                            ),
                            FormBuilderFieldOption(
                              value: 'b1aii',
                              child: SizedBox(),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFededeb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Text("b."),
                      ),
                      Expanded(flex: 10, child: Text("Diabetes")),
                      Expanded(
                        flex: 8,
                        child: FormBuilderCheckboxGroup(
                            onChanged: (value) {
                              changeValues('b1b', value);
                            },
                            name: "s",
                            wrapAlignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: const <FormBuilderFieldOption>[
                              FormBuilderFieldOption(
                                value: 'b1bi',
                                child: SizedBox(),
                              ),
                              FormBuilderFieldOption(
                                value: 'b1bii',
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("c."),
                    ),
                    Expanded(flex: 10, child: Text("Heart Disease")),
                    Expanded(
                      flex: 8,
                      child: FormBuilderCheckboxGroup(
                          onChanged: (value) {
                            changeValues('b1c', value);
                          },
                          name: "s",
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          options: const <FormBuilderFieldOption>[
                            FormBuilderFieldOption(
                              value: 'b1ci',
                              child: SizedBox(),
                            ),
                            FormBuilderFieldOption(
                              value: 'b1cii',
                              child: SizedBox(),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFededeb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Text("d."),
                      ),
                      Expanded(flex: 10, child: Text("Asthma")),
                      Expanded(
                        flex: 8,
                        child: FormBuilderCheckboxGroup(
                            onChanged: (value) {
                              changeValues('b1d', value);
                            },
                            name: "s",
                            wrapAlignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: const <FormBuilderFieldOption>[
                              FormBuilderFieldOption(
                                value: 'b1di',
                                child: SizedBox(),
                              ),
                              FormBuilderFieldOption(
                                value: 'b1dii',
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("e."),
                    ),
                    Expanded(
                        flex: 10,
                        child: Text("Hereditary Disease (e.g. Thalassemia)")),
                    Expanded(
                      flex: 8,
                      child: FormBuilderCheckboxGroup(
                          onChanged: (value) {
                            changeValues('b1e', value);
                          },
                          name: "s",
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          options: const <FormBuilderFieldOption>[
                            FormBuilderFieldOption(
                              value: 'b1ei',
                              child: SizedBox(),
                            ),
                            FormBuilderFieldOption(
                              value: 'b1eii',
                              child: SizedBox(),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFededeb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Text("f."),
                      ),
                      Expanded(
                          flex: 10,
                          child:
                              Text("Contagious Disease (e.g. TB, Hepatitis)")),
                      Expanded(
                        flex: 8,
                        child: FormBuilderCheckboxGroup(
                            onChanged: (value) {
                              changeValues('b1f', value);
                            },
                            name: "s",
                            wrapAlignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            options: const <FormBuilderFieldOption>[
                              FormBuilderFieldOption(
                                value: 'b1fi',
                                child: SizedBox(),
                              ),
                              FormBuilderFieldOption(
                                value: 'b1fii',
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        },
        {
          "text":
              "Do you have a family member who died suddenly? (Male before 45 years, Female before 50 years)",
          "child": singleyesorno(name: "b2", callback: changeValues)
        },
        {
          "text": "Have you ever...",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "...experienced a severe drug allergy?",
                name: "b3a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "...gone through any form of surgery?",
                name: "b3b",
                callback: changeValues),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: FormBuilderTextField(
                      onChanged: (value) {
                        changeValues("b3bi", value);
                      },
                      validator: (value) {
                        if (values['b3b'] == 'y' &&
                            (values['b3bi'] == "-" || values['b3bi'] == "")) {
                          return 'Required';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      name: '',
                      decoration: InputDecoration(
                          hintText: "If yes, please state...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ])
        },
        {
          "text": "Are you suffering from any other diseases?",
          "child": Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              singleyesorno(name: "b4", callback: changeValues),
              SizedBox(
                width: 200,
                child: FormBuilderTextField(
                  onChanged: (value) {
                    changeValues("b4i", value);
                  },
                  validator: (value) {
                    if (values['b4'] == 'y' &&
                        (values['b4i'] == "-" || values['b4i'] == "")) {
                      return 'Required';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 14),
                  name: '',
                  decoration: InputDecoration(
                      hintText: "If yes, please state...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
            ],
          )
        },
      }.toSet(),
      {
        {
          "text": "I have oral health problems (e.g. teeth, gum) ?",
          "child": singleyesorno(name: "c1", callback: changeValues)
        },
      }.toSet(),
      {
        {
          "text":
              "I eat according to the set eating time period below every day:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Breakfast",
                name: "d1a",
                callback: changeValues),
            ListQuestion(
                index: 2, text: "Lunch", name: "d1b", callback: changeValues),
            ListQuestion(
                index: 3, text: "Dinner", name: "d1c", callback: changeValues),
          ])
        },
        {
          "text": "Do you consume all kinds of food including:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Grain food (e.g. rice, noodles or bread)",
                name: "d2a",
                callback: changeValues),
            ListQuestion(
                index: 2, text: "Fruits", name: "d2b", callback: changeValues),
            ListQuestion(
                index: 3,
                text: "Vegetable",
                name: "d2c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Milk and dairy products (e.g. cheese, yoghurt)",
                name: "d2d",
                callback: changeValues),
            ListQuestion(
                index: 5,
                text: "Beef / chicken / eggs / fish / seafood or nuts",
                name: "d2e",
                callback: changeValues),
          ])
        },
        {
          "text": "I think that I am skinny, normal or fat?",
          "child": Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: 250,
                  child: FormBuilderRadioGroup(
                      onChanged: (value) {
                        changeValues("d3", value);
                      },
                      validator: (value) {
                        if (values['d3'] == "-") {
                          return 'Required';
                        }
                        return null;
                      },
                      name: "s",
                      wrapAlignment: WrapAlignment.start,
                      wrapSpacing: 50,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      options: const <FormBuilderFieldOption>[
                        FormBuilderFieldOption(
                          value: 'Skinny',
                        ),
                        FormBuilderFieldOption(
                          value: 'Normal',
                        ),
                        FormBuilderFieldOption(
                          value: 'Fat',
                        ),
                      ]),
                ),
              )
            ],
          )
        },
      }.toSet(),
      {
        {
          "text": "I practise physical activities and exercises?",
          "child": singleyesorno(name: "e1", callback: changeValues)
        },
        {
          "text":
              "I exercise at least 150 minutes every week (e.g. speedwalking 30 minutes for at least 5 times a week)",
          "child": singleyesorno(name: "e2", callback: changeValues)
        },
      }.toSet(),
      {
        {
          "text": "I had experienced problems as below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Pus or odour smell from private parts",
                name: "f1a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Itchiness or scadies on private parts",
                name: "f1b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text:
                    "Painfulness on pubic hair or private parts when urinating",
                name: "f1c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Other problems on private parts",
                name: "f1d",
                callback: changeValues),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: FormBuilderTextField(
                      onChanged: (value) {
                        changeValues("f1di", value);
                      },
                      validator: (value) {
                        if (values['f1d'] == 'y' &&
                            (values['f1di'] == "-" || values['f1di'] == "")) {
                          return 'Required';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      name: '',
                      decoration: InputDecoration(
                          hintText: "If yes, please state...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ])
        },
        {
          "text": "I have done the following:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Consumed pornographic material",
                name: "f2a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Masturbate (Sexually stimulated myself)",
                name: "f2b",
                callback: changeValues),
          ])
        },
        {
          "text": "I have the desire to change sex?",
          "child": singleyesorno(name: "f3", callback: changeValues)
        },
        {
          "text": "I have the desire to have sex with the same gender?",
          "child": singleyesorno(name: "f4", callback: changeValues)
        },
        {
          "text": "I have a lover or partner?",
          "child": singleyesorno(name: "f5", callback: changeValues)
        },
        {
          "text": "I had sex? (If no, skip to next section)",
          "child": singleyesorno(name: "f6", callback: changeValues)
        },
        {
          "text": "I:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "antly change partners",
                name: "f7a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Have sex with the same gender",
                name: "f7b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text: 'Have "unnatural" sex',
                name: "f7c",
                callback: changeValues),
          ])
        },
        {
          "text": "I/My partner uses condom when having sex.",
          "child": singleyesorno(
            name: "f8",
            callback: changeValues,
          )
        },
        {
          "text": "I/My partner uses pregnancy prevention methods.",
          "child": singleyesorno(
            name: "f9",
            callback: changeValues,
          )
        },
        {
          "text": "I feel that my belly is getting bigger. (Female only)",
          "child": singleyesorno(
            name: "f10",
            callback: changeValues,
          )
        },
        {
          "text": "I have experienced miscarriage. (Female only)",
          "child": singleyesorno(
            name: "f11",
            callback: changeValues,
          )
        },
        {
          "text": "Menarche (Period for the first time) (Female only)",
          "child": SizedBox(
            height: 40,
            child: FormBuilderTextField(
              name: 'menarche',
              onChanged: (value) {
                changeValues("f12", value);
              },
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Date / Year",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          )
        },
      }.toSet(),
      {
        {
          "text": "Do you consume any of the substances below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Cigarettes / Tobacco / Vape",
                name: "g1a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Prohibited drugs",
                name: "g1b",
                callback: changeValues),
            ListQuestion(
                index: 3, text: "Alcohol", name: "g1c", callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Other substances or medicine",
                name: "g1d",
                callback: changeValues),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: FormBuilderTextField(
                      onChanged: (value) {
                        changeValues("g1di", value);
                      },
                      validator: (value) {
                        if (values['g1d'] == 'y' &&
                            (values['g1di'] == "-" || values['g1di'] == "")) {
                          return 'Required';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      name: '',
                      decoration: InputDecoration(
                          hintText: "If yes, please state...",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ])
        },
      }.toSet(),
      {
        {
          "text":
              "Parents/teachers are worried about my behaviour because they assume that I:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: " am irritable",
                name: "h1a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "am a coward",
                name: "h1b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text: "am prone to worrying",
                name: "h1c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "don't make friends and like to be alone",
                name: "h1d",
                callback: changeValues),
          ])
        },
        {
          "text": "At often times, I am involved in the activities below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text: "Bullying",
                name: "h2a",
                callback: changeValues),
            ListQuestion(
                index: 2, text: "Fights", name: "h2b", callback: changeValues),
            ListQuestion(
                index: 3,
                text: "Skip school",
                name: "h2c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Destroy or mutilate public property",
                name: "h2d",
                callback: changeValues),
            ListQuestion(
                index: 5,
                text: "Drive/ride dangerously",
                name: "h2e",
                callback: changeValues),
            ListQuestion(
                index: 6,
                text: "Ride on a motorcycle without wearing a safety helmet",
                name: "h2f",
                callback: changeValues),
          ])
        },
      }.toSet(),
      {
        {
          "text": "Religion is important in my life.",
          "child": singleyesorno(name: "i1", callback: changeValues),
        },
      }.toSet(),
      {
        {
          "text": "If I have any personal problems I always report to",
          "child": Row(
            children: [
              Expanded(
                child: FormBuilderCheckboxGroup(
                    onChanged: (value) {
                      // List list = [
                      //   "j1a",
                      //   "j1b",
                      //   "j1c",
                      //   "j1d",
                      //   "j1e",
                      //   "j1f",
                      //   "j1g",
                      //   "j1h"
                      // ];
                      // for (String item in list) {
                      //   if (value!.contains(item)) {
                      //     changeValues(item, "y");
                      //   } else {
                      //     changeValues(item, "n");
                      //   }
                      // }
                      changeValues('j1', value);
                    },
                    name: "j1",
                    decoration: InputDecoration(border: InputBorder.none),
                    options: const [
                      FormBuilderFieldOption(
                        value: "j1a",
                        child: Text("Mother"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1b",
                        child: Text("Father"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1c",
                        child: Text("Siblings"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1d",
                        child: Text("Friends"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1e",
                        child: Text("Teacher"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1f",
                        child: Text("Counsellor"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1g",
                        child: Text("Partner"),
                      ),
                      FormBuilderFieldOption(
                        value: "j1h",
                        child: Text("Others"),
                      ),
                    ]),
              )
            ],
          ),
        },
        {
          "text": "I am a good person myself.",
          "child": singleyesorno(name: "j2", callback: changeValues),
        },
        {
          "text": "I have the problems below:",
          "child": Column(children: [
            yesno(),
            ListQuestion(
                index: 1,
                text:
                    "Prone to worrying/depression for extended periods for more than 2 weeks",
                name: "j3a",
                callback: changeValues),
            ListQuestion(
                index: 2,
                text: "Insomnia",
                name: "j3b",
                callback: changeValues),
            ListQuestion(
                index: 3,
                text: "Having no appetite",
                name: "j3c",
                callback: changeValues),
            ListQuestion(
                index: 4,
                text: "Thinks that life is meaningless",
                name: "j3d",
                callback: changeValues),
            ListQuestion(
                index: 5,
                text: "Hard to calm down",
                name: "j3e",
                callback: changeValues),
            ListQuestion(
                index: 6,
                text: "Always anxious and worried",
                name: "j3f",
                callback: changeValues),
            ListQuestion(
                index: 7,
                text: "Had the thought to end life",
                name: "j3g",
                callback: changeValues),
          ])
        },
      }.toSet(),
      {
        {
          "text":
              "Have you ever get bullied or abused, whether emotionally, physically or sexually?",
          "child": singleyesorno(name: "k1", callback: changeValues),
        },
      }.toSet(),
    ];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd \n h:mm:ss a').format(now);
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              var snapshotReference = snapshot.data!.reference;
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
                        tabs: const [
                          Tab(text: "HAF"),
                          Tab(text: "TCA"),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                        ),
                        child: section < TCABSSKPage.title.length
                            // &&!widget.submitted
                            ? Form(
                                key: _formKey,
                                child: ListView(
                                  controller: listScrollController,
                                  children: [
                                    if (section == 0)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "LeagueSpartan",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                  children: const <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "This Health Assessment Form\nconsists of 11 sections "),
                                                    TextSpan(
                                                        text: "(A - K).",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ]),
                                            ),
                                            const SizedBox(height: 10),
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "Please fill in your information\nin each section accordingly.",
                                                style: TextStyle(
                                                    fontFamily: "LeagueSpartan",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (section == 0)
                                      SizedBox(
                                        height: 30,
                                      ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15, left: 4, right: 4),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffd9d9d9),
                                                            width: 3)),
                                                    padding: EdgeInsets.all(8),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                        top: 30,
                                                        left: 5,
                                                      ),
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount:
                                                              questions[section]
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 24,
                                                                      child: Text(
                                                                          "${index + 1})"),
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(questions[
                                                                              section]
                                                                          .elementAt(
                                                                              index)['text']),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15),
                                                                  child: questions[
                                                                          section]
                                                                      .elementAt(
                                                                          index)['child'],
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                    )),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFededeb),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                    TCABSSKPage.title[section]),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                width: 120,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        onTap: () {
                                                          if (listScrollController
                                                              .hasClients) {
                                                            final position =
                                                                listScrollController
                                                                    .position
                                                                    .minScrollExtent;
                                                            listScrollController
                                                                .animateTo(
                                                              position,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                              curve: Curves
                                                                  .easeInOut,
                                                            );
                                                          }
                                                          if (!_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            return;
                                                          }

                                                          _formKey.currentState!
                                                              .save();
                                                          setState(() {
                                                            section += 1;

                                                            if (section == 11) {
                                                              widget.submitted =
                                                                  true;
                                                              final bsskRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(user
                                                                          .uid);
                                                              bsskRef.update({
                                                                'BSSK': values,
                                                              });
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'reviews')
                                                                  .doc(user.uid)
                                                                  .set({
                                                                'fullName': data[
                                                                    'fullName'],
                                                                'email': data[
                                                                    'email'],
                                                                'icNumber': data[
                                                                    'icNumber'],
                                                                'phoneNumber': data[
                                                                    'phoneNumber'],
                                                                'BSSK': values,
                                                                'reviewed':
                                                                    false,
                                                                'id': user.uid
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  section == 10
                                                                      ? "Submit"
                                                                      : "Next",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "LeagueSpartan",
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  size: 10.0,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          150,
                                                                          111,
                                                                          214),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.1,
                                    right: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2.0,
                                              color: Color(0xffd9d9d9)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "lib/assets/images/thumbsup.png",
                                            width: 200,
                                            height: 200,
                                          ),
                                          Text(
                                            "Your response on",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "LeagueSpartan",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              formattedDate,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "Poppins",
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            "has been recorded.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "LeagueSpartan",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Thanks for filling up the form!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "LeagueSpartan",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 150,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            fit: StackFit.expand,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  color: Color(0xff966fd6),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  onTap: () {
                                                    if (listScrollController
                                                        .hasClients) {
                                                      final position =
                                                          listScrollController
                                                              .position
                                                              .minScrollExtent;
                                                      listScrollController
                                                          .animateTo(
                                                        position,
                                                        duration: Duration(
                                                            seconds: 1),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }

                                                    setState(() {
                                                      section = 0;
                                                      widget.submitted = false;
                                                    });
                                                  },
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Text(
                                                            "Start again",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "LeagueSpartan",
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Recommended for You!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data['doctors'] == null
                                                ? 0
                                                : data['doctors'].length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  FutureBuilder(
                                                      future:
                                                          getRecommendedStaffInfo(
                                                              data['doctors']
                                                                  [index]),
                                                      builder:
                                                          ((context, snapshot) {
                                                        if (!snapshot.hasData &&
                                                            snapshot.connectionState !=
                                                                ConnectionState
                                                                    .done) {
                                                          return CircularProgressIndicator();
                                                        } else {
                                                          Map<String, dynamic>
                                                              staffData =
                                                              snapshot.data!
                                                                  .data();
                                                          return StaffInfo(
                                                            staffData: snapshot
                                                                .data!
                                                                .reference,
                                                            staffName:
                                                                staffData[
                                                                    "name"],
                                                            staffID: "0",
                                                            userData:
                                                                snapshotReference,
                                                          );
                                                        }
                                                      }))
                                                ],
                                              );
                                            }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FutureBuilder(
                                            future:
                                                getRecommendedStaffListName(),
                                            builder: (context, string) {
                                              if (!string.hasData &&
                                                  string.connectionState !=
                                                      ConnectionState.done) {
                                                return CircularProgressIndicator();
                                              } else {
                                                var data = string.data!;
                                                return RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              'Based on your previous '),
                                                      TextSpan(
                                                        text: 'BSSK results',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                          text:
                                                              ', it looks like our '),
                                                      TextSpan(
                                                        text: data,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextSpan(
                                                          text:
                                                              'will be the best option for you.'),
                                                    ],
                                                  ),
                                                );
                                              }
                                            }),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Counsellors',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        FutureBuilder(
                                            future: getStaffInfo("Counsellor"),
                                            builder: (context, list) {
                                              if (!list.hasData &&
                                                  list.connectionState !=
                                                      ConnectionState.done) {
                                                return CircularProgressIndicator();
                                              } else {
                                                final staffList = list.data!;
                                                return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: staffList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var staffData =
                                                          staffList[index]
                                                              .data();
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          StaffInfo(
                                                            staffData:
                                                                staffList[index]
                                                                    .reference,
                                                            staffName:
                                                                staffData[
                                                                    "name"],
                                                            staffID: "0",
                                                            userData:
                                                                snapshotReference,
                                                          )
                                                        ],
                                                      );
                                                    });
                                              }
                                            }),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          'Medical Officers',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        FutureBuilder(
                                            future:
                                                getStaffInfo("Medical Officer"),
                                            builder: (context, list) {
                                              if (!list.hasData &&
                                                  list.connectionState !=
                                                      ConnectionState.done) {
                                                return CircularProgressIndicator();
                                              } else {
                                                final staffList = list.data!;
                                                return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: staffList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var staffData =
                                                          staffList[index]
                                                              .data();
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          StaffInfo(
                                                            staffData:
                                                                staffList[index]
                                                                    .reference,
                                                            staffName:
                                                                staffData[
                                                                    "name"],
                                                            staffID: "0",
                                                            userData:
                                                                snapshotReference,
                                                          )
                                                        ],
                                                      );
                                                    });
                                              }
                                            }),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          'Occupational Therapists',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        FutureBuilder(
                                            future: getStaffInfo(
                                                "Occupational Therapist"),
                                            builder: (context, list) {
                                              if (!list.hasData &&
                                                  list.connectionState !=
                                                      ConnectionState.done) {
                                                return CircularProgressIndicator();
                                              } else {
                                                final staffList = list.data!;
                                                return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: staffList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var staffData =
                                                          staffList[index]
                                                              .data();
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          StaffInfo(
                                                            staffData:
                                                                staffList[index]
                                                                    .reference,
                                                            staffName:
                                                                staffData[
                                                                    "name"],
                                                            staffID: "0",
                                                            userData:
                                                                snapshotReference,
                                                          )
                                                        ],
                                                      );
                                                    });
                                              }
                                            }),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        });
  }
}

class yesno extends StatelessWidget {
  const yesno({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 11,
          child: SizedBox(),
        ),
        Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text("Yes"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text("No"),
                )
              ],
            ))
      ],
    );
  }
}

class ListQuestion extends StatefulWidget {
  const ListQuestion({
    super.key,
    required this.index,
    required this.text,
    required this.name,
    required this.callback,
  });
  final int index;
  final String text;
  final String name;
  final Function callback;

  @override
  State<ListQuestion> createState() => _ListQuestionState();
}

class _ListQuestionState extends State<ListQuestion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Color(0xFFededeb) : Color(0xFFffffff),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Text(widget.index == 1
                  ? "a."
                  : widget.index == 2
                      ? "b."
                      : widget.index == 3
                          ? "c."
                          : widget.index == 4
                              ? "d."
                              : widget.index == 5
                                  ? "e."
                                  : widget.index == 6
                                      ? "f."
                                      : "g."),
            ),
            Expanded(flex: 10, child: Text(widget.text)),
            Expanded(
              flex: 8,
              child: FormBuilderRadioGroup(
                  name: widget.name,
                  validator: (value) {
                    if (value != 'y' && value != 'n') {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      widget.callback(widget.name, value);
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  wrapAlignment: WrapAlignment.spaceAround,
                  options: const <FormBuilderFieldOption>[
                    FormBuilderFieldOption(
                      value: 'y',
                      child: SizedBox(),
                    ),
                    FormBuilderFieldOption(
                      value: 'n',
                      child: SizedBox(),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class singleyesorno extends StatefulWidget {
  singleyesorno({
    super.key,
    required this.name,
    required this.callback,
    this.enabled = true,
  });
  final String name;
  final Function callback;
  bool enabled;

  @override
  State<singleyesorno> createState() => _singleyesornoState();
}

class _singleyesornoState extends State<singleyesorno> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: FormBuilderRadioGroup(
              validator: (value) {
                if (value != 'y' && value != 'n') {
                  if (widget.name == 'f8' ||
                      widget.name == 'f9' ||
                      widget.name == 'f10' ||
                      widget.name == 'f11') {
                  } else {
                    return 'Required';
                  }
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.callback(widget.name, value);
                });
              },
              name: widget.name,
              wrapAlignment: WrapAlignment.spaceBetween,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              options: const <FormBuilderFieldOption>[
                FormBuilderFieldOption(
                  value: 'y',
                  child: Text("Yes"),
                ),
                FormBuilderFieldOption(
                  value: 'n',
                  child: Text("No"),
                ),
              ]),
        )
      ],
    );
  }
}

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      this.inputtype = TextInputType.text,
      this.hinttext = '',
      required this.name,
      required this.callback});
  final String hinttext;
  final TextInputType inputtype;
  final String name;
  final Function callback;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      keyboardType: widget.inputtype,
      name: widget.name,
      validator: (value) {
        if (value == null || value == "") {
          return 'Required';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          widget.callback(widget.name, value);
        });
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: widget.hinttext,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 10),
      ),
    );
  }
}

class StaffInfo extends StatefulWidget {
  final String staffName;
  final String staffID;
  final DocumentReference staffData;
  final DocumentReference userData;
  const StaffInfo(
      {super.key,
      required this.staffData,
      required this.staffName,
      required this.staffID,
      required this.userData});

  @override
  State<StaffInfo> createState() => _StaffInfoState();
}

class _StaffInfoState extends State<StaffInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFC7E9E6),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            'lib/assets/images/profile.png',
            width: 75,
            height: 75,
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.staffName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '3 years++ experience in...',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TCAAppointmentPage(
                          staffData: widget.staffData,
                          userData: widget.userData,
                        )),
              );
            },
            icon: Icon(
              Ionicons.chevron_forward_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
