
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/profile/profile_repository.dart';

import 'package:friends/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:friends/utils/size_config.dart';
import 'edit_profile_screen.dart';

import '../models/User.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.userId);
  final String userId;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ThemeColor.black,
      body: CustomScrollView(
        slivers: [
          FutureProvider.value(value: ProfileRepository.instance().getUserProfile(widget.userId),
          catchError: (context,error){
            print(error);
          },initialData: null,
          child: Consumer(builder: (_,User? user,child){
            if(user != null){
              return SliverToBoxAdapter(
                child: Container(
                  height: 250.toHeight,
                  padding: EdgeInsets.only(top: 3),

                  child: Column(
                    children: [
                      Container(

                       margin:EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color: ThemeColor.secondary),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(
                                  40),
                              child:  CachedNetworkImage(
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                  imageUrl: user.profilePicUrl!,
                                  placeholder: (context,
                                      url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context,
                                      url, ex) =>
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                        Theme.of(
                                            context)
                                            .colorScheme.secondary,

                                        child: const Icon(

                                          Icons
                                              .account_circle,
                                          color:

                                          Colors.white,

                                        ),
                                      )),
                            )),

                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Text(user.firstName,style:  const TextStyle(fontSize: 20,color: ThemeColor.secondary),),
                                const Text(" "),
                                 Text(user.lastName!,style:  const TextStyle(fontSize: 20,color: ThemeColor.secondary),)
                              ],
                            ),
                            Text('@'+ user.username,style: const  TextStyle(fontSize: 18,color: ThemeColor.primary),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Created ",style: TextStyle(color: ThemeColor.white),),
                                Text(timeago.format(user.createdOn!.getDateTimeInUtc()),style:  const TextStyle(color: ThemeColor.white),)
                              ],
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }else{
              return SliverToBoxAdapter(child: SizedBox(),);
            }
    },)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50.toHeight,
                    width: SizeConfig.screenWidth!/2.5,
                    child: ElevatedButton(
                      style: ButtonStyle(

                        backgroundColor: MaterialStateProperty.all(ThemeColor.secondary),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                        onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            // return RegisterScreen();
                            //return LoginScreen();

                            return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                              child: EditProfileScreen(widget.userId),);


                          }));

                    }, child: Text("Edit Profile")),
                  ),
                  Container(
                    height: 50.toHeight,
                    width: SizeConfig.screenWidth!/2.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: (){

                        }, child: Text("Ratings")),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    color: ThemeColor.primary,
                    child: Container(

                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(


                            decoration: BoxDecoration(
                                color: Colors.black,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding:EdgeInsets.all(15),
                            child: SvgPicture.asset(
                              'assets/svg/trophy.svg',
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                              color: Colors.white,

                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child:Text("Achievements",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text("🥰")),
                                Container(
                                    margin: EdgeInsets.only(left: 30),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text("❤️")),
                                Container(
                                    margin: EdgeInsets.only(left: 50),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text('😡')),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          /*
          FutureProvider.value(value: postRepo.queryAllUserPosts(widget.userId),

          catchError: (context,error){
            print(error.toString());
          },initialData: [],
          child: Consumer(builder: (_,List<Post>? postsList,child){
            if(postsList == null){
              return const SliverToBoxAdapter(
                child: CircularProgressIndicator(),

              );
            }else {
              if (postsList.isNotEmpty) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return UserPostItem(widget.userId, postsList[index]);
                    }, childCount: postsList.length));
              } else {
                return SliverToBoxAdapter(
                  child: Center(child: Text("No Posts Available"),),);
              }
            }
            },),)

           */
        ],
      ),
    );
  }
}
