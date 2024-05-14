import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kmrapp/screens/STAFF_home_page.dart';
import 'package:kmrapp/screens/STAFF_profile_page.dart';

class STAFFRootPage extends StatefulWidget {
  const STAFFRootPage({super.key});

  @override
  State<STAFFRootPage> createState() => _STAFFRootPageState();
}

class _STAFFRootPageState extends State<STAFFRootPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      STAFFHomePage(),
      STAFFProfilePage(),
    ];
    var page = widgetOptions.elementAt(_selectedIndex);
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 240,
              titleSpacing: 0,
              centerTitle: true,
              title: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                width: double.infinity,
                height: 240,
                decoration: const BoxDecoration(
                    color: Color(0xffDFCEFA),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'lib/assets/images/3.png',
                      width: 120,
                      height: 120,
                    ),
                    const Text(
                      'Staff',
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
                        const Text(
                          'Profile',
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
                  icon: Icon(Ionicons.home_outline), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.person), label: 'Profile')
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
