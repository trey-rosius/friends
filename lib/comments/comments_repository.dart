import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:friends/models/Comment.dart';
import 'package:friends/models/ModelProvider.dart';

class CommentsRepository extends ChangeNotifier {

  CommentsRepository.instance();



  final commentController = TextEditingController();



  S3UploadFileOptions? options;
  bool _loading = false;
  String? _userId;
  List<Comment> _comments = [];

  late StreamSubscription commentsStream;
  List<Comment> get comments => _comments;

  set comments(List<Comment> value) {
    _comments = value;
    notifyListeners();
  }

  String? get userId => _userId;

  set userId(String? value) {
    _userId = value;
    notifyListeners();
  }

  String _profilePic = "";
  String _profilePicKey ="";


  String get profilePicKey => _profilePicKey;

  set profilePicKey(String value) {
    _profilePicKey = value;
    notifyListeners();
  }


  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
    notifyListeners();
  }



  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }



  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }



  @override
  void dispose() {
    // TODO: implement dispose

    commentController.dispose();
    commentsStream.cancel();



    super.dispose();
  }

  Future<List<Comment>>queryAllCommentsForPost(String postId) async{
    List<Comment> comments= await Amplify.DataStore.query(Comment.classType,
        where: Comment.POSTID.eq(postId),
        sortBy: [Comment.CREATEDON.descending()]);

    print("comments are "+comments.toString());
    return comments;
  }

  Future<bool> createComment(String userId,Post post) async{
    loading = true;

    try {


      Comment comment = Comment(commentText: commentController.text.trim(),userId: userId,
          postID:post.id,post: post,createdOn: TemporalDateTime.now(),  updatedOn: TemporalDateTime.now());

      await Amplify.DataStore.save(comment);
      loading = false;
      return true;
    }catch(ex){
      print(ex.toString());
      loading = false;
      return false;
    }
  }



}