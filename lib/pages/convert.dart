import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalproject/cubit/convert_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class convertScreen extends StatefulWidget {
  const convertScreen({super.key});
  @override
  State<convertScreen> createState() => _convertScreenState();
}

class _convertScreenState extends State<convertScreen> {
  final TextEditingController _smilesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String fileName = 'input.sdf';
    return BlocProvider(
        create: (context) => ConvertCubit(),
        child: BlocConsumer<ConvertCubit, ConvertState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
      backgroundColor: Color(0xff1D5D9B),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 66),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset("convert.png",width: 180,height: 140,)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: InkWell(
              onTap: () {
              
                 showModalBottomSheet(
    context: context,
   
    backgroundColor: Colors.white,
    isDismissible: false,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))),

  
  
   
               builder:(context)=> Container(
    height: 563,
    width: double.infinity,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            alignment: Alignment.center,
            height: 4.51,
            width: 134,
            color: Color(0xffCACACA),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(top:30,left: 40),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text("Input Smile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),)),
          ),
        
        
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
          child: TextFormField(
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start,
             autofocus: false,
              style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Color(0xff1D5D9B),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
                            ),
                          ),
                           border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
                            ),
                            borderRadius: BorderRadius.circular(32.0)
                          ),
                contentPadding: const EdgeInsets.symmetric(vertical: 60,horizontal: 10),
               
              ),
              controller: _smilesController,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Container(
                       // margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                        height: 66,
                        width: 285,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                                              ConvertCubit.get(context)
                                                  .convertAndDownload(
                                                      _smilesController.text);
                                              
                                            });
                          },
                            child: const Text(
                              'Convert',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            color: const Color(0xff1D5D9B),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),),),
        ),
      ],
    ),
   ),);
               
              },
              child: Container(
                alignment: Alignment.center,
                width: 322,
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text("SMILE TO SDF",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(top: 60),
            child: InkWell(
              onTap: () {
                 showModalBottomSheet(
    context: context,
   
    backgroundColor: Colors.white,
    isDismissible: false,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))),

  
  
   
               builder:(context)=> Container(
    height: 563,
    width: double.infinity,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            alignment: Alignment.center,
            height: 4.51,
            width: 134,
            color: Color(0xffCACACA),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(top:30,left: 40),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text("Input Smile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),)),
          ),
        
        
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
          child: TextFormField(
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.start,
             autofocus: false,
              style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Color(0xff1D5D9B),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
                            ),
                          ),
                           border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF000000),
                            ),
                            borderRadius: BorderRadius.circular(32.0)
                          ),
                contentPadding: const EdgeInsets.symmetric(vertical: 60,horizontal: 10),
               
              ),
              controller: _smilesController,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Container(
                       // margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                        height: 66,
                        width: 285,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                                              ConvertCubit.get(context)
                                                  .convertAndDownload(
                                                      _smilesController.text);
                                              
                                            });
                          },
                            child: const Text(
                              'Convert',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            color: const Color(0xff1D5D9B),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),),),
        ),
      ],
    ),
   ),);


              },
              child: Container(
                alignment: Alignment.center,
                width: 322,
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                 child: Text("SMILE TO PDB",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
              ),
            ),
          ), Padding(
            padding: const EdgeInsets.only(top: 60),
            child: InkWell(
              onTap: () {
             showModalBottomSheet(
    context: context,
   
    backgroundColor: Colors.white,
    isDismissible: false,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))),

  
  
   builder:(context)=> Container(
    height: 563,
    width: double.infinity,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            alignment: Alignment.center,
            height: 4.51,
            width: 134,
            color: Color(0xffCACACA),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child:  Center(
        child: GestureDetector(
           onTap: () async {
                                        FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles();

                                              if (result != null) {
                                                setState(() {
                                                    fileName =
                                                      result.files.single.name;
                                                  ConvertCubit.get(context)
                                                          .selectedFile =
                                                      result.files.single;
                                                });
                                               
                                              }    
                                            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                dashPattern: [10, 4],
                strokeCap: StrokeCap.round,
                color: Color(0xff1D5D9B),
                child: Container(
                  width: 298,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xfff8fafb),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("uploud.png",width: 115,height: 76,),
                      
                      Text(
                        "Upload SDF File",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Container(
                       // margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                        height: 66,
                        width: 285,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                                              ConvertCubit.get(context)
                                                  .uploadFile(context);
                                            });
                          },
                            child: const Text(
                              'Convert',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            color: const Color(0xff1D5D9B),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),),),
        ),
        
         
      ],
    ),
   ),);
              },
              child: Container(
                alignment: Alignment.center,
                width: 322,
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                 child: Text("SDF TO SMILE ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
              ),
            ),
          )
        ],
      ),
    );
          }
          
          
          )
        );
  }
 
  
}
