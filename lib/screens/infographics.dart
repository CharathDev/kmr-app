import 'package:flutter/material.dart';
import 'package:kmrapp/screens/infographics1.dart';
import 'package:kmrapp/screens/infographics2.dart';
import 'package:kmrapp/screens/infographics3.dart';

class Infographics extends StatelessWidget {
  const Infographics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: const Column(
                      children: [
                        Text(
                          'Remaja & Kesihatan Mental',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 4,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Mental health is closely related to a teenager's life",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffededeb),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Material(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff966FD6),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Infographics1()));
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Center(
                                          child: Text(
                                            'READ MORE',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ))))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset('lib/assets/images/img1.jpg'),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: const Column(
                      children: [
                        Text(
                          'Makanan Pilihan Remaja Cemerlang',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 4,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Methods of consuming nutritious food',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffededeb),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Material(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff966FD6),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Infographics2()));
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Center(
                                          child: Text(
                                            'READ MORE',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ))))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset('lib/assets/images/img2.jpg'),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffd9d9d9),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: const Column(
                      children: [
                        Text(
                          '3R: Realiti, Risiko, Remaja',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 4,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Risky behavior and its consequences',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffededeb),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Material(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff966FD6),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Infographics3()));
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Center(
                                          child: Text(
                                            'READ MORE',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ))))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
