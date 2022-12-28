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
          return
            BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontSize:ResponsiveFlutter.of(context).fontSize(1.0),fontWeight: FontWeight.bold),
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
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                SizedBox(
                  width: 100,
                  child: Center(
                    child: Icon(
                    Icons.near_me_outlined,
                    size: 40,
                    color: Colors.black, //<-- SEE HERE
              ),
                  ),
                ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: Colors.black, //<-- SEE HERE
                  ),

                ],
              ),
            ),


            Text("Pick a direct link ",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
            Container(

              width: width *0.7,
              height: height*0.06,
              
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30)
              ),
              

            ),
            Text(
               "Whe you tap someone phone \n this link will be opened instead of your full profile ",textAlign: TextAlign.center

            )

          ],
      );
    },
  );
}