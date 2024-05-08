import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ADMINReviewPage(contacts: contacts)));
}

// Data model for each contact
class Contact {
  final String name;
  final String email;
  final String description;
  final int starRating;

  Contact({required this.name, required this.email, required this.description, this.starRating = 5});
}

// Sample data: List of contacts
List<Contact> contacts = [
  Contact(
    name: 'Andrew Lee',
    email: 'andrewlee@gmail.com',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, asasd.as.d.asd.as.d.sad.as.d.asd.as.da.sd.as.ds.dha;skdhasdhasdhlasdha;sldjaskldhasldasdlsadasdsed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
    starRating: 4,
  ),
  Contact(
    name: 'Jane Doe',
    email: 'janedoe@example.com',
    description: 'Short description here. Something about Jane Doe\'s preferences and hobbies, perhaps.',
    starRating: 3,
  ),
  // More contacts can be added here
];

// Stateless widget that displays a list of contact cards
class ADMINReviewPage extends StatelessWidget {
  final List<Contact> contacts;

  ADMINReviewPage({required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tracking Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(contact: contacts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateful widget for each contact card
class ContactCard extends StatefulWidget {
  final Contact contact;

  ContactCard({required this.contact});

  @override
  _ContactCardState createState() => _ContactCardState();
}

// State for each contact card
class _ContactCardState extends State<ContactCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final contact = widget.contact;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(contact.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(contact.email, style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < contact.starRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          SizedBox(height: 10),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return buildExpandableText(contact.description, constraints);
            }
          ),
        ],
      ),
    );
  }

  Widget buildExpandableText(String text, BoxConstraints constraints) {
    final style = TextStyle(fontSize: 14);
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: constraints.maxWidth);

    if (textPainter.didExceedMaxLines) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: style, maxLines: isExpanded ? null : 100, overflow: TextOverflow.ellipsis),
          InkWell(
            child: Text(
              isExpanded ? 'Read More...' : 'Read Less...',
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          )
        ],
      );
    } else {
      return Text(text, style: style);
    }
  }
}