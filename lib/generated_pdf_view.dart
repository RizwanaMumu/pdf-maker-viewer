import 'dart:io';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GeneratedPdfViewerPage extends StatefulWidget {
  final images;
  GeneratedPdfViewerPage({this.images});
  @override
  State<GeneratedPdfViewerPage> createState() => _GeneratedPdfViewerPageState();
}

class _GeneratedPdfViewerPageState extends State<GeneratedPdfViewerPage> {
  late Size size;
  List<XFile> _images = [];

  ScrollController scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _images = widget.images;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12A77E),
        title: Center(
          child: Text(
            'Pdf Maker and Viewer',
          ),
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){

              },
              child: Icon(
                Icons.save_alt, color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding:  EdgeInsets.only(left: 20.0,right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xffd2d2d2),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Add Title Here', hintStyle: TextStyle(color: Colors.black), border: InputBorder.none),
                ),
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(alignment: Alignment.topRight, children: [
                          Positioned(
                            child: Container(
                              width: size.width,
                              child: Image.file(
                                File(widget.images[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _images.removeAt(index);
                                  });
                                },
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(0.0, 1.0),
                                              blurRadius: 15
                                          )
                                        ]
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    )),
                              )),
                        ]),
                      )
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        fabSize: 50,
        fabColor: Color(0xff12A77E),
        ringColor: Color(0xda12a77e),
        ringWidth: 80,
        ringDiameter: 280,
        fabOpenIcon: Icon(Icons.edit, color: Colors.white,),
        fabCloseIcon: Icon(Icons.close, color: Colors.white,),

        children: [
          SizedBox(
            height: 70,
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                IconButton(icon: Icon(Icons.description, color: Colors.white, size: 28,), onPressed: () {
                  print('Home');
                }),
                Text("Add description", style: TextStyle(color: Colors.white, fontSize: 10),)
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              IconButton(icon: Icon(Icons.title, color: Colors.white, size: 28,), onPressed: () {

              }),
              Text("Add Title", style: TextStyle(color: Colors.white, fontSize: 10),)
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                IconButton(icon: Icon(Icons.control_camera, color: Colors.white, size: 30,), onPressed: () {
                  print('Home');
                }),
                Text("Rearrange", style: TextStyle(color: Colors.white, fontSize: 10),)
              ],
            ),
          ),

        ],

      ),
    );
  }
}
