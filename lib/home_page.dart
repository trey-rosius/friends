import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:friends/posts/post_item.dart';
import 'package:friends/posts/post_respository.dart';
import 'package:friends/profile/profile_repository.dart';
import 'package:friends/profile/profile_screen.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/shared_prefs.dart';
import 'package:friends/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';
import 'login/login_screen.dart';
import 'models/ModelProvider.dart';
import 'models/Post.dart';
import 'nav/fab_bottom_app_bar.dart';

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String? userId;
 List<Post> _posts = [];

 Future<List<Post>>getPost(postRepo) async{
  return  _posts = await postRepo.queryAllPosts();
 }
 int count = 0;
late StreamSubscription postStream;
Future<void> _initializeApp() async{
  await _configureAmplify();
}

final AmplifyDataStore _amplifyDataStore =  AmplifyDataStore(modelProvider: ModelProvider.instance,);
Future<void> _configureAmplify() async {

  try{


    await Amplify.addPlugins([
      _amplifyDataStore,
      AmplifyAuthCognito(),
      AmplifyAPI(),
      AmplifyStorageS3()
    ]);

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);

    var postRepo = context.read<PostRepository>();
    if(Amplify.isConfigured) {
      postRepo.queryAllPosts().then((value) {
        postRepo.posts = value;
        print("something posts "+value.toString());

      });
      postStream = Amplify.DataStore.observe(Post.classType).listen((event) {

        if(postRepo.posts[0].id != event.item.id){

          postRepo.posts.insert(0, event.item);
          print('Received event of type ' + event.eventType.toString());
          print('Received post ' + event.item.toString());

        }





      });



    }else{
      print("Amplify not configured");
    }

  } catch(e) {
    print('an error occured during amplify configuration: $e');



  }


}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeApp();
      var sharedPrefs = context.read<SharedPrefsUtils>();



    sharedPrefs.getUserId().then((value){
      if(value == null){
        userId = null;
      }else{
        setState(() {
          userId = value;
        });
        print("userid is"+userId!);

      }
    });



    }




  int _selectedTabIndex = 0;

  void _selectedTab(int index) {
    print("Selected Index"+index.toString());
    if(index == 2)
    {

    }
    setState(() {
      _selectedTabIndex = index;

      print("Selected Index"+_selectedTabIndex.toString());
    });
  }


@override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
    postStream.cancel();

  }






  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var postRepo = context.read<PostRepository>();
    var sharedPrefs = context.watch<SharedPrefsUtils>();


    var profileRepo = context.watch<ProfileRepository>();
    return userId ==null ?LoginScreen() :


    Scaffold(
      backgroundColor: ThemeColor.black,
      appBar: AppBar(
       elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Friends",
          style: TextStyle(fontSize: 20,
              fontFamily: 'SeymourOne',

              foreground: Paint()..shader = ThemeColor.linearGradient),),
        actions: [
          IconButton(
            color: Colors.white,
              icon: Icon(Icons.login), onPressed: (){
            profileRepo.signOut().then((bool signOut){
             sharedPrefs.deleteAllKeys();
              if(signOut){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }else{
                print("couldn't sign out");
              }
            });
          })
        ],
      ),
      body:   IndexedStack(
        index:_selectedTabIndex ,
        children: [


          postRepo.posts.isNotEmpty ?ListView.builder(


            itemBuilder: (context,index){
              return PostItem(userId!,postRepo.posts[index]);
            },itemCount: postRepo.posts.length,) : Container(child: Text("No posts available"),),




          ProfileScreen(userId!),
          ProfileScreen(userId!),
          ProfileScreen(userId!),
        ],),


      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'frds',
        color: Colors.grey,
        selectedColor: ThemeColor.primary,

        onTabSelected: _selectedTab,
        userId: userId!,


        items: [
          FABBottomAppBarItem(iconName:'assets/svg/home.svg', text: 'home',),
          FABBottomAppBarItem(iconName:'assets/svg/chats.svg', text: 'chats'),
          FABBottomAppBarItem(iconName:'assets/svg/notification.svg', text: 'noti'),
          FABBottomAppBarItem(iconName:'assets/svg/profile.svg', text: 'profile'),
        ],
      ),


    );



  }
}
