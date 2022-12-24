import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdk/screens/homepage/components/homepage_initial.dart';
import 'package:mdk/screens/homepage/components/profile.dart';
import 'package:mdk/screens/profile/profile_page.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../bloc/bottomNavigationCubit/navigation_cubit.dart';
import '../../../bloc/bottomNavigationCubit/navigation_state.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';
import '../../../data/navbar_item.dart';
import '../home_page.dart';
import 'activate_tag.dart';
class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider(create: (context)=>NavigationCubit(),
          child: const Scaffold(
            body: BottomScreenPage(),
          )

      ) ,
    );
  }
}

class BottomScreenPage extends StatefulWidget {
  const BottomScreenPage({Key? key}) : super(key: key);

  @override
  State<BottomScreenPage> createState() => _BottomScreenPageState();
}

class _BottomScreenPageState extends State<BottomScreenPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: BlocBuilder<NavigationCubit,NavigationState>(
        builder: (context,state)
        {
          return BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontSize:ResponsiveFlutter.of(context).fontSize(1.3),fontWeight: FontWeight.bold),
            backgroundColor: Colors.black,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.shifting,
            showUnselectedLabels: false,
            currentIndex: state.index,

            items:   const [

              BottomNavigationBarItem(
                backgroundColor:Colors.white,
                activeIcon:  Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                icon:  Icon(
                  Icons.home,
                  color: Colors.black,
                ),

                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor:Colors.white,
                activeIcon:  Icon(
                  Icons.pending_outlined,
                  color: Colors.blue,
                ),
                icon:  Icon(
                  Icons.pending_outlined,
                  color: Colors.black,
                ),


                label: 'Activate Tag',
              ),
              BottomNavigationBarItem(
                backgroundColor:Colors.white,
                activeIcon:  Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                icon:  Icon(
                  Icons.person,
                  color: Colors.black,
                ),

                label: 'Profile',
              ),

            ],
            onTap: (index) {
              if (index == 0)
              {
                BlocProvider.of<NavigationCubit>(context).getNavbarItem(NavbarItem.home);
              }
              else if (index == 1)
              {

              BlocProvider.of<NavigationCubit>(context).getNavbarItem(NavbarItem.activateTag);
              showSettingDialog(context);
              }
              else if (index == 2)
              {

               BlocProvider.of<NavigationCubit>(context).getNavbarItem(NavbarItem.profile);
              }

            },
          );
        },

      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state.navBarItem == NavbarItem.home) {
              return  BlocProvider(
                  create: (_) => ProfileBloc(
                  ),
                  child:const ProfilePage());

            }
            if (state.navBarItem == NavbarItem.activateTag) {
              return const  ActivateTag();
            }

            else if (state.navBarItem == NavbarItem.profile)
            {
              return  const HomePageInitial();
            }

            return Container();
          }),
    );
  }
}
showSettingDialog(  BuildContext context,) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

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
                      child: Text('Scan Qr Code',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),textAlign: TextAlign.center,)
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
                      labelStyle: const TextStyle(color: Colors.black)),
                )
            ),
          ),
          const SizedBox(height: 10,),

          Text('Enter the activation code',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),textAlign: TextAlign.center,),
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
                    child: Text('Activate tag',style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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