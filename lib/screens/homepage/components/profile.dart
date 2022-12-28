import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/bloc/profileBloc/profile_bloc.dart';
import 'package:mdk/screens/homepage/home_page.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'dart:io';

import '../../../bloc/HomepageBloc/homepage_bloc.dart';
import '../../../bloc/profileBloc/profile_event.dart';
import 'package:avatar_glow/avatar_glow.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistentBottomSheetCallBack;
  String editProfile="Edit Profile";
  bool onTapping=false;

  void initState() {
    super.initState();
    _showPersistentBottomSheetCallBack = _showBottomSheet;
  }

  File? imageFile;
  final imgPicker = ImagePicker();
  var imagePath = "", imagePathOnPickImage = "";
bool getTheImage = false;
  @override
  Widget build(BuildContext context) {
    double height  =  MediaQuery.of(context).size.height;
    double width  =  MediaQuery.of(context).size.width;

    void openGallery() async {
      var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = File(imgGallery!.path);
        imagePathOnPickImage = imageFile!.path;
        imagePath = "";
      });
      Navigator.of(context).pop();
      print("imagePath: $imagePathOnPickImage");
    }

    void openCamera() async {
      var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = File(imgCamera!.path);
        imagePathOnPickImage = imageFile!.path;
        imagePath = "";
      });
      Navigator.of(context).pop();
      print("imagePath: $imagePathOnPickImage");
    }

    Future<void> showOptionsDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(27.0))),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    GestureDetector(
                      child: const ListTile(
                        leading: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                        title: Text(
                          "Select from Camera",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        openCamera();
                      },
                    ),
                    GestureDetector(
                      child: const ListTile(
                        leading: Icon(
                          Icons.folder,
                          color: Colors.grey,
                        ),
                        title: Text(
                          "Select from Gallery",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        openGallery();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return  LayoutBuilder(
      builder: (context,constraints)
      {
       return Scaffold(
           backgroundColor: Colors.transparent,

         resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                margin: EdgeInsets.only(left: constraints.maxWidth*0.03,top: constraints.maxWidth*0.01),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            showModalBottomSheet<void>(
                                shape: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20))
                              ),
                              context: context,
                                builder: (BuildContext context) {
                                return Container(
                                  height: height * 0.5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children:   [
                                          GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                                },
                                              child: const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Icon(Icons.arrow_drop_down_sharp,size: 40,),
                                              )),
                                        ],
                                      ),
                                      Container(
                                      width: width*0.2,
                                      height: height *0.085,
                                        decoration:   BoxDecoration(
                                          color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.all(Radius.circular(15)),),
                                        child: Icon(Icons.photo,size: 50,),
                                      ),
                                      Padding(
                                        padding:   EdgeInsets.only(top: height* 0.02),
                                        child: const Text("Upload Profile Picture",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                                      ),
                                      Padding(
                                        padding:   EdgeInsets.only(top: height* 0.02),
                                        child: const Text("Select picture from device/camera",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  openGallery();
                                                  getTheImage = true;
                                               },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width /2.5,
                                                  height: height* 0.10,
                                                  decoration:   BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  child: Text("Select from device",style: const TextStyle(fontWeight: FontWeight.w700),),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  openCamera();
                                                  getTheImage = true;
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width /2.5,
                                                  height: height* 0.10,
                                                  decoration:   BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  child: const Text("Select from camera",style: TextStyle(fontWeight: FontWeight.w700),),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                }
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: constraints.maxWidth*0.3,
                                height: constraints.maxHeight*0.3,
                                  decoration:BoxDecoration(
                                      shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.5)
                                  ),
                                 child: Center(child: !getTheImage ?  Icon(Icons.person,size: constraints.maxHeight*0.1,color: Colors.blue,)
                                    :Center(
                                      child: Container(
                                          width: constraints.maxWidth*0.3,
                                          height: constraints.maxHeight*0.3,
                                          decoration:BoxDecoration(
                                              shape: BoxShape.circle,
                                            color: Colors.red,
                                            image: DecorationImage(
                                              image:  FileImage(imageFile!),
                                              fit: BoxFit.fill
                                            )
                                   ),
                                /*   child:Image(image: FileImage(File(imagePathOnPickImage)
                                   ),fit: BoxFit.contain,


                                   )*/
                                ),
                                    ),
                              ),),
                             !onTapping ? Positioned(
                                bottom: constraints.maxHeight*0.03,right: 5,
                                child: Padding(padding: EdgeInsets.all(5),
                                  child: Container(
                                    width: constraints.maxWidth *0.09,
                                    height:constraints.maxHeight* 0.09,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                    child: Center(
                                      child: Icon(Icons.edit,size: constraints.maxHeight*0.03,color: Colors.black,
                                  ),
                                    ),

                                ),
                              )
                              ) : Container()],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                // color: Colors.black,
                                margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04),
                                child: !onTapping ?
                                // Container(
                                //   child: TextFormField(
                                //     // onChanged: (email)=>context.read<SignUpBloc>().add(SignUpEmailChanged(email:email)),
                                //     // cursorColor: Colors.black,
                                //     decoration:
                                //     InputDecoration(
                                //         hintText: 'Name',
                                //         hintStyle: const TextStyle(fontWeight: FontWeight.bold,),
                                //          fillColor: Colors.black38,
                                //
                                //         filled: true,
                                //         focusedBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(10),
                                //           // borderSide: const BorderSide(
                                //           //     color: Colors.white,
                                //           //     style: BorderStyle.solid,
                                //           //     width: 3),
                                //         ),
                                //         enabledBorder:  OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(10),
                                //           // borderSide: const BorderSide(
                                //           //      color: Colors.white,
                                //           //     style: BorderStyle.solid,
                                //           //     width: 3),
                                //         ),
                                //         labelStyle: const TextStyle(color: Colors.black))  ,
                                //   ),
                                //
                                // )
                                nameContainer()
                                    : Material(
                                 color: Colors.transparent,


                                  child: TextFormField(
                                    // onChanged: (email)=>context.read<SignUpBloc>().add(SignUpEmailChanged(email:email)),
                                    cursorColor: Colors.black,
                                    decoration:
                                    InputDecoration(
                                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        enabled: false,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 3),
                                        ),
                                        enabledBorder:  OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 3),
                                        ),
                                        labelStyle: const TextStyle(color: Colors.black))  ,
                                  ),

                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: constraints.maxWidth,
                                // color: Colors.black,
                                margin: EdgeInsets.only(left: constraints.maxWidth*0.04,right: constraints.maxWidth*0.04),
                                child: !onTapping ? Container(
                                  // borderRadius: BorderRadius.circular(10),
                                  // elevation: 10.0,
                                  // shadowColor: Colors.black,
                                  child: writeContainer(),
                                  // child: TextFormField(
                                  //   // onChanged: (email)=>context.read<SignUpBloc>().add(SignUpEmailChanged(email:email)),
                                  //   cursorColor: Colors.black,
                                  //   decoration: InputDecoration(
                                  //       hintText: 'Write something about you and your brand',
                                  //       fillColor: Colors.white,
                                  //       filled: true,
                                  //       focusedBorder: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //         borderSide: const BorderSide(
                                  //             color: Colors.white,
                                  //             style: BorderStyle.solid,
                                  //             width: 3),
                                  //       ),
                                  //       enabledBorder: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //         borderSide: const BorderSide(
                                  //             color: Colors.white,
                                  //             style: BorderStyle.solid,
                                  //             width: 3),
                                  //       ),
                                  //       labelStyle: const TextStyle(color: Colors.black)),
                                  // ),

                                ) : Material(

                                  color: Colors.transparent,
                                  child: TextFormField(
                                    // onChanged: (email)=>context.read<SignUpBloc>().add(SignUpEmailChanged(email:email)),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      enabled: false,
                                        hintText: '',
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              style: BorderStyle.solid,
                                              width: 3),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 3),
                                        ),
                                        labelStyle: const TextStyle(color: Colors.black)),
                                  ),

                                ),
                              ) ,
                            ],
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(mounted)
                          {
                            onTapping=!onTapping;
                            if(onTapping)
                              {
                                editProfile="Edit Profile";
                              }
                            else
                              {
                                editProfile="Profile Preview ";
                              }
                          }
                        });

                      },
                      child: Container(
                        width: constraints.maxWidth*0.8,
                          margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            // boxShadow:const [
                            //   BoxShadow(
                            //     color: Colors.black,
                            //     blurRadius: 2.0,
                            //     spreadRadius: 0.0,
                            //     offset: Offset(2.0, 2.0,), // shadow direction: bottom right
                            //   )
                            // ],
                          ),
                        child: Padding(
                          padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                          child:  Text(editProfile,textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    onTapping?Container():Container(
                     // elevation: 1,
                       // shadowColor: Colors.black,
                     // borderRadius: BorderRadius.circular(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black38)
                      ),

                      child: Container(
                        margin: EdgeInsets.only(top: constraints.maxHeight*0.01,left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05),

                        width: constraints.maxWidth*0.8,
                        child: Column(
                          children: [
                            Container(
                                margin:EdgeInsets.only(top: constraints.maxHeight*0.02),
                                child: Text('There are no links in your profile.',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),fontWeight: FontWeight.bold),)),
                            const SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){
                                context.read<ProfileBloc>().add(AddLinkClicked());
                              },
                              child: AvatarGlow(
                                glowColor: Colors.blue,
                                endRadius: 80,
                                duration: Duration(milliseconds: 2500),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration: Duration(milliseconds:150 ),

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black38),

                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left:constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.03,bottom: constraints.maxHeight*0.03),
                                    child: Icon(Icons.add,size: 50,),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                margin:EdgeInsets.only(top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                                child: Text('Add link',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),)),
                          ],
                        ),
                      ),
                    )


                  ],
                ),
              ),
            )
        );
      },
    );
  }
  void _showBottomSheet() {
    setState(() {
      _showPersistentBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState!
        .showBottomSheet(
          (context) {
        // EN: Here you set up your BottomSheet with the widgets you want, on it you'll use the SnackBar.
        // PT-BR: Aqui você monta seu BottomSheet com os widgets que quiser, nele você utilizará o SnackBar.
        return Container(
          height: 200,
          color: Colors.blueGrey,
          child: Center(
            child: ElevatedButton(
              child: const Text('SNACKBAR'),
              onPressed: () {
                // EN: Any SnackBar in this context will appear above the BottomSheet, as desired.
                // PT-BR: Qualquer SnackBar neste contexto aparecerá acima do BottomSheet, como desejado.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('SNACKBAR! :)'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      },
    )
        .closed
        .whenComplete(
          () {
        if (mounted) {
          setState(
                () {
              _showPersistentBottomSheetCallBack = _showBottomSheet;
            },
          );
        }
      },
    );
  }
  _showBottomSheetDialog(BoxConstraints constraints, BuildContext context) {

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text

        return Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: constraints.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                          child: Text(
                            "Share Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveFlutter.of(context).fontSize(2.5)),
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                  ],
                ),

                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       width: constraints.maxWidth,
                //       color:Colors.yellow,
                //
                //         child: Text('Share Profile',textAlign: TextAlign.center,)),
                //     Spacer(),
                //     Expanded(
                //       child: Align(
                //           alignment: Alignment.topRight,
                //           child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)),
                //     ),
                //   ],
                // ),
              ),
            ),
             Container(
                 margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
                 child: Image.asset("assets/qr.png",height:constraints.maxHeight*0.08,width: constraints.maxWidth*0.15,fit: BoxFit.cover,)),

            GestureDetector(
              onTap: (){
                // const snackBar = SnackBar(
                //   content: Text('Copied to clipboard'),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.07),
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        print('he;;l');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Test'),
                          behavior: SnackBarBehavior.floating,
                        ));
                        // const snackBar = SnackBar(
                        //   behavior: SnackBarBehavior.floating,
                        //   content: Text('Copied to clipboard'),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Card(child: Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),

                        child: Icon(Icons.content_copy_outlined),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                      child: Text('tapitek/sudhanshu_juyal'),
                    )
                  ],
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.01),
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Card(child: Padding(
                    padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),

                    child: Icon(Icons.share_outlined),
                  )),
                  Padding(
                    padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                    child: Text('Share Profile',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                  )
                ],
              ),

            ),



          ],
        );
      },
    );
  }
  Widget nameContainer(){
    return Container(
       decoration: BoxDecoration(
         color: Colors.black12,
         borderRadius: BorderRadius.circular(10)
       ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,

              hintText: 'Name',

          ),
        ),
      )

    );
  }
  Widget writeContainer(){
    return Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,

              hintText: 'Write something about..',

            ),
          ),
        )

    );
  }
}
