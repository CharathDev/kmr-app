import 'package:flutter/material.dart';
import 'package:kmrapp/screens/infographics1.dart';
import 'package:kmrapp/screens/infographics2.dart';
import 'package:kmrapp/screens/infographics3.dart';

class Infographics extends StatelessWidget {
  const Infographics({super.key});

  static final List<Map<String, dynamic>> infographics = [
    {
      "title": 'Remaja & Kesihatan Mental',
      "description": "Mental health is closely related to a teenager's life",
      "file": const Infographics1(),
      "image": Image.asset('lib/assets/images/img1.jpg'),
    },
    {
      "title": 'Makanan Pilihan Remaja Cemerlang',
      "description": 'Methods of consuming nutritious food',
      "file": const Infographics2(),
      "image": Image.asset('lib/assets/images/img2.jpg'),
    },
    {
      "title": '3R: Realiti, Risiko, Remaja',
      "description": 'Risky behavior and its consequences',
      "file": const Infographics3(),
      "image": const SizedBox(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: infographics.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 15),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                children: [
                                  Text(
                                    infographics[index]['title'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.black,
                                      decorationThickness: 4,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    infographics[index]['description'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 15),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: const Color(0xff966FD6),
                                          child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            infographics[index]
                                                                ['file']));
                                              },
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: const Center(
                                                    child: Text(
                                                      'READ MORE',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 15,
                                                      ),
                                                      textAlign: TextAlign.center,
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
                      infographics[index]["image"],
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class InfographicsWidget extends StatelessWidget {
  const InfographicsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.infographic,
  });
  final String title;
  final String description;
  final Widget infographic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xffd9d9d9),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    decorationThickness: 4,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  description,
                  style: const TextStyle(
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
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
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
                                      builder: (context) => infographic));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
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
    );
  }
}
