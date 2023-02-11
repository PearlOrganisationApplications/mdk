import 'package:badges/badges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mdk/bloc/HomepageBloc/homepage_event.dart';
import 'package:mdk/screens/homepage/components/device_compatablity.dart';
import 'package:mdk/screens/homepage/components/homescreen_page.dart';
import 'package:mdk/screens/homepage/components/question.dart';
import 'package:mdk/screens/homepage/components/verify_token.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/HomepageBloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/screens/homepage/components/erasetag.dart';
import '../../bloc/HomepageBloc/homepage_state.dart';
import 'components/appinfo.dart';
import 'components/history.dart';
import 'components/login.dart';
import 'components/read_tag.dart';
import 'components/social_link.dart';
import 'components/splash_screen.dart';
import 'components/write_data.dart';
import 'components/write_detail.dart';
import 'components/write_tag.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomePage extends StatelessWidget
{
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) =>  HomePage());
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return LayoutBuilder(
      builder: (context,constraints)
      {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
               return SafeArea(

                child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                Scaffold.of(context).openDrawer();
                },
                ),
                );

              },
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  _oqshowBottomSheetDialog(constraints,context);
                },
                child: Container(
                    margin: EdgeInsets.only(right: constraints.maxWidth*0.03),
                    child:  Lottie.asset("assets/animation/qricon.json")
                    // Icon(Icons.qr_code_scanner_outlined,color: Colors.white,),
              ))
            ],
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xFF3366FF),
                      Color(0xFF00CCFF),

                    ]),

              ),
            ),
            title:   Text(
              'Tapitek',style: GoogleFonts.montserrat(fontWeight: FontWeight.w900,fontSize: 25),
            ),
            // backgroundColor:  Colors.blue,
          ),
          drawer: Drawer(

            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                 Container(
                   height: constraints.maxHeight*0.15,
                   child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/user.png",),
                        SizedBox(width: 20,),
                        Text('sudhanshu_juyal',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),)
                      ],
                    ),
                ),
                 ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                       Navigator.pop(context);
                      _showCompleteProfileDialog(constraints, context);
                    },
                    child: AvatarGlow(
                      glowColor: Colors.blue,
                      endRadius: 50,
                      duration: Duration(milliseconds: 2500),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds:150 ),
                      child: Container(
                        padding: EdgeInsets.only(top: constraints.maxHeight*0.02,left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,bottom:  constraints.maxHeight*0.02),
                        color: Colors.white,
                        // margin: EdgeInsets.only(left: constraints.maxWidth*0.05),
                        child: Row(
                          children: [
                            Icon(
                              Icons.supervised_user_circle_outlined,
                            ),
                            SizedBox(width: 10,),
                            Text('Complete Profile',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                          ],
                        )
                      ),
                    ),
                  ),
                Container(
                    padding: EdgeInsets.only(top: constraints.maxHeight*0.02,left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,bottom:  constraints.maxHeight*0.02),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.03),
                    child: Column(
                      children: [

                        const SizedBox(height: 10,),
                        Row(
                          children:   [
                            Icon(Icons.supervised_user_circle_outlined,),
                            SizedBox(width: 10,),
                            Text('My Connection',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            context.read<HomePageBloc>().add(HomePageInitialEvent());
                          },
                          child: Row(
                            children:   [
                              Icon(Icons.home,),
                              SizedBox(width: 10,),
                              Text('Homepage',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                                 context.read<HomePageBloc>().add(DeviceCompatibilityEvent());
                          },
                          child: Row(
                            children:  [
                              Icon(
                                Icons.smartphone_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Device compatibility',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),


                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);

                            context.read<HomePageBloc>().add(QuestionEvent());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.help_outline_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Help',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),


                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            __showSettingDialog( context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Settings',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),


                        GestureDetector(
                          onTap: ()async{
                            Navigator.pop(context);
                            final prefs = await SharedPreferences.getInstance();
                            var loginType = prefs.getString("LoginType");
                            if(loginType == "Facebook"){
                              prefs.clear();
                            }else if(loginType == "Google"){
                              prefs.clear();
                            }else{
                              prefs.clear();
                            }
                            context.read<HomePageBloc>().add(LoginEvent());
                          },
                          child: Row(
                            children:   [
                              Icon(
                                Icons.logout_outlined,
                              ),
                              SizedBox(width: 10,),
                              Text('Logout',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    )
                ),

              ],
            ),
          ),
          body: BlocBuilder<HomePageBloc,HomePageState>(
              builder: (context, state)
              {
                if(state is SplashState)
                {
                  return const Splash();
                }
                else if(state is VerifyTokenState)
                {
                  return const VerifyToken();
                }
                else if(state is LoginState)
                {
                  return const Login();
                }
                else if(state is HomePageInitialState)
                {
                  return const HomeScreenPage();
                }
                else if(state is WriteDataState)
                {
                  return const WriteData();
                }
                else if(state is WriteTagState)
                {
                  return const WriteTag();
                }
                else if(state is WriteDetailState)
                {
                  return WriteDetail(appTitle:state.appTitle);
                }
                else if(state is ReadTagState)
                {
                  return const ReadTag();
                }
                else if(state is HistoryState)
                {
                  return const History();
                }
                else if(state is EraseState)
                {
                  return const EraseTag();
                }
                else if(state is AppInfoState)
                {
                  return const AppInfo();
                }
                else if(state is SocialLinkState)
                {
                  return const SocialLink();
                }
                else if(state is QuestionState)
                  {
                    return Questions();
                  }
                else if(state is DeviceCompatibilityState)
                  {
                    return DeviceCompatibility();
                  }
                return const WriteTag();
              }),

        );
      },

    );

  }

  // _showBottomSheetDialog(BoxConstraints constraints, BuildContext context) {
  //   final GlobalKey<ScaffoldState> _modelScaffoldKey = GlobalKey<ScaffoldState>();
  //   return showModalBottomSheet(
  //   shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.only( topLeft: Radius.circular(13),topRight: Radius.circular(13)),
  //   ),
  //
  //     backgroundColor: Colors.blue,
  //
  //
  //     context: context,
  //     builder: (context1) {
  //       // we set up a container inside which
  //       // we create center column and display text
  //
  //       return Scaffold(
  //         extendBody: false,
  //         key: _modelScaffoldKey,
  //         resizeToAvoidBottomInset: true,
  //         body: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             GestureDetector(
  //               onTap: (){
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: constraints.maxWidth,
  //
  //
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //
  //                   //mainAxisSize: MainAxisSize.max,
  //                   children: <Widget>[
  //                     Center(
  //                       child: Container(
  //                         margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
  //                         child: Text(
  //                           "Share Profile",
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveFlutter.of(context).fontSize(3.5)),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(right: 10),
  //                       child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),),
  //                     )
  //                   ],
  //                 ),
  //
  //               ),
  //             ),
  //             Container(
  //                 margin: EdgeInsets.only(top: constraints.maxHeight*0.05),
  //                 child: Image.asset("assets/qr.png",height:constraints.maxHeight*0.15,width: constraints.maxWidth*0.35,fit: BoxFit.cover,color: Colors.black,)),
  //             GestureDetector(
  //               onTap: (){
  //                 //
  //                 //  var snackBar = SnackBar(
  //                 //   content: Text('Copied to clipboard'),
  //                 // );
  //                 //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.07),
  //                 width: constraints.maxWidth,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: Colors.white,
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     GestureDetector(
  //                       onTap: (){
  //
  //                         // _modelScaffoldKey.currentState?.showSnackBar(  const SnackBar(
  //                         //   backgroundColor: Colors.green,
  //                         //   elevation: 0,
  //                         //
  //                         //   content: Text("Copied to clipboard"),
  //                         //   behavior: SnackBarBehavior.floating,
  //                         // )
  //                         // );
  //
  //                       },
  //                       child: Card(
  //                           child: Padding(
  //                         padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
  //
  //                         child: Icon(Icons.content_copy_outlined),
  //                       )),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
  //                       child: Text('tapitek/sudhanshu_juyal'),
  //                     )
  //                   ],
  //                 ),
  //
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.01),
  //               width: constraints.maxWidth,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.white,
  //               ),
  //               child: Row(
  //                 children: [
  //                   Card(child: Padding(
  //                     padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
  //
  //                     child: Icon(Icons.share_outlined),
  //                   )),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
  //                     child: Text('Share Profile',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
  //                   )
  //                 ],
  //               ),
  //
  //             ),
  //             Container(
  //               margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.01),
  //               width: constraints.maxWidth *0.08,
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  _oqshowBottomSheetDialog(BoxConstraints constraints,BuildContext context){


    return showModalBottomSheet<void>(
      backgroundColor: const Color(0xfff1f1f1),
      // backgroundColor: Colors.white30,
      // context and builder are
      // required properties in this widget
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0)
        ),
      ),
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text

        return Padding(
          padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Share profile",style:GoogleFonts.montserrat(fontSize: 20,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold) ,),
                 SizedBox(height: 20,),
                Container(
                  child:  Column(
                    children: [
                      Image.asset("assets/qr.png",
                        height: 200,
                        width: 200,),
                      SizedBox(height: 20,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black12
                            )
                        ),
                        child:  Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (){


                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),

                                                  child: Icon(Icons.content_copy_outlined),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                                                child: Text('tapitek/sudhanshu_juyal',style: GoogleFonts.montserrat(),),
                                              )
                                            ],
                                          ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black12
                            )
                        ),
                        child:
                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: constraints.maxWidth*0.03,right: constraints.maxWidth*0.03,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),

                                              child: Icon(Icons.share_outlined),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                                              child: Text('Share Profile',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                                            )
                                          ],
                                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("if you want to change your link \n click here to change username",style: GoogleFonts.montserrat(),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );



  }
  _showCompleteProfileDialog(BoxConstraints constraints, BuildContext context) {

    return showModalBottomSheet<void>(
       backgroundColor: const Color(0xfff1f1f1),
      // backgroundColor: Colors.white30,
      // context and builder are
      // required properties in this widget
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0)
        ),
      ),
      builder: (context1) {
        // we set up a container inside which
        // we create center column and display text

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,),
                    width: constraints.maxWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Complete your profile",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: ResponsiveFlutter.of(context).fontSize(3.0)),
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(5.8),)
                      ],
                    ),
                  ),

                ),
                profileContainer(constraints,context,'Verify Email address','Check your inbox for  juyalsudhanshu6@gmail.com'),
                profileContainer(constraints,context,'Add your first link','Tap here to add your social media channel \nor contact information to your tapni profile'),
                profileContainer(constraints,context,'Add a profile picture','Tap here to upload your profile picture'),
                profileContainer(constraints,context,'Activate your tapni','Tap here to activate your Tapni NFC tag'),

              ],
            ),
          ),
        );
      },
    );
  }


 Widget profileContainer(BoxConstraints constraints,BuildContext context,String title,String subTitle)
 {
   return GestureDetector(
     onTap: (){

     },
     child: Container(
       margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.05),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
       ),
       child: Padding(
         padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:
               [
                 Text(title,style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),color: Colors.black,fontWeight: FontWeight.bold),),
                 Container(
                   decoration: const BoxDecoration(
                       shape: BoxShape.circle,
                       color: Colors.grey
                   ),
                   child: Padding(
                     padding:  EdgeInsets.only(left: constraints.maxWidth*0.01,right: constraints.maxWidth*0.01,top: constraints.maxHeight*0.01,bottom: constraints.maxHeight*0.01),
                     child: const Icon(Icons.done),
                   ),
                 )
               ],
             ),
             Container(

                 child: Text(subTitle,style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),color: Colors.black),textAlign: TextAlign.start,)),

           ],
         ),
       ),
     ),
   );
 }
  __showChangeUsernameDialog(BoxConstraints constraints, BuildContext context) {

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
                            child:const Icon(Icons.perm_identity_outlined,color: Colors.black,size: 50,)

                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                  ],
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.05),
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10.0,
                  shadowColor: Colors.black,
                  child: TextFormField(
                    initialValue: 'sudhanshu_juyal',
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: 'Link Text',
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
                        labelStyle:   GoogleFonts.montserrat(color: Colors.black)),
                  )
              ),
            ),
            SizedBox(height: 10,),
            Text('Enter your new username',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
            GestureDetector(
              onTap: (){
              },
              child: Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.07),
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                      child: Text('Update username',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    )
                  ],
                ),

              ),
            ),
          ],
        );
      },
    );
  }
  __showChangePasswordDialog(BoxConstraints constraints, BuildContext context) {

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
        return SingleChildScrollView(
          child: Column(
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
                              child:const Icon(Icons.settings,color: Colors.black,size: 50,)

                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
                    ],
                  ),

                ),
              ),
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.05),
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(


                          hintText: 'Current Password',
                          fillColor: Colors.white,
                          suffixStyle: GoogleFonts.montserrat(),
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
                          labelStyle:   GoogleFonts.montserrat(color: Colors.black)),
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Text('Enter your new current password',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.02),
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(


                          hintText: 'New password',
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
                          labelStyle:   GoogleFonts.montserrat(color: Colors.black)),
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Text('Enter your new password',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
              Container(
                margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.02),
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(


                          hintText: 'Enter your new password again',
                          fillColor: Colors.white,
                          suffixStyle: GoogleFonts.montserrat(),
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
                          labelStyle: GoogleFonts.montserrat(color: Colors.black)),
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Text('Enter your new password again',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.09,right: constraints.maxWidth*0.09,top: constraints.maxHeight*0.02),
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.02,bottom: constraints.maxHeight*0.02),
                        child: Text('Password update',style: GoogleFonts.montserrat(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      )
                    ],
                  ),

                ),
              ),
              const SizedBox(height: 40,),
            ],
          ),
        );
      },
    );
  }
  __showSettingDialog(  BuildContext context) {
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
        return Column(
          children: [
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
                    Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,size: ResponsiveFlutter.of(context).fontSize(4.8),)
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
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10.0,
                  shadowColor: Colors.black,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: 'Activation Code',
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
                        labelStyle:   GoogleFonts.montserrat(color: Colors.black)),
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
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.01),
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
        );
      },
    );
  }


}
