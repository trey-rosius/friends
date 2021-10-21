
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friends/home_page.dart';
import 'package:friends/posts/post_respository.dart';
import 'package:friends/profile/profile_repository.dart';
import 'package:friends/utils/shared_prefs.dart';
import 'package:friends/utils/size_config.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_theme.dart';


class EditProfileScreen extends StatefulWidget {
const EditProfileScreen(this.userId);
final String userId;


  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {



  PickedFile? _imageFile;
  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();
  File? file;

  final GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();








  String? _retrieveDataError;






  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage(ProfileRepository profileRepo, BuildContext context) {

    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform

        return Container(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              _imageFile!.path,
              height: 100,
              width: 100,
            ),
          ),
        );

      } else {

        return Container(
          child: Semantics(
              child: Image.file(
                File(_imageFile!.path),
                width: 100,
              ),
              label: 'pick image'),
        );

      }
    } else if (_pickImageError != null) {

      print("error occured during image pick");

      return InkWell(
        onTap: () {
          _onImageButtonPressed(ImageSource.gallery, context, profileRepo);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.account_circle,
              size: 100,
              color: ThemeColor.primary,
            )),
      );

    } else {


      return InkWell(
        onTap: () {
          _onImageButtonPressed(ImageSource.gallery, context, profileRepo);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: const Icon(
              Icons.account_circle,
              size: 100,
              color: ThemeColor.primary,
            )),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = (await _picker.retrieveLostData()) as LostData;
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
      ProfileRepository profileRepo) async {
    profileRepo.loading = true;

    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );

      var dir = await path_provider.getTemporaryDirectory();
      var targetPath = dir.absolute.path + "/temp.jpg";

      if(pickedFile == null){
        print("didn't pick file");
        profileRepo.loading = false;
      }else {
        setState(() {
          _imageFile = pickedFile;
        });
        await profileRepo.cropImage(
            pickedFile.path, context, targetPath);
      }

    } catch (e) {

      print("this error"+ e.toString());
      profileRepo.loading = false;

      setState(() {
        _pickImageError = e;
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();



      var profileRepo = context.read<ProfileRepository>();

      profileRepo.getUserProfile(widget.userId);




  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var profileRepo = context.watch<ProfileRepository>();

    return Scaffold(
      key: _scaffoldKey,


      body: Stack(
        children: [
          SizedBox(

            height: SizeConfig.screenHeight,
            child: Image.asset('assets/images/bg.jpg',fit: BoxFit.cover,),


          ),
          Center(
            child: ClipRect(
              child:BackdropFilter(
                filter:ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0) ,
                child: Container(
                  height:  SizeConfig.screenHeight!/1.6,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  decoration: BoxDecoration(
                      border:Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
                      borderRadius: BorderRadius.circular(30),
                      color: ThemeColor.primary.withOpacity(0.2)
                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      profileRepo.loading
                          ? Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator())
                          : InkWell(
                          onTap: () {
                            _onImageButtonPressed(ImageSource.gallery, context, profileRepo);
                          },
                          child: profileRepo.profilePic.isEmpty
                              ?
                          _previewImage(profileRepo, context)

                              : Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: ClipOval(
                                    child: ClipRRect(
                                        borderRadius:
                                        new BorderRadius.circular(
                                            30),
                                        child: CachedNetworkImage(
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                            imageUrl: profileRepo
                                                .profilePic,
                                            placeholder: (context,
                                                url) =>
                                                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeColor.primary),),
                                            errorWidget: (context,
                                                url, ex) =>
                                                CircleAvatar(
                                                  backgroundColor:
                                                  Theme.of(
                                                      context)
                                                      .accentColor,
                                                  radius: 40.0,
                                                  child: Icon(
                                                    Icons
                                                        .account_circle,
                                                    color:
                                                    Colors.white,
                                                    size: 40.0,
                                                  ),
                                                )))),
                              ))

                        // child: _prev,

                      ),
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Please enter your first name";
                                  }else{
                                    return null;
                                  }

                                },
                                controller: profileRepo.firstNamesController,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),

                                  hintText: "Please enter first name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child:  TextFormField(
                                style: TextStyle(color: Colors.white),

                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Please enter your last name";
                                  }else{
                                    return null;
                                  }

                                },
                                controller: profileRepo.lastNamesController,


                                // enabled: false,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),

                                  hintText: "Please enter last name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),






                          ],
                        ),
                      ),




                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: <Widget>[
                            profileRepo.loading? Container(
                              padding: EdgeInsets.only(top: 30.0),

                              child: CircularProgressIndicator(),
                            ) :

                            Column(
                              children: <Widget>[

                                Container(
                                  margin: const EdgeInsets.all(20),
                                  width: SizeConfig.screenWidth,
                                  height: 50.toHeight,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(

                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                        colors: [ThemeColor.primary,ThemeColor.secondary], // red to yellow
                                        tileMode: TileMode.clamp// repeats the gradient over the canvas
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),

                                  ),
                                  //  color: Theme.of(context).primaryColor,

                                  child: TextButton(

                                    onPressed: () {


                                      final FormState form = formKey.currentState!;
                                      if (!form.validate()) {

                                      } else {
                                        form.save();

                                        print(profileRepo.profilePic);




                                        profileRepo.updateUserProfileDetails(widget.userId).then((_){

                                          print("updated to database");
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return MultiProvider(
                                              providers: [
                                                ChangeNotifierProvider(create: (_) => ProfileRepository.instance(),),
                                                ChangeNotifierProvider(create: (_) => PostRepository.instance(),),
                                                ChangeNotifierProvider(create: (_) => SharedPrefsUtils.instance(),),


                                              ],
                                              child:HomePage(),

                                            );
                                          }));


                                        });




                                      }


                                    },

                                    child:  Text(
                                      "Save Profile",
                                      style: TextStyle(fontSize: 20,color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
