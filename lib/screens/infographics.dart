import 'package:flutter/material.dart';
import 'package:kmrapp/screens/infographics1.dart';
import 'package:kmrapp/screens/infographics2.dart';
import 'package:kmrapp/screens/infographics3.dart';

class Infographics extends StatelessWidget {
  const Infographics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff966FD6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Remaja & Kesihatan Mental',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 4,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    'Kesihatan mental berkait rapat dengan kehidupan remaja',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Infographics1()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                  'READ MORE >>>',
                                  style: TextStyle(
                                    color: Color(0xff966FD6),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                )
                              )))),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Image.asset('lib/assets/images/img1.jpg'),
             SizedBox(height: 15,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff966FD6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Makanan Pilihan Remaja Cemerlang',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 4,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    'Cara-cara pengambilan makanan yang berkhasiat',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Infographics2()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                  'READ MORE >>>',
                                  style: TextStyle(
                                    color: Color(0xff966FD6),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                )
                              )))),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Image.asset('lib/assets/images/img2.jpg'),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff966FD6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '3R: Realiti, Risiko, Remaja',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 4,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    'Tingkah laku berisiko dan akibat-akibatnya',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Infographics3()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                  'READ MORE >>>',
                                  style: TextStyle(
                                    color: Color(0xff966FD6),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                )
                              )))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
