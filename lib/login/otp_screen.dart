
import 'package:flutter/material.dart';
import 'package:friends/profile/create_profile_screen.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/validations.dart';
import 'package:provider/provider.dart';
import 'package:friends/utils/size_config.dart';
import '../profile/profile_repository.dart';
import 'login_repository.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({required this.username,required this.password,required this.email});
  final String username;
  final String password;
  final String email;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.bgColor,
        appBar: AppBar(
          title: const Text("OTP Screen"),
        ),
        body: ChangeNotifierProvider.value(
            value: LoginRepository.instance(),
            child: Consumer(builder: (_, LoginRepository loginRepo, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                  controller: loginRepo.codeController,
                                  obscureText: true,
                                  style: TextStyle(color: ThemeColor.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeColor.primary,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:(Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.toWidth,
                                      vertical: 20.toHeight,
                                    ),
                                    hintText: 'Please enter OTP Code',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15.toFont,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  validator: (value) =>
                                      Validations.validateOTP(value!)),
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
                              color:ThemeColor.primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: TextButton(
                                child: Text("Confirm Account",style: TextStyle(fontSize: 20,color: Colors.white),),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginRepo.confirmUser(widget.username,widget.password,widget.email).then((bool value) {
                                      if(value){

                                       // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                                            child:  CreateProfileScreen(),
                                          );

                                        }));

                                      }else{
                                        print("couldn't Sign User In");
                                      }
                                    });
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              );
            })));
  }
}
