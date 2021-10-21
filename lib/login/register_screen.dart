
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/size_config.dart';
import 'package:friends/utils/validations.dart';
import 'package:provider/provider.dart';
import 'login_repository.dart';
import 'otp_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: LoginRepository.instance(),
        child: Consumer(builder: (_,LoginRepository loginRepo,child){
         return Scaffold(
           body:  Stack(
             children: [
               SizedBox(

                 height: SizeConfig.screenHeight,
                 child: Image.asset('assets/images/bg.jpg',fit: BoxFit.cover,),


               ),
             Center(
               child: ClipRect(
                 child: BackdropFilter(
                   filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                   child: Container(
                     height:  SizeConfig.screenHeight!/1.4,
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
                             loginRepo.googleLoading? Container(
                               padding: EdgeInsets.all(10),
                               margin: EdgeInsets.all(20),
                               child:  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeColor.primary),)),
                             ) :  InkWell(
                               onTap: (){
                                 loginRepo.googleSignIn(context);

                               },
                               child: Container(


                                 padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                                 decoration:  BoxDecoration(

                                   gradient: LinearGradient(
                                       begin: Alignment.topLeft,
                                       end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                       colors: [ThemeColor.primary,ThemeColor.secondary], // red to yellow
                                       tileMode: TileMode.clamp// repeats the gradient over the canvas
                                   ),
                                   borderRadius: BorderRadius.all(Radius.circular(10.0))),

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
                                       }, child: Text("log in",style: TextStyle(fontWeight:FontWeight.bold, foreground: Paint()..shader = ThemeColor.linearGradient),))
                                     ],
                                   )

                                 ],
                               ),
                             )),
                       ],
                     ),
                   ),
                 ),
               ),
             )
             ],
           ),
         );
        },),

    );
  }
}
