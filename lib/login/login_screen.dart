import 'dart:async';
import 'dart:ui';


import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/profile/create_profile_screen.dart';
import 'package:friends/profile/edit_profile_screen.dart';
import 'package:friends/login/register_screen.dart';
import 'package:friends/models/ModelProvider.dart';
import 'package:friends/profile/profile_repository.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/shared_prefs.dart';
import 'package:friends/utils/size_config.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:provider/provider.dart';

import '../amplifyconfiguration.dart';
import 'login_repository.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in here");


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(create: (_)=> LoginRepository.instance(),
    child: Consumer(builder: (_,LoginRepository loginRep,child){
      return Scaffold(

          body:
             Stack(
               children: [
                 SizedBox(

                  height: SizeConfig.screenHeight,
               child: Image.asset('assets/images/bg.jpg',fit: BoxFit.cover,),


            ),
                 Center(
                   child: ClipRect(
                     child: BackdropFilter(
                       filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                       child:  Container(
                         height:  SizeConfig.screenHeight!/1.6,
                         margin: EdgeInsets.symmetric(horizontal: 20),
                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                         decoration: BoxDecoration(
                           border:Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
                           borderRadius: BorderRadius.circular(30),
                             color: ThemeColor.primary.withOpacity(0.2)
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [

                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 loginRep.googleLoading? Container(
                                   padding: EdgeInsets.all(10),
                                   margin: EdgeInsets.all(20),
                                   child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeColor.primary),)),
                                 ) :  InkWell(
                                   onTap: (){
                                     loginRep.googleSignIn(context);

                                   },
                                   child: Container(



                                     padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                                     decoration: const BoxDecoration(

                                       gradient: LinearGradient(
                                           begin: Alignment.topLeft,
                                           end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                           colors: [ThemeColor.primary,ThemeColor.secondary], // red to yellow
                                           tileMode: TileMode.clamp// repeats the gradient over the canvas
                                       ),
                                       borderRadius: BorderRadius.all(Radius.circular(10.0)),

                                     ),
                                     child: SvgPicture.asset(
                                       'assets/svg/google.svg',

                                       height: 24,
                                       width: 24,
                                       fit: BoxFit.cover,
                                       color: Colors.white,

                                     ),




                                   ),
                                 ),
                               ],
                             ),

                             Form(
                                 key: _formKey,
                                 child: Container(


                                   child: Column(
                                     children: <Widget>[

                                       Container(

                                         padding: EdgeInsets.symmetric(vertical: 20),
                                         child: TextFormField(

                                           controller: loginRep.usernameController,
                                           style: TextStyle(color: ThemeColor.white),
                                           decoration: InputDecoration(
                                             fillColor: Colors.red,

                                             prefixIcon: Icon(Icons.account_circle,color:Colors.white),

                                             border: OutlineInputBorder(

                                               borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),
                                             enabledBorder: OutlineInputBorder(

                                               borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),
                                             focusedBorder: OutlineInputBorder(
                                               borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),
                                             disabledBorder: OutlineInputBorder(
                                               borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),

                                             hintText: "Please enter Username",
                                             hintStyle: TextStyle(
                                               color: Colors.grey[600],
                                               fontSize: 15.toFont,
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a username';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),

                                       Container(

                                         child: TextFormField(
                                           controller: loginRep.passwordController,
                                           obscureText: true,
                                           style: TextStyle(color: ThemeColor.white),
                                           decoration: InputDecoration(
                                             prefixIcon: Icon(Icons.vpn_key,color:Colors.white),
                                             border: OutlineInputBorder(
                                               borderSide: BorderSide(color:(Colors.grey[700])!, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),
                                             enabledBorder: OutlineInputBorder(
                                               borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),
                                             focusedBorder: OutlineInputBorder(

                                               borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),
                                             disabledBorder: OutlineInputBorder(
                                               borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                               borderRadius: BorderRadius.all(
                                                 Radius.circular(10.toWidth),
                                               ),
                                             ),

                                             hintText: 'Please enter a password',
                                             hintStyle: TextStyle(
                                               color: Colors.grey[600],
                                               fontSize: 15.toFont,
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a password';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),

                                       loginRep.loading? Container(
                                         padding: EdgeInsets.all(10),
                                         margin: EdgeInsets.all(20),
                                         child: const Center(child: CircularProgressIndicator()),
                                       ) :   Container(
                                         margin: const EdgeInsets.all(20),
                                         width: SizeConfig.screenWidth,
                                         height: 50.toHeight,
                                         padding: const EdgeInsets.all(10),
                                         decoration: const BoxDecoration(

                                           gradient: LinearGradient(
                                             begin: Alignment.topLeft,
                                             end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                             colors: [ThemeColor.primary,ThemeColor.secondary], // red to yellow
                                             tileMode: TileMode.clamp// repeats the gradient over the canvas
                                           ),
                                           borderRadius: BorderRadius.all(Radius.circular(10.0)),

                                         ),
                                         child:TextButton(

                                           onPressed: () {
                                             if (_formKey.currentState!.validate()) {
                                               loginRep.login().then((bool isSignedIn){
                                                 if(isSignedIn) {
                                                   print("signed In");
                                                   loginRep.retrieveCurrentUser().then((AuthUser authUser) {

                                                     Navigator.push(context, MaterialPageRoute(builder: (context){
                                                       // return RegisterScreen();
                                                       //return LoginScreen();

                                                       return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                                                         child: EditProfileScreen(authUser.userId),);


                                                     }));



                                                   });




                                                 }
                                               });

                                             }
                                           },
                                           child:const Text("Log In",style: TextStyle(fontSize: 20,color: Colors.white),
                                           ),
                                         ),
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Text("Don't have an account ?",style: TextStyle(color:ThemeColor.white),),
                                           TextButton(onPressed: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context){

                                               return RegisterScreen();


                                             }));
                                           }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,foreground: Paint()..shader = ThemeColor.linearGradient),)),
                                         ],
                                       )





                                     ],
                                   ),
                                 )),
                           ],
                         ),
                       ) ,
                     ),
                   ),
                 )

               ],
             ),
          );

    },),);
  }
}
