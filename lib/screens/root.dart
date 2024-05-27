import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/bmi_page.dart';
import 'package:kmrapp/screens/infographics.dart';
import 'package:kmrapp/screens/profile_page.dart';
import 'package:kmrapp/screens/tcabskk_page.dart';
import 'package:kmrapp/screens/home_page.dart';
import 'package:kmrapp/screens/location.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return snapshot;
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool submitted = false;
    final List<Widget> widgetOptions = <Widget>[
      const Infographics(),
      BMIPage(),
      HomePage(),
      TCABSSKPage(
        submitted: submitted,
      ),
      ProfilePage(),
      // other pages here, replace duplicate later
    ];
    var page = widgetOptions.elementAt(_selectedIndex);
    return Scaffold(
      appBar: _selectedIndex == 2
          ? AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 270,
              titleSpacing: 0,
              centerTitle: true,
              title: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                width: double.infinity,
                height: 270,
                decoration: const BoxDecoration(
                    color: Color(0xffDFCEFA),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'lib/assets/images/3.png',
                      width: 120,
                      height: 120,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocationPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xff966FD6),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Reach Us',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        )),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getUserInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            submitted = data['BSSK'] != null;

                            return Text(
                              'Hi, ' + data['fullName'].split(" ")[0] + '!',
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff966FD6)),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else {
                            return const Center(
                                child: Text('Something went wrong'));
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          : AppBar(
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
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 24.0,
                              color: Color.fromARGB(255, 150, 111, 214),
                            ),
                          ),
                        ),
                        Text(
                          _selectedIndex == 0
                              ? 'Infographics'
                              : _selectedIndex == 1
                                  ? 'BMI Calculator'
                                  : _selectedIndex == 3
                                      ? 'HAF / TCA'
                                      : 'Profile',
                          style: const TextStyle(
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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: const Color(0xffDFCEFA),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xffDFCEFA),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.book_outline), label: 'Infographics'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.scale_outline), label: 'BMI'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.home_outline), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.document_text_outline),
                  label: 'TCA & HAF'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.person_outline), label: 'Profile')
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: const Color.fromARGB(255, 155, 155, 155),
            selectedItemColor: const Color.fromARGB(255, 114, 163, 187),
            onTap: _onItemTapped,
          ),
        ),
      ),
      body: page,
    );
  }
}
