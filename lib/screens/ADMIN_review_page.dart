import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Data model for each contact
class Contact {
  final String name;
  final String email;
  final String description;
  final int starRating;
  
  Contact(
      {required this.name,
      required this.email,
      required this.description,
      this.starRating = 5});
}

// Stateless widget that displays a list of contact cards
class ADMINReviewPage extends StatefulWidget {
  const ADMINReviewPage({super.key});

  @override
  State<ADMINReviewPage> createState() => _ADMINReviewPageState();
}

class _ADMINReviewPageState extends State<ADMINReviewPage> {
  Future<List<Contact>> getReviews() async {
    List<Contact> contacts = [];
    await FirebaseFirestore.instance
        .collection('feedback')
        .get()
        .then((value) async {
      for (var docSnapshot in value.docs) {
        var data = docSnapshot.data();
        var userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(docSnapshot.id)
            .get()
            .then((value) => value);
        var tempContact = Contact(
            name: userData.data()!["fullName"],
            email: userData.data()!["email"],
            description: data["thoughts"],
            starRating: data["rating"]);
        contacts.add(tempContact);
      }
    });
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tracking Reviews",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
                child: FutureBuilder(
              future: getReviews(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData &&
                    snapshot.connectionState != ConnectionState.done) {
                  return CircularProgressIndicator();
                } else {
                  var contacts = snapshot.data!;
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return ContactCard(contact: contacts[index]);
                    },
                  );
                }
              }),
            )),
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
          Text(contact.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          }),
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
          Text(text,
              style: style,
              maxLines: isExpanded ? null : 100,
              overflow: TextOverflow.ellipsis),
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
