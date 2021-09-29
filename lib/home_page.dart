import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:friends/profile_repository.dart';
import 'package:friends/profile_screen.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/shared_prefs.dart';
import 'package:friends/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'login/login_screen.dart';
import 'models/Post.dart';
import 'nav/fab_bottom_app_bar.dart';

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String? userId;
List<Post> posts = [];
late Stream<SubscriptionEvent<Post>>? postStream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
   // postStream.ca

  }






  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sharedPrefs = context.read<SharedPrefsUtils>();
    var profileRepo = context.watch<ProfileRepository>();
    return userId == null ?LoginScreen() :
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

         Container(child: Center(child: Text("Welcome to the home screen"),),),
/*
          FutureProvider.value(value: PostRepository.instance().queryAllPosts(),
            catchError: (context,error){
              print(error.toString());
            },
            initialData: posts,
            child: Consumer(builder: (_,List<Post>? posts,child){
              if(posts != null){
                if(posts.isNotEmpty){
                  return  ListView.builder(


                    itemBuilder: (context,index){
                      return PostItem(userId!,posts[index]);
                    },itemCount: posts.length,);
                }else{
                  return const Center(
                    child:Text("No Posts Available, please create some",style: TextStyle(color: Colors.white),)
                  );
                }
              }else{
                return Container(child: Center(child: CircularProgressIndicator(),),);
              }
            },),),
*/
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
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_amplifyConfigured) {
            print("amplify configured");
            //addBlog();

            Navigator.push(context, MaterialPageRoute(builder: (context){
            // return RegisterScreen();
              //return LoginScreen();

              return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
              child: EditProfileScreen(),);


            }));
          }else{
            print("amplify NOT configured");
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.


       */

    );



  }
}
