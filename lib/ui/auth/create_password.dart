import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/bloc/sing_up_bloc/sing_up_bloc.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/custom_snackbar.dart';
import 'package:user_app/helpers/image_picker_model.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/auth/register_successful.dart';

class CreatePasswordScreen extends StatefulWidget {
  String selectedSalutation;
  String firstName;
  String lastName;
  String mobile;
  String email;
  CreatePasswordScreen(
      {super.key,
      required this.selectedSalutation,
      required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.email});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool buttonEnabled = false;
  String firstName = '';
  String lastName = '';
  String createPassword = '';
  String reEnterPassword = '';
  late String profilePicture;
  final picker = ImagePicker();
  late File? _image;
  late SingUpBloc singUpBloc;
  bool loading = false;
  bool showFiled = false;

  @override
  void initState() {
    super.initState();
    singUpBloc = BlocProvider.of<SingUpBloc>(context);
    firstName = widget.firstName;
    lastName = widget.lastName;
    profilePicture = "";
  }

  bool _isVerified = false;
  bool verify = false;

  imgFromCamera() async {
    final selectedImage = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 900);
    setState(() {
      if (selectedImage != null) {
        print("the image selected is -------> ${selectedImage.path}");
        setState(() {
          _image = File(selectedImage.path);
          profilePicture = selectedImage.name;
        });
      } else {
        print('No image selected.');
      }
    });
  }

  imgFromGallery() async {
    final selectedImage = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 900);
    setState(() {
      if (selectedImage != null) {
        print("the image selected is -------> ${selectedImage.path}");
        setState(() {
          _image = File(selectedImage.path);
          profilePicture = selectedImage.name;
        });
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: actionBar(context: context),
      backgroundColor: COLORS.white,
      body: BlocListener<SingUpBloc, SingUpState>(
        listener: (context, state) {
          if (state is SingUpLoading) {
            loading = true;
          } else if (state is SingUpFailed) {
            CustomSnackBar.showCustomSnackBar(
                context: context, title: state.message);
            loading = false;
          } else if (state is SingUpSuccess) {
            loading = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterSuccessfullScreen(
                          salutation: state.salutation,
                          firstName: state.firstName,
                          lastName: state.lastName,
                          membershipId: state.membershipId,
                        )));
          }
          else if (state is UploadImageSuccess) {
            loading = false;
            singUpBloc.add(SingUpEvents(
                salutiation: widget.selectedSalutation,
                firstName: firstName,
                lastName: lastName,
                mobile: widget.mobile,
                email: widget.email,
                password: createPassword,
                confirmPassword: reEnterPassword,
                profilePic: state.filePath
            ));
          }
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.all(SizeConfig.blockWidth * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: COLORS.black, size: SizeConfig.blockWidth * 8),
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 2.8),
                      headingText(text: "Register Now"),
                    ]),
                    SizedBox(height: SizeConfig.blockHeight * 15),
                    Container(
                      width: SizeConfig.blockWidth * 100,
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 2),
                      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 5),
                      decoration: BoxDecoration(
                        color: COLORS.white,
                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5),
                        boxShadow: const [
                          BoxShadow(
                            color: COLORS.lightWhite,
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilePicture.isNotEmpty ?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: SizeConfig.blockWidth*15,
                              backgroundImage: Image.file(
                                _image!,
                                fit: BoxFit.contain,
                              ).image,
                            ),
                          ):
                          Container(
                            margin: EdgeInsets.only(top: SizeConfig.blockHeight * 1,bottom: SizeConfig.blockHeight * 1.5),
                            width: SizeConfig.blockWidth * 26,
                            child: Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            "Add your photo to confirm identify",
                            style: TextStyle(
                                color: COLORS.hintTxt,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Lato",
                                fontSize: SizeConfig.blockWidth * 3.8),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockHeight * 5,
                                  bottom: SizeConfig.blockHeight * 1),
                              child: Divider(
                                height: SizeConfig.blockHeight * 1,
                                color: COLORS.lightWhite,
                              )),
                          InkWell(
                            onTap: (){
                              showImagePicker(context, imgFromGallery, imgFromCamera);
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_upload_outlined,
                                      color: COLORS.yellow,
                                      size: SizeConfig.blockWidth * 8),
                                  SizedBox(width: SizeConfig.blockWidth * 2.8),
                                  primaryText(
                                      text: "Upload Photo (Optional)",
                                      size: SizeConfig.blockWidth * 4.2)
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockWidth * 100,
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockHeight * 2,
                          horizontal: SizeConfig.blockWidth * 3),
                      decoration: BoxDecoration(
                        color: COLORS.white,
                        borderRadius:
                            BorderRadius.circular(SizeConfig.blockWidth * 1.5),
                        boxShadow: const [
                          BoxShadow(
                            color: COLORS.lightWhite,
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: COLORS.hintTxt,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Lato",
                                fontSize: SizeConfig.blockWidth * 4),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                              suffixIcon: verified(icons: Icons.edit_outlined, phone: true),
                              hintText: '$firstName $lastName',
                              hintStyle: TextStyle(
                                  color: COLORS.blackLight,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Lato",
                                  fontSize: SizeConfig.blockWidth * 4),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 3),
                          Text(
                            "Create Password",
                            style: TextStyle(
                                color: COLORS.hintTxt,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Lato",
                                fontSize: SizeConfig.blockWidth * 4),
                          ),
                          TextFormField(
                            cursorColor: COLORS.lightWhite,
                            obscureText: true,
                            obscuringCharacter: "•",
                            onChanged: (value) {
                              setState(() {
                                createPassword = value;
                                showFiled = true;
                              });
                            },
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                              if (!regex.hasMatch(value ?? "")) {
                                _isVerified = false;
                                return 'Password is not valid';
                              }
                              _isVerified = true;
                              return null;
                            },
                            decoration:textDecoration(hint: "", suffix: _isVerified == true ? verified(icons: Icons.check_circle, phone: false) : null,),
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 2),
                          showFiled
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Re-entry Password",
                                      style: TextStyle(
                                          color: COLORS.hintTxt,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Lato",
                                          fontSize: SizeConfig.blockWidth * 4),
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          reEnterPassword = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value != createPassword) {
                                          verify = false;
                                          return 'Password do not match';
                                        }else {
                                          verify = true;
                                          return null;
                                        }
                                      },
                                      decoration:textDecoration(hint: "", suffix: verify == true ? verified(icons: Icons.check_circle, phone: false) : null,),
                                    )
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            vertical: SizeConfig.blockHeight * 2,
            horizontal: SizeConfig.blockWidth * 4),
        child: enableButton(
          buttonEnabled: createPassword.isEmpty || reEnterPassword.isEmpty ? false : true,
          enableColor: COLORS.yellowLight,
          onPressed: (loading == true)
              ? () {}
              : () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (_formKey.currentState!.validate()) {
                    if(profilePicture.isNotEmpty) {
                      singUpBloc.add(UploadImageEvent(
                          imagePath: _image!,
                          onSuccess: () {
                            print("upload image success");
                          },
                          onError: () {
                            CustomSnackBar.showCustomSnackBar(context: context, title: "Unable to upload the image");
                          }));
                    }
                    else{
                      singUpBloc.add(SingUpEvents(
                          salutiation: widget.selectedSalutation,
                          firstName: firstName,
                          lastName: lastName,
                          mobile: widget.mobile,
                          email: widget.email,
                          password: createPassword,
                          confirmPassword: reEnterPassword,
                          profilePic: profilePicture
                      ));
                    }
                  }
                },
          text: "Proceed",
        ),
      ),
    );
  }

  Widget verified({required IconData icons, required bool phone}) {
    return InkWell(
      onTap: (){
        phone == true ? Navigator.pop(context):null;
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: SizeConfig.blockWidth*5,
        margin: EdgeInsets.only(right: SizeConfig.blockWidth*1),
        child: Icon(icons,color: COLORS.yellowLight,size: SizeConfig.blockWidth*6),
      ),
    );
  }
}
