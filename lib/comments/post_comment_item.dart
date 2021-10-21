import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friends/models/Post.dart';
import 'package:friends/models/User.dart';
import 'package:friends/profile/profile_repository.dart';

import 'package:friends/utils/app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

class PostCommentItem extends StatelessWidget{
  PostCommentItem(this.post);
  final Post post;


  @override
  Widget build(BuildContext context) {
    // TODO: implement buildPostItem
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child:  Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FutureProvider.value(value: ProfileRepository.instance().getUserProfile(post.userID!),
                catchError: (context,error){
                  print(error);
                },initialData: null,
                child: Consumer(builder: (_,User? user,child){
                  if(user != null){
                    return  Container(

                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 2,color: ThemeColor.secondary),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: ClipOval(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                      30),
                                  child:  CachedNetworkImage(
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                      imageUrl: user.profilePicUrl??"",
                                      placeholder: (context,
                                          url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context,
                                          url, ex) =>
                                          CircleAvatar(
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
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.firstName,style: const TextStyle(fontSize: 16,color: Colors.white)),
                                Text(timeago.format(post.createdOn!.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }else{
                    return Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()
                    );
                  }
                })),


            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [ThemeColor.primary, ThemeColor.secondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),

                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(post.content,style: TextStyle(color: Colors.white),))),
                      Container(


                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              5),
                          child:  CachedNetworkImage(

                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                              imageUrl: post.postImageUrl??"",
                              placeholder: (context,
                                  url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context,
                                  url, ex) =>
                                  Container(


                                    child: Icon(Icons.image,size: 100,),
                                  )),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),


          ],
        ),
      ),

    );
  }

}