
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'models/Post.dart';
class UserPostItem extends StatelessWidget {
  UserPostItem(this.userId,this.post);
  final String userId;
  final Post post;


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child:  Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

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
                                    CircularProgressIndicator(),
                                errorWidget: (context,
                                    url, ex) =>
                                    Container(


                                      child: Icon(Icons.image,size: 100,),
                                    )),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      width: SizeConfig.screenWidth!/2.5,


                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)
                      ),

                      child: Row(

                        children: [
                          SvgPicture.asset(
                            'assets/svg/chats.svg',
                            fit: BoxFit.cover,
                            height: 20,
                            width: 20,
                            color: Colors.white,

                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Comments",style: TextStyle(color: Colors.white),),)
                        ],
                      ),
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
