import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 2;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Our Location',
            style: TextStyle(color: Color(0xff966FD6)),
          ),
          backgroundColor: const Color(0xffDFCEFA),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 0, bottom: 14),
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'lib/assets/images/4.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color(0xffffdce4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xffff4044),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Ionicons.home,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Klinik Mesra Remaja ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            ' KK Kota Putera',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color(0xffffdce4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xffff4044),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Ionicons.location,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lot 763, Jalan Jerteh,',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Besut, Terengganu',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color(0xffffdce4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xffff4044),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffff0000),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Ionicons.call,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '09-6956341',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
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
                currentIndex: index,
                items: const <BottomNavigationBarItem>[
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
                onTap: (index) {
                  if (index == 0) {
                  } else if (index == 1) {
                  } else if (index == 2) {
                  } else if (index == 3) {
                  } else if (index == 4) {}
                },
              ),
            )));
  }
}
