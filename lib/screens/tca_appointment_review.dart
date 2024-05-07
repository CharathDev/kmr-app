import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kmrapp/screens/home_page.dart';
import 'package:kmrapp/screens/profile_page.dart';
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
          margin: EdgeInsets.all(20), // Adds margin around the card
          padding: EdgeInsets.all(20), // Adds padding inside the card
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25), // Rounded corners
            boxShadow: [
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
              Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Colors.green,
              ),
              SizedBox(height: 16), // Spacing between icon and text
              Text(
                'Your appointment on\n$dayString\n$timeSlotString\nwith\n$nameString\nhas been confirmed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5, // Line spacing
                ),
              ),
              SizedBox(height: 24), // Spacing before buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RootPage()),
                  );
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15), // Padding inside the button
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('See my appointment(s)'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
