
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:friends/home_page.dart';
import 'package:friends/posts/post_respository.dart';
import 'package:friends/profile/profile_repository.dart';
import 'package:friends/utils/shared_prefs.dart';
import 'package:provider/provider.dart';


import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Friends',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

            primaryColor: const Color(0xFF1c1c1c),

            accentColor: const Color(0XFFf94c84),
            fontFamily: 'Montserrat'



        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProfileRepository.instance(),),
            ChangeNotifierProvider(create: (_) => PostRepository.instance(),),
            ChangeNotifierProvider(create: (_) => SharedPrefsUtils.instance())


          ],
          child: HomePage(),

        )
    );
  }
}

