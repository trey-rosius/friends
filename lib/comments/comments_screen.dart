import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:friends/models/Comment.dart';
import 'package:friends/models/Post.dart';
import 'package:friends/models/User.dart';
import 'package:friends/profile/profile_repository.dart';

import 'package:friends/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comment_item.dart';
import 'comments_repository.dart';
class CommentsScreen extends StatefulWidget {
  CommentsScreen({required this.userId,required this.post});
  final String userId;
  final Post post;
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

 late StreamSubscription commentStream;
@override
void initState(){
  var commentsRepo = context.read<CommentsRepository>();
  commentsRepo.queryAllCommentsForPost(widget.post.id).then((value) {
    commentsRepo.comments = value;
    print("comments "+value.toString());
  });



  commentStream = Amplify.DataStore.observe(Comment.classType).listen((event) {
    if (commentsRepo.comments.isEmpty) {
      commentsRepo.comments.add(event.item);

    }else{
      if (commentsRepo.comments[0].id != event.item.id) {
        commentsRepo.comments.insert(0, event.item);
        print('Received event of type ' + event.eventType.toString());
        print('Received post ' + event.item.toString());
      }
    }

  });

    super.initState();

  }
@override
void dispose(){
  super.dispose();
  commentStream.cancel();
}

  Widget buildInput(CommentsRepository commentsRepository) {

    return
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            children: <Widget>[
              // Button send image
              Container(
                margin: EdgeInsets.only(left: 10.0),
                decoration: const BoxDecoration(
                    color: ThemeColor.primary,
                    shape: BoxShape.circle),
                child: IconButton(
                  icon: new Icon(Icons.camera_alt),
                  //  onPressed: ()=>getImageFromCamera(chatRepo),
                  onPressed:() {


                  },
                  color: Colors.white,
                ),
              ),





              // Edit text
              Flexible(
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  //  padding: EdgeInsets.symmetric(vertical: 10.0),


                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          maxLines: null,
                          onChanged: (String text) {
                            if (text.trim().isNotEmpty) {

                            } else {



                            }
                          },


                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                          controller: commentsRepository.commentController,
                          decoration: InputDecoration(
                            hintText: 'leave a comment....',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Button send message
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: ThemeColor.secondary,
                    shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                    icon: new Icon(Icons.arrow_forward),
                    onPressed: () {
                      if(commentsRepository.commentController.text.isNotEmpty){
                        commentsRepository.createComment(widget.userId,widget.post).then((_){
                          commentsRepository.commentController.clear();
                        });

                      }
                    },
                    color: Colors.white,
                  ),
                ),
              ),

            ],


          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    var commentsRepo = context.watch<CommentsRepository>();
    return Scaffold(
        backgroundColor: ThemeColor.black,
        appBar: AppBar(title: const Text("Comments",),centerTitle: true,),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(

                itemBuilder: (context,index){

                  if(index == 0){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child:  Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            FutureProvider.value(value: ProfileRepository.instance().getUserProfile(widget.post.userID!),
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
                                                Text(timeago.format(widget.post.createdOn!.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
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
                                          child: Text(widget.post.content,style: TextStyle(color: Colors.white),))),
                                      Container(


                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              5),
                                          child:  CachedNetworkImage(

                                              height: 100.0,
                                              width: 100.0,
                                              fit: BoxFit.cover,
                                              imageUrl: widget.post.postImageUrl??"",
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

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),

                    );
                  }else{
                    index -= 1;
                    return CommentItem(widget.userId,commentsRepo.comments[index]);
                  }

                },itemCount: commentsRepo.comments.length+1,),
            ),
            buildInput(commentsRepo)
          ],
        )
    );
  }
}