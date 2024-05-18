import 'package:flutter/material.dart';
import 'package:kmrapp/screens/root.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ConsentPage extends StatefulWidget {
  const ConsentPage({super.key, required this.filledForm});

  final Function filledForm;

  @override
  State<ConsentPage> createState() => _ConsentPageState();
}

class _ConsentPageState extends State<ConsentPage> {
  String parentsNameErrorText = '';
  String parentsICErrorText = '';
  String childNameErrorText = '';
  String childICErrorText = '';
  String agreementErrorText = '';
  String childErrorText = '';
  final parentsNameController = TextEditingController();
  final parentsICController = TextEditingController();
  final childNameController = TextEditingController();
  final childICController = TextEditingController();
  bool agreement = false;
  String child = "";

  ScrollController listScrollController = ScrollController();

  void handleSubmission() {
    String parentsName = parentsNameController.text;
    String parentsIC = parentsICController.text;
    String childName = childNameController.text;
    String childIC = childICController.text;
    int error = 0;

    if (parentsName.isEmpty) {
      setState(() {
        parentsNameErrorText = "Required";
        error += 1;
      });
    }
    if (parentsIC.isEmpty) {
      setState(() {
        parentsICErrorText = "Required";
        error += 1;
      });
    }
    if (childName.isEmpty) {
      setState(() {
        childNameErrorText = "Required";
        error += 1;
      });
    }
    if (childIC.isEmpty) {
      setState(() {
        childICErrorText = "Required";
        error += 1;
      });
    }
    if (!agreement) {
      setState(() {
        agreementErrorText = "Required";
        error += 1;
      });
    }
    if (child.isEmpty) {
      setState(() {
        childErrorText = "Required";
        error += 1;
      });
    }

    if (error == 0) {
      widget.filledForm();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffDFCEFA),
      ),
      body: ListView(
        controller: listScrollController,
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 14,
        ),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xffDFCEFA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Consent Form',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff966FD6)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please ask your parents to fill in the form below',
                  style: TextStyle(color: Color(0xff966FD6), fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Parent/Guardian Approval Form for Health and Medication Screening/Intervention on the Level of Primary Health Treatment",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I, ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        errorText: parentsNameErrorText.isNotEmpty
                            ? parentsNameErrorText
                            : null,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: 'Parent/Guardian Name',
                      ),
                      controller:
                          parentsNameController, //initial value: "test@gmail.com"
                      onChanged: (value) {
                        setState(() {
                          parentsNameErrorText = "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "of IC number: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        errorText: parentsICErrorText.isNotEmpty
                            ? parentsICErrorText
                            : null,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: 'IC number',
                      ),
                      controller: parentsICController,
                      onChanged: (value) {
                        setState(() {
                          parentsICErrorText = "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "understands the explanation given and",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: agreement,
                          onChanged: (value) {
                            setState(() {
                              agreement = value!;
                              agreementErrorText = "";
                            });
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Agree",
                          ),
                        ),
                      ],
                    ),
                    if (agreementErrorText.isNotEmpty)
                      Text(
                        "Required",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.redAccent),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "that my",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    FormBuilderRadioGroup(
                        onChanged: (value) {
                          setState(() {
                            childErrorText = "";
                            child = value;
                          });
                        },
                        name: "a2",
                        wrapAlignment: WrapAlignment.start,
                        wrapSpacing: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        options: const <FormBuilderFieldOption>[
                          FormBuilderFieldOption(
                            value: 'Child',
                          ),
                          FormBuilderFieldOption(
                            value: 'Foster child',
                          )
                        ]),
                    if (childErrorText.isNotEmpty)
                      Text(
                        "Required",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.redAccent),
                      ),
                    TextField(
                      decoration: InputDecoration(
                        errorText: childNameErrorText.isNotEmpty
                            ? childNameErrorText
                            : null,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Child's name",
                      ),
                      controller: childNameController,
                      onChanged: (value) {
                        setState(() {
                          childNameErrorText = "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "of IC number: ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        errorText: childICErrorText.isNotEmpty
                            ? childICErrorText
                            : null,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: 'IC number',
                      ),
                      controller: childICController,
                      onChanged: (value) {
                        setState(() {
                          childICErrorText = "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "can go through **health screening, health intervention, and medication on the level of primary health treatment.",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Divider(),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "It is important to note that it is the parent/guardian's responsibility to inform respective health personnel if there is any change regarding the agreement of health screening/intervention and medication on the level of primary health treatment.",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "**Health screening mentioned involves Health Assesment Form (HAF or BSSK).",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff966FD6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              if (listScrollController.hasClients) {
                                final position = listScrollController
                                    .position.minScrollExtent;
                                listScrollController.animateTo(
                                  position,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                );
                              }
                              handleSubmission();
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'CONTINUE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
