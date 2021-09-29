import 'dart:async';


import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/create_profile_screen.dart';
import 'package:friends/edit_profile_screen.dart';
import 'package:friends/login/register_screen.dart';
import 'package:friends/models/ModelProvider.dart';
import 'package:friends/profile_repository.dart';
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

          body: SingleChildScrollView(
            child: Container(
              color: ThemeColor.bgColor,
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
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



                          padding: EdgeInsets.symmetric(horizontal: 90,vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color:ThemeColor.primary,width: 1)
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
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.toWidth,
                                    vertical: 20.toHeight,
                                  ),
                                  hintText: "Please enter Username",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
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
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: loginRep.passwordController,
                                obscureText: true,
                                style: TextStyle(color: ThemeColor.white),
                                decoration: InputDecoration(
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
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.toWidth,
                                    vertical: 20.toHeight,
                                  ),
                                  hintText: 'Please enter a password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
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

                                  color: ThemeColor.primary,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),

                              ),
                              child: TextButton(

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
                                }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,color: ThemeColor.primary),)),
                              ],
                            )





                          ],
                        ),
                      )),
                ],
              ),
            ),
          )
      );
    },),);
  }
}
