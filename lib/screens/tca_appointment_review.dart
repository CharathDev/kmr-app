import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kmrapp/screens/root.dart';

class TCAAppointmentReview extends StatefulWidget {
  final DateTime day;
  final String timeSlot;
  final String name;

  const TCAAppointmentReview(
      {super.key,
      required this.day,
      required this.timeSlot,
      required this.name});
  @override
  State<TCAAppointmentReview> createState() => _TCAAppointmentReviewState();
}

class _TCAAppointmentReviewState extends State<TCAAppointmentReview> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController thoughtsController = TextEditingController();
  int selectedRating = 3;

  void setFeeback() {
    FirebaseFirestore.instance.collection('feedback').doc(user.uid).set({
      "rating": selectedRating,
      "thoughts": thoughtsController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    String dayString = widget.day.day.toString() +
        "/" +
        widget.day.month.toString() +
        "/" +
        widget.day.year.toString();
    String timeSlotString = widget.timeSlot;
    String nameString = widget.name;
    return Scaffold(
      backgroundColor: Colors.grey[200], // Match the background color
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20), // Adds margin around the card
          padding: const EdgeInsets.all(20), // Adds padding inside the card
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25), // Rounded corners
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Fit content in the column
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 60,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16), // Spacing between icon and text
                    const Text(
                      'Your appointment on',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    Text(
                      '$dayString,',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    Text(
                      timeSlotString,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    const Text(
                      'with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    Text(
                      nameString,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    const Text(
                      'has been confirmed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    const SizedBox(height: 24), // Spacing before buttons
                    const Text(
                      'Your thoughts are important!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Help us improve this app by reviewing and sharing your experience while using it.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5, // Line spacing
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: 3,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const Icon(
                                Icons.star,
                                color: Colors.red,
                              );
                            case 1:
                              return const Icon(
                                Icons.star,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            case 3:
                              return const Icon(
                                Icons.star,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return const Icon(
                                Icons.star,
                                color: Colors.green,
                              );
                            default:
                              return const Placeholder();
                          }
                        },
                        onRatingUpdate: (rating) {
                          selectedRating = rating.toInt();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      minLines:
                          6, // any number you need (It works as the rows for the textarea)
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        labelText: 'Send us your thoughts and feedbacks...',
                      ),
                      controller: thoughtsController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setFeeback();
                        int count = 0;
                        Navigator.of(context).popUntil(
                          (_) => count++ >= 2,
                        );
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RootPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15), // Padding inside the button
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
