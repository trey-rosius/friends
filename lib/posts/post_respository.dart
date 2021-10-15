import 'dart:io';

import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:friends/models/ModelProvider.dart';
import 'package:friends/models/Post.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';


class PostRepository extends ChangeNotifier{

  PostRepository.instance();

  bool _loading = false;


  bool get loading => _loading;
  String _postImageKey='';
  String _postImageUrl='';
  List<Post> _posts = [];


  List<Post> get posts => _posts;

  set posts(List<Post> value) {
    _posts = value;
    notifyListeners();
  }

  String get postImageKey => _postImageKey;

  set postImageKey(String value) {
    _postImageKey = value;
    notifyListeners();
  }
  String get postImageUrl => _postImageUrl;

  set postImageUrl(String value) {
    _postImageUrl = value;
    notifyListeners();
  }
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final postTextController = TextEditingController();

  Future<bool> createPost(String userId) async{
    loading = true;
    /**
     * first retrieve user model
     */
    try {
      List<User> user = await Amplify.DataStore.query(
          User.classType, where: User.ID.eq(userId));
      print("user details" + user[0].toString());
      Post post = Post(content: postTextController.text.trim(),
          type: PostType.TEXT_IMAGE,
          status: PostStatus.CREATED,
          userID: userId,
          postImageUrl: postImageUrl,
          user: user[0],
          //user model
          createdOn: TemporalDateTime.now(),
          updatedOn: TemporalDateTime.now());
      await Amplify.DataStore.save(post);
      loading = false;
      return true;
    }catch(ex){
      print(ex.toString());
      loading = false;
      return false;
    }
  }
  Future<List<Post>>queryPost() async{
    List<Post> posts = await Amplify.DataStore.query(Post.classType);
    return posts;
  }

  Future<List<Post>>queryAllPosts() async{
    List<Post> posts = await Amplify.DataStore.query(Post.classType,sortBy: [Post.CREATEDON.descending()]);
    return posts;
  }
  Future<List<Post>>paginatePosts(int page) async{
    List<Post> posts = await Amplify.DataStore.query(Post.classType,sortBy: [Post.CREATEDON.descending()],
                 pagination: QueryPagination(page:page, limit:100));
    return posts;
  }
  Future<List<Post>>getSinglePost(String postID) async{
    List<Post> posts = await Amplify.DataStore.query(Post.classType,where: Post.ID.eq(postID));
    return posts;
  }
  Future<List<Post>>queryAllUserPosts(String userId) async{
    List<Post> posts = await Amplify.DataStore.query(Post.classType,
        where: Post.USERID.eq(userId),
        sortBy: [Post.CREATEDON.descending()]);
    return posts;
  }



  Future<void> updatePost(String postId) async{
    Post oldPost = (await Amplify.DataStore.query(Post.classType,
        where: Post.ID.eq(postId)))[0];
    Post newPost = oldPost.copyWith(id: oldPost.id,
        createdOn: TemporalDateTime.now(),
        updatedOn: TemporalDateTime.now());

    await Amplify.DataStore.save(newPost);
  }

/*
  Future<void> updateUser(Post post) async{
    User oldUser =  (await Amplify.DataStore.query(User.classType,
        where: User.ID.eq("456090a5-e6a1-4a59-b945-a2d85ac2748f")))[0];
    User newUser = oldUser.copyWith(id: oldUser.id,updatedOn: TemporalDateTime.now(),post: [post]);
    await Amplify.DataStore.save(newUser);
  }
 */
  Future<User> retrieveUser(String userId) async{
    User user = (await Amplify.DataStore.query(User.classType, where: User.ID.eq(userId)))[0];
    return user;

  }

  Future<Null> cropPostImage(String imageFilePath,
      BuildContext context, String targetPath) async {
    loading = true;
    var uuid =  Uuid().v1();

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFilePath,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: Platform.isAndroid
        ? [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio4x3,]
            : [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Theme.of(context).accentColor,
        toolbarWidgetColor: Colors.white,
    initAspectRatio: CropAspectRatioPreset.original,
    lockAspectRatio: true),
    iosUiSettings: IOSUiSettings(
    title: 'Crop Image',
    ));
    if (croppedFile != null) {
    print("cropped file is" + croppedFile.path);

    Map<String, String> metadata = <String, String>{};
    metadata['name'] = "user_$uuid";

    metadata['desc'] = 'post picture ';
    /**
     * Prepare to upload croppped image to s3
     */
    S3UploadFileOptions  options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest, metadata: metadata);
    try {
    UploadFileResult result  =  await Amplify.Storage.uploadFile(
    key: uuid,
    local: croppedFile,
    options: options,
    );
    postImageKey  = result.key;
    print("the key is "+postImageKey);

    /**
     * Get url of the uploaded image to display on the frontend
     *
     */
    GetUrlResult resultDownload =
    await Amplify.Storage.getUrl(key: postImageKey);
    print(resultDownload.url);
    postImageUrl = resultDownload.url;
    loading = false;

    } on StorageException catch (e) {
    print("error message is" + e.message);
    loading= false;
    }

    }else{
    loading = false;
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postTextController.dispose();
  }


}