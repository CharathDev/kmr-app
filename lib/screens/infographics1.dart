import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Infographics1 extends StatefulWidget {
  const Infographics1({super.key});

  @override
  State<Infographics1> createState() => _InfographicsState();
}

class _InfographicsState extends State<Infographics1> {
  late PdfControllerPinch controller1;
  int totalPageCount = 0;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    controller1 = PdfControllerPinch(
      document:
          PdfDocument.openAsset('lib/assets/pdf/remaja_kesihatan_mental.pdf'),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  void goToPreviousPage() async {
      await controller1.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
  }
  void goToNextPage() async {
      await controller1.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "PDF Viewer",
          style:
              TextStyle(color: Color(0xff966FD6), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffDFCEFA),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              goToPreviousPage();
            }, icon: Icon(Icons.arrow_back_ios)),
            Text("${currentPage}/${totalPageCount}"),
            IconButton(onPressed: () {
              goToNextPage();
            }, icon: Icon(Icons.arrow_forward_ios)),
            ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        controller: controller1,
        scrollDirection: Axis.vertical,
        onDocumentLoaded: (doc) {
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
