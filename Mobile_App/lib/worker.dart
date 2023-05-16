import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class tablepicker extends StatefulWidget {
  const tablepicker({Key? key}) : super(key: key);
  @override
  State<tablepicker> createState() => _tablepickerState();
}

class _tablepickerState extends State<tablepicker>
{
  File? _image;
  String message = "";
  uploadimage() async{
    final request = http.MultipartRequest(
      "POST", Uri.parse("http://127.0.0.1/scan")
    );
    final headers = {"Content-type":"multipart/form-data"};
    if (_image != null)
    request.files.add(http.MultipartFile('image',_image!.readAsBytes().asStream(),_image!.lengthSync(),filename: _image!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body) as Map<String,dynamic>;
    message = resJson["message"];
    setState(() {
      message = resJson["message"];
    });


  }
  Future getImage(ImageSource source) async{
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final tempimage = File(image.path);
    setState(() {
      this._image = tempimage;
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar:AppBar(
          title:Text('Scan a table to convert to csv!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
              )),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
            child: Column(
                children: [
                  SizedBox(height: 30),
                  _image != null ? Image.file(_image!, width: 250, height: 250,fit:BoxFit.cover) : Image.network('https://picsum.photos/250?image=9'),
                  SizedBox(height: 30),
                  CustomButton(title: 'Pick image from Gallary',icon: Icons.image_rounded,onClick:() => getImage(ImageSource.gallery)),
                  SizedBox(height: 30),
                  CustomButton(title: 'Capture a Picture',icon: Icons.camera_alt_rounded,onClick:() => getImage(ImageSource.camera)),
                  SizedBox(height: 30),
                  TextButton(onPressed: () {
                    uploadimage();

                  },
                      child: Text('Scan',
                        style:TextStyle(
                            fontSize: 35,
                            fontFamily: 'Poppins',
                            color: Colors.black
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Color(0xff4c505b)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.black)
                            )
                        ),)
                  )

                ,
                SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.only(left: 33.333),
                    child: Text(message,style: TextStyle(fontFamily: 'Poppins',fontSize: 20,fontWeight: FontWeight.bold)
                    )),
                ]
                )
            )
        );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}){

  return Container(
      width: 280,
      child:TextButton(
          onPressed: onClick,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 50),
              Text(title, style: TextStyle(fontFamily: 'Poppins'))
            ],
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Color(0xff4c505b)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black)
                )
            ),)
      )
  );
}


