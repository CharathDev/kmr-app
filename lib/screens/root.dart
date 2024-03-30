import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/bmi_page.dart';
import 'package:kmrapp/screens/tcabskk_page.dart';
import 'package:kmrapp/screens/home_page.dart';
import 'package:kmrapp/screens/location.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomePage(),
      BMIPage(),
      HomePage(),
      TCABSSKPage(),
      HomePage(),
      // other pages here, replace duplicate later
    ];
    var page = widgetOptions.elementAt(_selectedIndex);
    return Stack(
      children: [
        Scaffold(
          appBar: _selectedIndex == 2
              ? AppBar(
                  toolbarHeight: 320,
                  titleSpacing: 0,
                  centerTitle: true,
                  title: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    width: double.infinity,
                    height: 320,
                    decoration: const BoxDecoration(
                        color: Color(0xffDFCEFA),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Image.asset(
                          'lib/assets/images/3.png',
                          width: 150,
                          height: 150,
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
                              padding: EdgeInsets.all(5),
                              width: 75,
                              alignment: Alignment.center,
                              child: Text(
                                'Reach Us',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff966FD6),
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                        Text(
                          'Hi, User!',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff966FD6)),
                        )
                      ],
                    ),
                  ),
                )
              : AppBar(
                  toolbarHeight: 100,
                  titleSpacing: 0,
                  centerTitle: true,
                  title: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
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
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 24.0,
                                  color: Color.fromARGB(255, 150, 111, 214),
                                ),
                              ),
                            ),
                            Text(
                              _selectedIndex == 0
                                  ? 'Kajian Kepuasan'
                                  : _selectedIndex == 1
                                      ? 'BMI Calculator'
                                      : _selectedIndex == 3
                                          ? 'TCA / BSSK'
                                          : 'Profile',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff966FD6)),
                            ),
                            SizedBox(
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
              color: Color(0xffDFCEFA),
              child: BottomNavigationBar(
                backgroundColor: Color(0xffDFCEFA),
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.thumbs_up_outline), label: 'Review'),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.scale_outline), label: 'BMI'),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.home_outline), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.document_text_outline),
                      label: 'TCA & BSSK'),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.person_outline), label: 'Profile')
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: Color.fromARGB(255, 155, 155, 155),
                selectedItemColor: const Color.fromARGB(255, 114, 163, 187),
                onTap: _onItemTapped,
              ),
            ),
          ),
          body: page,
        ),
      ],
    );
  }
}
