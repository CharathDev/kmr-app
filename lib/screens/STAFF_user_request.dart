import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kmrapp/screens/STAFF_root.dart';

class STAFFUserRequestPage extends StatefulWidget {
  STAFFUserRequestPage(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.ic,
      required this.values,
      required this.reviewedUser});
  final String name;
  final String email;
  final String ic;
  final Map<String, dynamic> values;
  final Function reviewedUser;
  final String id;
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
  State<STAFFUserRequestPage> createState() => _STAFFUserRequestPageState();
}

class _STAFFUserRequestPageState extends State<STAFFUserRequestPage> {
  late List<Set<Map<String, dynamic>>> questions = [
    {
      {
        "text": "Full Name",
        "child": MyTextField(
          name: 'a1',
          values: widget.values,
        )
      },
      {
        "text": "Gender",
        "child": FormBuilderRadioGroup(
            name: "a2",
            enabled: false,
            initialValue: widget.values['a2'],
            wrapAlignment: WrapAlignment.start,
            wrapSpacing: 50,
            decoration: const InputDecoration(
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
          name: 'a3',
          values: widget.values,
        )
      },
      {
        "text": "IC / Passport Number",
        "child": MyTextField(
          name: 'a4',
          values: widget.values,
        )
      },
      {
        "text": "Citizenship",
        "child": Column(
          children: [
            FormBuilderRadioGroup(
                enabled: false,
                initialValue: widget.values['a5'],
                name: "a5",
                wrapAlignment: WrapAlignment.start,
                wrapSpacing: 100,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                options: <FormBuilderFieldOption>[
                  const FormBuilderFieldOption(
                    value: 'Malaysia',
                  ),
                  FormBuilderFieldOption(
                    value: 'Other',
                    child: SizedBox(
                      width: 200,
                      child: FormBuilderTextField(
                        style: const TextStyle(fontSize: 14),
                        name: '',
                        readOnly: true,
                        initialValue: widget.values['a5i'],
                        decoration: const InputDecoration(
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
            name: "a6",
            enabled: false,
            initialValue: widget.values['a6'],
            wrapAlignment: WrapAlignment.start,
            wrapSpacing: 100,
            decoration: const InputDecoration(
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
            name: "a7",
            enabled: false,
            initialValue: widget.values['a7'],
            wrapAlignment: WrapAlignment.start,
            wrapSpacing: 100,
            decoration: const InputDecoration(
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
            name: "a8",
            enabled: false,
            initialValue: widget.values['a8'],
            wrapAlignment: WrapAlignment.start,
            wrapRunAlignment: WrapAlignment.start,
            wrapSpacing: 300,
            wrapRunSpacing: 10,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            options: <FormBuilderFieldOption>[
              FormBuilderFieldOption(
                  value: 'working',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Working, at: "),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: FormBuilderTextField(
                          style: const TextStyle(fontSize: 14),
                          name: '',
                          readOnly: true,
                          initialValue: widget.values['a8i'],
                          decoration: const InputDecoration(
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
                      const Text("Still studying, at: "),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: FormBuilderTextField(
                          style: const TextStyle(fontSize: 14),
                          name: '',
                          readOnly: true,
                          initialValue: widget.values['a8ii'],
                          decoration: const InputDecoration(
                            hintText: "Your school",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )),
              const FormBuilderFieldOption(
                value: 'Not working',
              ),
            ]),
      },
      {
        "text": "Marriage Status",
        "child": FormBuilderRadioGroup(
            name: "a9",
            enabled: false,
            initialValue: widget.values['a9'],
            wrapAlignment: WrapAlignment.start,
            wrapRunAlignment: WrapAlignment.start,
            wrapSpacing: 300,
            wrapRunSpacing: 10,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            options: <FormBuilderFieldOption>[
              const FormBuilderFieldOption(
                value: 'Single',
              ),
              FormBuilderFieldOption(
                  value: 'married',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Married, no. of children: "),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: FormBuilderTextField(
                          style: const TextStyle(fontSize: 14),
                          name: '',
                          readOnly: true,
                          initialValue: widget.values['a9i'],
                          decoration: const InputDecoration(
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
                      const Text("Widow/widower, no. of children: "),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: FormBuilderTextField(
                          style: const TextStyle(fontSize: 14),
                          name: '',
                          readOnly: true,
                          initialValue: widget.values['a9ii'],
                          decoration: const InputDecoration(
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
          values: widget.values,
        )
      },
      {
        "text": "Phone number",
        "child": Row(
          children: [
            Expanded(
                flex: 8,
                child: MyTextField(
                  name: 'a11a',
                  values: widget.values,
                )),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
                flex: 8,
                child: MyTextField(
                  name: 'a11b',
                  values: widget.values,
                )),
          ],
        )
      },
      {
        "text": "Email",
        "child": MyTextField(
          name: 'a12',
          values: widget.values,
        )
      },
      {
        "text": "Last Normal Menstrual Period (Female only)",
        "child": FormBuilderTextField(
          readOnly: true,
          initialValue: widget.values['a13'],
          name: 'a13',
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'DD/MM/YYYY',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(left: 10),
          ),
        )
      },
    }.toSet(),
    {
      {
        "text": "Do you or a family member suffer from the following diseases:",
        "child": Column(
          children: [
            const Row(
              children: [
                Expanded(
                  flex: 12,
                  child: SizedBox(),
                ),
                Expanded(
                    flex: 7,
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Text("a."),
                  ),
                  const Expanded(flex: 11, child: Text("Hypertension")),
                  Expanded(
                    flex: 7,
                    child: FormBuilderCheckboxGroup(
                        name: "s",
                        enabled: false,
                        initialValue: widget.values['b1a'],
                        wrapAlignment: WrapAlignment.spaceAround,
                        decoration: const InputDecoration(
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
                color: const Color(0xFFededeb),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("b."),
                    ),
                    const Expanded(flex: 11, child: Text("Diabetes")),
                    Expanded(
                      flex: 7,
                      child: FormBuilderCheckboxGroup(
                          name: "s",
                          enabled: false,
                          initialValue: widget.values['b1b'],
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: const InputDecoration(
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Text("c."),
                  ),
                  const Expanded(flex: 11, child: Text("Heart Disease")),
                  Expanded(
                    flex: 7,
                    child: FormBuilderCheckboxGroup(
                        name: "s",
                        enabled: false,
                        initialValue: widget.values['b1c'],
                        wrapAlignment: WrapAlignment.spaceAround,
                        decoration: const InputDecoration(
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
                color: const Color(0xFFededeb),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("d."),
                    ),
                    const Expanded(flex: 11, child: Text("Asthma")),
                    Expanded(
                      flex: 7,
                      child: FormBuilderCheckboxGroup(
                          name: "s",
                          enabled: false,
                          initialValue: widget.values['b1d'],
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: const InputDecoration(
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Text("e."),
                  ),
                  const Expanded(
                      flex: 11,
                      child: Text("Hereditary Disease (e.g. Thalassemia)")),
                  Expanded(
                    flex: 7,
                    child: FormBuilderCheckboxGroup(
                        name: "s",
                        enabled: false,
                        initialValue: widget.values['b1e'],
                        wrapAlignment: WrapAlignment.spaceAround,
                        decoration: const InputDecoration(
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
                color: const Color(0xFFededeb),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("f."),
                    ),
                    const Expanded(
                        flex: 11,
                        child: Text("Contagious Disease (e.g. TB, Hepatitis)")),
                    Expanded(
                      flex: 7,
                      child: FormBuilderCheckboxGroup(
                          name: "s",
                          enabled: false,
                          initialValue: widget.values['b1f'],
                          wrapAlignment: WrapAlignment.spaceAround,
                          decoration: const InputDecoration(
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
        "child": singleyesorno(
          name: "b2",
          values: widget.values,
        )
      },
      {
        "text": "Have you ever...",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text: "...experienced a severe drug allergy?",
            name: "b3a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "...gone through any form of surgery?",
            name: "b3b",
            values: widget.values,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  child: FormBuilderTextField(
                    style: const TextStyle(fontSize: 14),
                    name: '',
                    readOnly: true,
                    initialValue: widget.values['b3bi'],
                    decoration: const InputDecoration(
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
            singleyesorno(
              name: "b4",
              values: widget.values,
            ),
            SizedBox(
              width: 200,
              child: FormBuilderTextField(
                readOnly: true,
                initialValue: widget.values['b4i'],
                style: const TextStyle(fontSize: 14),
                name: '',
                decoration: const InputDecoration(
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
        "child": singleyesorno(
          name: "c1",
          values: widget.values,
        )
      },
    }.toSet(),
    {
      {
        "text":
            "I eat according to the set eating time period below every day:",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Breakfast",
            name: "d1a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Lunch",
            name: "d1b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "Dinner",
            name: "d1c",
            values: widget.values,
          ),
        ])
      },
      {
        "text": "Do you consume all kinds of food including:",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Grain food (e.g. rice, noodles or bread)",
            name: "d2a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Fruits",
            name: "d2b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "Vegetable",
            name: "d2c",
            values: widget.values,
          ),
          ListQuestion(
            index: 4,
            text: "Milk and dairy products (e.g. cheese, yoghurt)",
            name: "d2d",
            values: widget.values,
          ),
          ListQuestion(
            index: 5,
            text: "Beef / chicken / eggs / fish / seafood or nuts",
            name: "d2e",
            values: widget.values,
          ),
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
                    name: "s",
                    enabled: false,
                    initialValue: widget.values['d3'],
                    wrapAlignment: WrapAlignment.start,
                    wrapSpacing: 50,
                    decoration: const InputDecoration(
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
        "child": singleyesorno(
          name: "e1",
          values: widget.values,
        )
      },
      {
        "text":
            "I exercise at least 150 minutes every week (e.g. speedwalking 30 minutes for at least 5 times a week)",
        "child": singleyesorno(
          name: "e2",
          values: widget.values,
        )
      },
    }.toSet(),
    {
      {
        "text": "I had experienced problems as below:",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Pus or odour smell from private parts",
            name: "f1a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Itchiness or scadies on private parts",
            name: "f1b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "Painfulness on pubic hair or private parts when urinating",
            name: "f1c",
            values: widget.values,
          ),
          ListQuestion(
            index: 4,
            text: "Other problems on private parts",
            name: "f1d",
            values: widget.values,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  child: FormBuilderTextField(
                    readOnly: true,
                    initialValue: widget.values['f1di'],
                    style: const TextStyle(fontSize: 14),
                    name: '',
                    decoration: const InputDecoration(
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
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Consumed pornographic material",
            name: "f2a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Masturbate (Sexually stimulated myself)",
            name: "f2b",
            values: widget.values,
          ),
        ])
      },
      {
        "text": "I have the desire to change sex?",
        "child": singleyesorno(
          name: "f3",
          values: widget.values,
        )
      },
      {
        "text": "I have the desire to have sex with the same gender?",
        "child": singleyesorno(
          name: "f4",
          values: widget.values,
        )
      },
      {
        "text": "I have a lover or partner?",
        "child": singleyesorno(
          name: "f5",
          values: widget.values,
        )
      },
      {
        "text": "I had sex? (If no, skip to next section)",
        "child": singleyesorno(
          name: "f6",
          values: widget.values,
        )
      },
      {
        "text": "I:",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Constantly change partners",
            name: "f7a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Have sex with the same gender",
            name: "f7b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: 'Have "unnatural" sex',
            name: "f7c",
            values: widget.values,
          ),
        ])
      },
      {
        "text": "I/My partner uses condom when having sex.",
        "child": singleyesorno(
          name: "f8",
          values: widget.values,
        )
      },
      {
        "text": "I/My partner uses pregnancy prevention methods.",
        "child": singleyesorno(
          name: "f9",
          values: widget.values,
        )
      },
      {
        "text": "I feel that my belly is getting bigger. (Female only)",
        "child": singleyesorno(
          name: "f10",
          values: widget.values,
        )
      },
      {
        "text": "I have experienced miscarriage. (Female only)",
        "child": singleyesorno(
          name: "f11",
          values: widget.values,
        )
      },
      {
        "text": "Menarche (Period for the first time) (Female only)",
        "child": SizedBox(
          height: 40,
          child: FormBuilderTextField(
            readOnly: true,
            initialValue: widget.values["f12"],
            name: 'menarche',
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
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
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Cigarettes / Tobacco / Vape",
            name: "g1a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Prohibited drugs",
            name: "g1b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "Alcohol",
            name: "g1c",
            values: widget.values,
          ),
          ListQuestion(
            index: 4,
            text: "Other substances or medicine",
            name: "g1d",
            values: widget.values,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  child: FormBuilderTextField(
                    initialValue: widget.values['g1di'],
                    readOnly: true,
                    style: const TextStyle(fontSize: 14),
                    name: '',
                    decoration: const InputDecoration(
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
          const yesno(),
          ListQuestion(
            index: 1,
            text: " am irritable",
            name: "h1a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "am a coward",
            name: "h1b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "am prone to worrying",
            name: "h1c",
            values: widget.values,
          ),
          ListQuestion(
            index: 4,
            text: "don't make friends and like to be alone",
            name: "h1d",
            values: widget.values,
          ),
        ])
      },
      {
        "text": "At often times, I am involved in the activities below:",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text: "Bullying",
            name: "h2a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Fights",
            name: "h2b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "Skip school",
            name: "h2c",
            values: widget.values,
          ),
          ListQuestion(
            index: 4,
            text: "Destroy or mutilate public property",
            name: "h2d",
            values: widget.values,
          ),
          ListQuestion(
            index: 5,
            text: "Drive/ride dangerously",
            name: "h2e",
            values: widget.values,
          ),
          ListQuestion(
            index: 6,
            text: "Ride on a motorcycle without wearing a safety helmet",
            name: "h2f",
            values: widget.values,
          ),
        ])
      },
    }.toSet(),
    {
      {
        "text": "Religion is important in my life.",
        "child": singleyesorno(
          name: "i1",
          values: widget.values,
        ),
      },
    }.toSet(),
    {
      {
        "text": "If I have any personal problems I always report to",
        "child": Row(
          children: [
            Expanded(
              child: FormBuilderCheckboxGroup(
                  enabled: false,
                  initialValue: (widget.values['j1']).cast<String>(),
                  name: "j1",
                  decoration: const InputDecoration(border: InputBorder.none),
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
        "child": singleyesorno(
          name: "j2",
          values: widget.values,
        ),
      },
      {
        "text": "I have the problems below:",
        "child": Column(children: [
          const yesno(),
          ListQuestion(
            index: 1,
            text:
                "Prone to worrying/depression for extended periods for more than 2 weeks",
            name: "j3a",
            values: widget.values,
          ),
          ListQuestion(
            index: 2,
            text: "Insomnia",
            name: "j3b",
            values: widget.values,
          ),
          ListQuestion(
            index: 3,
            text: "Having no appetite",
            name: "j3c",
            values: widget.values,
          ),
          ListQuestion(
            index: 4,
            text: "Thinks that life is meaningless",
            name: "j3d",
            values: widget.values,
          ),
          ListQuestion(
            index: 5,
            text: "Hard to calm down",
            name: "j3e",
            values: widget.values,
          ),
          ListQuestion(
            index: 6,
            text: "Always anxious and worried",
            name: "j3f",
            values: widget.values,
          ),
          ListQuestion(
            index: 7,
            text: "Had the thought to end life",
            name: "j3g",
            values: widget.values,
          ),
        ])
      },
    }.toSet(),
    {
      {
        "text":
            "Have you ever get bullied or abused, whether emotionally, physically or sexually?",
        "child": singleyesorno(
          name: "k1",
          values: widget.values,
        ),
      },
    }.toSet(),
  ];
  late bool submitted;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    submitted = false;
  }

  Widget RadioDoctor(
    bool doctorValue,
    String text,
    Function callback,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color:
              doctorValue ? const Color(0xffffffff) : const Color(0xffededeb),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: doctorValue ? const Color(0xff966fd6) : Colors.black,
              width: doctorValue ? 3 : 1)),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontWeight: doctorValue ? FontWeight.w900 : FontWeight.normal,
          ),
        ),
        leading: Checkbox(
          value: doctorValue,
          onChanged: (bool? value) {
            setState(() {
              callback(text, value);
            });
          },
        ),
      ),
    );
  }

  void endAppointment() async {
    await FirebaseFirestore.instance
        .collection('Appointments')
        .doc(widget.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        titleSpacing: 0,
        centerTitle: true,
        title: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
                color: Color(0xffDFCEFA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 24.0,
                        color: Color.fromARGB(255, 150, 111, 214),
                      ),
                    ),
                  ),
                  const Text(
                    'Review Request',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff966FD6)),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
            )),
      ),
      body: submitted
          ? Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0, color: const Color(0xffd9d9d9)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset(
                            "lib/assets/images/tick.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const Text(
                          "The appointment has ended",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                borderRadius: BorderRadius.circular(40),
                                color: const Color(0xff966fd6),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Done",
                                          style: TextStyle(
                                              fontFamily: "LeagueSpartan",
                                              fontSize: 16,
                                              color: Colors.white),
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
            )
          : ListView(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 14,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                ":  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Text(
                                  "E-mail",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                ":  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            widget.email,
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Text(
                                  "IC",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                ":  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            widget.ic,
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: STAFFUserRequestPage.title.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                          color: const Color(0xffededeb),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                iconColor: Colors.black,
                                collapsedIconColor: Colors.black,
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.end,
                                title: Text(
                                  STAFFUserRequestPage.title[i],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30)),
                                          border: Border.all(
                                              color: const Color(0xffd9d9d9),
                                              width: 3)),
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 5,
                                        ),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: questions[i].length,
                                            itemBuilder: (BuildContext context,
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
                                                        child: Text(questions[i]
                                                            .elementAt(
                                                                index)['text']),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: questions[i]
                                                        .elementAt(
                                                            index)['child'],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            }),
                                      )),
                                ]),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 250,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("CONFIRMATION"),
                                      content: const Text(
                                          "Has the appointment successfully ended?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            endAppointment();
                                            int count = 0;
                                            Navigator.of(context).popUntil(
                                              (_) => count++ >= 2,
                                            );
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        STAFFRootPage()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "END APPOINTMENT",
                                  style: TextStyle(
                                      fontFamily: "LeagueSpartan",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
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
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
    );
  }
}

class yesno extends StatelessWidget {
  const yesno({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 12,
          child: SizedBox(),
        ),
        Expanded(
            flex: 7,
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

class ListQuestion extends StatelessWidget {
  const ListQuestion({
    super.key,
    required this.index,
    required this.text,
    required this.name,
    required this.values,
  });
  final int index;
  final String text;
  final String name;
  final Map<String, dynamic> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            index % 2 == 1 ? const Color(0xFFededeb) : const Color(0xFFffffff),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Text(index == 1
                  ? "a."
                  : index == 2
                      ? "b."
                      : index == 3
                          ? "c."
                          : index == 4
                              ? "d."
                              : index == 5
                                  ? "e."
                                  : index == 6
                                      ? "f."
                                      : "g."),
            ),
            Expanded(flex: 11, child: Text(text)),
            Expanded(
              flex: 7,
              child: FormBuilderRadioGroup(
                  enabled: false,
                  initialValue: values[name],
                  name: name,
                  wrapAlignment: WrapAlignment.spaceAround,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
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

class singleyesorno extends StatelessWidget {
  singleyesorno({
    super.key,
    required this.name,
    this.enabled = false,
    required this.values,
  });
  final String name;
  bool enabled;
  final Map<String, dynamic> values;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: FormBuilderRadioGroup(
              enabled: false,
              initialValue: values[name],
              name: name,
              wrapAlignment: WrapAlignment.spaceBetween,
              decoration: const InputDecoration(
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

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.name, required this.values});
  final String name;
  final Map<String, dynamic> values;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      readOnly: true,
      initialValue: values[name],
      name: name,
      style: const TextStyle(fontSize: 14),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 10),
      ),
    );
  }
}
