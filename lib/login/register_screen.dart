
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/models/User.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/shared_prefs.dart';
import 'package:friends/utils/size_config.dart';
import 'package:friends/utils/validations.dart';
import 'package:provider/provider.dart';

import '../create_profile_screen.dart';
import '../edit_profile_screen.dart';
import '../profile_repository.dart';
import 'login_repository.dart';
import 'login_screen.dart';
import 'otp_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.bgColor,

      body: ChangeNotifierProvider.value(value: LoginRepository.instance(),
        child: Consumer(builder: (_,LoginRepository loginRepo,child){
          return SingleChildScrollView(

            child: Container(
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      loginRepo.googleLoading? Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(20),
                        child: const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeColor.primary),)),
                      ) :  InkWell(
                        onTap: (){
                          loginRepo.googleSignIn(context);

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
                                controller: loginRepo.usernameController,
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
                                controller: loginRepo.emailController,

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
                                  hintText: 'Please enter your email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) =>  Validations.validateEmail(value!),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: loginRepo.passwordController,
                                obscureText: true,
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
                                  hintText: 'Please enter a password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) =>  Validations.validatePassword(value!)
                              ),
                            ),


                            loginRepo.loading? Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(20),
                              child: Center(child: CircularProgressIndicator()),
                            ) :  Container(
                              margin: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth,
                              height: 50.toHeight,
                              padding: EdgeInsets.all(10),
                              decoration: const BoxDecoration(
color: ThemeColor.primary,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: TextButton(child: const Text("Register",style: TextStyle(color: Colors.white,fontSize: 20),),onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                 loginRepo.register(context).then((bool? value){

                                    if(loginRepo.isSignUpComplete) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return OtpScreen(username: loginRepo.usernameController.text.trim(),
                                          password: loginRepo.passwordController.text.trim(),
                                          email:loginRepo.emailController.text.trim(),);
                                      }));
                                    }else{

                                    }


                                 });

                                }
                              },),
                            ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Already have an account ?",style: TextStyle(color: Colors.white),),
                               TextButton(onPressed: (){
                                 Navigator.of(context).pop();
                               }, child: Text("log in",style: TextStyle(fontWeight:FontWeight.bold, color: ThemeColor.primary),))
                             ],
                           )

                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        },),
      )
    );
  }
}
