import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_maker/generated_pdf_view.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size size;
  List<XFile> _images = [];


  String fPath='';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff12A77E),
          title: Center(
            child: Text(
              'Pdf Maker and Viewer',
            ),
          )),
      body: Container(
        height: size.height,
        width: size.width,
        color: Color(0xffF5F6F9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: MaterialButton(
                          onPressed: () {
                            _reset();
                          },
                          color: Colors.white,
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_copy_rounded,
                                color: Color(0xff12A77E),
                                size: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "View PDF",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0))),
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: MaterialButton(
                          onPressed: () {
                            _pickImage(context);
                          },
                          color: Colors.white,
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.create_new_folder,
                                color: Color(0xff12A77E),
                                size: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Create PDF",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0))),
                    ),
                  ],
                ),
              ),
              /*Expanded(child: ListView.builder(
                      itemCount: _images.length,
                      itemBuilder: (context, index) => Container(
                          height: 400,
                          width: double.infinity,
                          margin: EdgeInsets.all(8),
                          child: Image.file(
                            File(_images[index].path),
                            fit: BoxFit.cover,
                          )),
                    ))*/
            ],
          ),
        ),
      ),
    );
  }

  _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final _pickedImages = await _picker.pickMultiImage();

    setState(() {
      _images = _pickedImages;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GeneratedPdfViewerPage(images: _images,)));
    //_createPdf(context);
  }

  Future _createPdf(BuildContext context){
    final PdfDocument pdf = PdfDocument();
    for (var img in _images) {
      final File? imagefile = File(img!.path);
      final image = PdfBitmap(imagefile!.readAsBytesSync());
      pdf.pages.add().graphics.drawImage(image, Rect.fromLTWH(0, 0, 500, 500));
    }
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Create PDF"),
          content: Text("Successfully Created!"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                MaterialButton(

                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewerPage(pdfPath: fPath,)));
                  },
                  minWidth: 70,
                  height: 35,
                  color: Color(0xff12A77E),
                  child: Text("Open", style: TextStyle(fontSize: 12, color: Colors.white),),
                ),
                /*MaterialButton(

                  onPressed: () {
                    _savePDF(pdf);
                  },
                  minWidth: 70,
                  height: 35,
                  color: Color(0xff12A77E),
                  child: Text("Download", style: TextStyle(fontSize: 12, color: Colors.white),),
                ),*/
                MaterialButton(

                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: 70,
                  height: 35,
                  color: Color(0xff12A77E),
                  child: Text("Cancel", style: TextStyle(fontSize: 12, color: Colors.white),),
                ),

              ],
            )
          ],
        ));
  }

 /* Future _createPdf(BuildContext context) {
    final pdf = pw.Document();
    for (var img in _images) {
      final File? imagefile = File(img!.path);
      final image = pw.MemoryImage(imagefile!.readAsBytesSync());
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Create PDF"),
              content: Text("Successfully Created!"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    MaterialButton(

                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewerPage(pdfPath: fPath,)));
                      },
                      minWidth: 70,
                      height: 35,
                      color: Color(0xff12A77E),
                      child: Text("Open", style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),
                   MaterialButton(

                      onPressed: () {
                        _savePDF(pdf);
                      },
                      minWidth: 70,
                      height: 35,
                      color: Color(0xff12A77E),
                      child: Text("Download", style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),
                   MaterialButton(

                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      minWidth: 70,
                      height: 35,
                      color: Color(0xff12A77E),
                      child: Text("Cancel", style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),

                  ],
                )
              ],
            ));
  }*/




 /* _savePDF(pw.Document pdf) async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/filename.pdf');
      await file.writeAsBytes(await pdf.save());
      print("file dir "+dir.path.toString());
      print("file path "+file.toString());
      fPath=file.path;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sucess! Saved to Document")));
      _images.clear();

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error! ${e}")));
    }
  }*/



  _reset() {
    setState(() {
      _images.clear();
    });
  }
}
