import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Infographics3 extends StatefulWidget {
  const Infographics3({super.key});

  @override
  State<Infographics3> createState() => _Infographics3State();
}

class _Infographics3State extends State<Infographics3> {
  late PdfControllerPinch controller3;
  int totalPageCount = 0;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    controller3 = PdfControllerPinch(
      document: PdfDocument.openAsset(
          'lib/assets/pdf/remaja_realiti_risiko_remaja.pdf'),
    );
  }

  @override
  void dispose() {
    controller3.dispose();
    super.dispose();
  }

  void goToPreviousPage() async {
    await controller3.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToNextPage() async {
    await controller3.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Realiti Risiko Remaja",
          style:
              TextStyle(color: Color(0xff966FD6), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffDFCEFA),
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
            IconButton(
                onPressed: () {
                  goToPreviousPage();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            Text("$currentPage/$totalPageCount"),
            IconButton(
                onPressed: () {
                  goToNextPage();
                },
                icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        controller: controller3,
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
