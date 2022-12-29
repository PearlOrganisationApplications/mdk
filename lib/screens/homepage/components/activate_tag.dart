import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/bottomNavigationCubit/navigation_cubit.dart';
import '../../../data/navbar_item.dart';

class ActivateTag extends StatefulWidget {
  const ActivateTag({Key? key,  }) : super(key: key);

  @override
  State<ActivateTag> createState() => _ActivateTagState();
}

class _ActivateTagState extends State<ActivateTag> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints)
      {
        return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight*0.03),
                  width: constraints.maxWidth,

                    child: Text('Tapitek tags',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(2.0),fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.03),
                    width: constraints.maxWidth,

                    child: Text('There are no tags connected to your profile. \n Connect one now!',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontWeight: FontWeight.w400),textAlign: TextAlign.center,)),

              GestureDetector(
                  onTap: (){
                    __showSettingDialog( context);

                  },
                  child: Lottie.asset("assets/animation/loader.json")),


                  //Image.asset("assets/circular_loading.png",height: constraints.maxHeight*0.20,width: constraints.maxWidth*0.24,)),
                GestureDetector(
                    onTap: (){
                    },
                    child: Text('Activate Tag',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),))

              ],
            )
        );
      },
    );

  }

  __showSettingDialog(  BuildContext context,) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // context and builder are
      // required properties in this widget
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0)
        ),
      ),
      context: context,
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 300),
                child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8)),
              ) ,
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                              margin: EdgeInsets.only(top: height*0.06),
                              child:const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.document_scanner_outlined,color: Colors.black,size: 120,),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  // __showChangeUsernameDialog(constraints,context);
                  // const snackBar = SnackBar(
                  //   content: Text('Copied to clipboard'),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height*0.02,bottom: height*0.02),
                      child: Container(
                          child: Text('Scan Qr Code',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),textAlign: TextAlign.center,)
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width*0.15,right:width*0.15,top:height*0.05),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: 'Activation Code',
                          suffixStyle: GoogleFonts.montserrat(),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.white,
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
                          labelStyle:  GoogleFonts.montserrat(color: Colors.black)),
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Text('Enter the activation code',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  // __showChangePasswordDialog(constraints,context);
                  // __showChangePasswordDialog(constraints,context);

                  // const snackBar = SnackBar(
                  //   content: Text('Copied to clipboard'),
                  // );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.01,bottom: height*0.02),
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.02,bottom: height*0.02),
                        child: Text('Activate tag',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
