import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  final pdfPath;
  PdfViewerPage({this.pdfPath});
  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff12A77E),
          title: Center(
            child: Text(
              'Pdf Maker and Viewer',
            ),
          )),
      body: Container(
        child: PDFView(
          filePath: widget.pdfPath,
        ),
      ),
      floatingActionButton: FabCircularMenu(children: [
        IconButton(icon: Icon(Icons.home), onPressed: () {
          print('Home');
        }),
        IconButton(icon: Icon(Icons.favorite), onPressed: () {
          print('Favorite');
        })
      ],

      ),

    );
  }
}
