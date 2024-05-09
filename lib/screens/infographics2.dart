import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Infographics2 extends StatefulWidget {
  const Infographics2({super.key});

  @override
  State<Infographics2> createState() => _Infographics2State();
}

class _Infographics2State extends State<Infographics2> {
  late PdfControllerPinch controller2;
  int totalPageCount = 0;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    controller2 = PdfControllerPinch(
      document:
          PdfDocument.openAsset('lib/assets/pdf/13_buku_kecil_makanan_pilihan_remaja_cemerlang.pdf'),
    );
  }

  @override
  void dispose() {
    controller2.dispose();
    super.dispose();
  }

  void goToPreviousPage() async {
      await controller2.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
  }
  void goToNextPage() async {
      await controller2.nextPage(
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
        controller: controller2,
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
