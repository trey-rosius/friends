import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friends/models/ModelProvider.dart';
import 'package:friends/posts/post_respository.dart';
import 'package:friends/profile/profile_repository.dart';

import 'package:friends/utils/app_theme.dart';
import 'package:friends/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import 'package:path_provider/path_provider.dart' as path_provider;

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({required this.userId});
  final String userId;
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  User user = User(firstName: '',username: "");
  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
  XFile? _imageFile;
  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();

  String? _retrieveDataError;


  Future<void> retrieveLostData() async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  void _onImageButtonPressed(ImageSource source, BuildContext context,
      PostRepository postRepository) async {
    postRepository.loading = true;

    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );

      if(pickedFile == null){
        postRepository.loading = false;
      }else{
        var dir = await path_provider.getTemporaryDirectory();
        var targetPath = dir.absolute.path + "/temp.jpg";


        await postRepository.cropPostImage(
            pickedFile.path, context, targetPath);
      }

    } catch (e) {


      setState(() {
        //postRepository.loading = false;
        _pickImageError = e;

      });
      print("this is the error "+_pickImageError.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create: (_)=>PostRepository.instance(),
      child: Consumer(builder: (_,PostRepository postRepo,child){
        return Scaffold(
          backgroundColor: ThemeColor.black,
          appBar: AppBar(
            title: Text('Speak Your Mind'),
            centerTitle: true,
            actions: [
              Container(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(icon:  Icon(Icons.image,color: ThemeColor.primary,), onPressed: (){
                  _onImageButtonPressed(ImageSource.gallery, context, postRepo);
                }),
              )
            ],
          ),
          body:

          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureProvider<User>(create:(_)=> ProfileRepository.instance().getUserProfile(widget.userId),
                            initialData: user,
                            child: Consumer<User>(
                              builder: (_,User user, child){

                                return user.profilePicUrl != null ?Flexible(
                                  flex: 1,
                                  child: Container(

                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2,color: ThemeColor.primary),
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
                                              imageUrl: user.profilePicUrl!,
                                              placeholder: (context,
                                                  url) =>
                                              const CircularProgressIndicator(),
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
                                  ),) : Flexible(child: SizedBox());




                              },
                            )
                        ),


                        Flexible(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white,),
                              maxLines: 4,

                              validator: (value) {
                                if(value!.isEmpty){
                                  return "say something..";
                                }else{
                                  return null;
                                }

                              },
                              controller: postRepo.postTextController,


                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColor.textfieldColor,
                                  labelText: 'Say something...',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: 'Say something....'

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  postRepo.postImageUrl.isNotEmpty ? Container(
                    margin: EdgeInsets.only(left: 60),
                    child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(
                            10),
                        child: CachedNetworkImage(
                            width: SizeConfig.screenWidth,
                            height: 200.0,
                            fit: BoxFit.cover,
                            imageUrl: postRepo.postImageUrl,
                            placeholder: (context,
                                url) =>
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                ),
                            errorWidget: (context,
                                url, ex) =>
                                Container(child: Icon(Icons.error,color: ThemeColor.secondary,),))),
                  ) : SizedBox(),


                  postRepo.loading? Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  ) :   Container(
                    margin: EdgeInsets.all(20),
                    width: SizeConfig.screenWidth,
                    height: 50.toHeight,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(

                      gradient: LinearGradient(colors: [ThemeColor.primary, ThemeColor.secondary],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                    ),
                    child: TextButton(

                      onPressed: () {
                        if (postRepo.postTextController.text.trim().length > 0) {
                          postRepo.createPost(widget.userId).then((bool complete){
                            if(complete){
                              Navigator.of(context).pop();
                            }else{
                              print("an error occured");
                            }




                          });

                        }
                      },
                      child:Text("Create Post",style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

        );
      },),);
  }
}