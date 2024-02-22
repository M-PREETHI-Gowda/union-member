import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/sing_up_bloc/sing_up_bloc.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/custom_snackbar.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/auth/create_password.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedSalutation = '';
  String firstName = '';
  String lastName = '';
  String mobileNumber = '';
  String emailId = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();

  bool verify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: actionBar(context: context),
      backgroundColor: COLORS.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.all(SizeConfig.blockWidth * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,
                          color: COLORS.black, size: SizeConfig.blockWidth * 8),
                    ),
                    SizedBox(width: SizeConfig.blockWidth * 2.8),
                    headingText(text: "Register Now"),
                  ]),
                  SizedBox(height: SizeConfig.blockHeight * 45),
                  Text(
                    "Please Share Your Details",
                    style: TextStyle(
                      color: COLORS.lightBlack,
                      fontSize: SizeConfig.blockWidth * 5.2,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Lato',
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 3.5),
                  Row(
                    children: [
                      Text(
                        "Salutation",
                        style: TextStyle(
                          color: COLORS.grey1,
                          fontSize: SizeConfig.blockWidth * 4.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 4),
                      salutation(
                        text: "Mr.",
                        onTap: () {
                          setState(() {
                            selectedSalutation = "Mr";
                          });
                        },
                        color: selectedSalutation == "Mr"
                            ? COLORS.yellowLight
                            : COLORS.white,
                        txtColor: selectedSalutation == "Mr"
                            ? COLORS.white
                            : COLORS.lightBlack,
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 4),
                      salutation(
                        text: "Mrs.",
                        onTap: () {
                          setState(() {
                            selectedSalutation = "Mrs";
                          });
                        },
                        color: selectedSalutation == "Mrs"
                            ? COLORS.yellowLight
                            : COLORS.white,
                        txtColor: selectedSalutation == "Mrs"
                            ? COLORS.white
                            : COLORS.lightBlack,
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 4),
                      salutation(
                        text: "Ms.",
                        onTap: () {
                          setState(() {
                            selectedSalutation = "Ms";
                          });
                        },
                        color: selectedSalutation == "Ms"
                            ? COLORS.yellowLight
                            : COLORS.white,
                        txtColor: selectedSalutation == "Ms"
                            ? COLORS.white
                            : COLORS.lightBlack,
                      ),
                    ],
                  ),
                  Container(
                    width: SizeConfig.blockWidth * 100,
                    margin: EdgeInsets.only(top: SizeConfig.blockHeight * 3,bottom: SizeConfig.blockHeight*1),
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*2,horizontal: SizeConfig.blockWidth*3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: COLORS.lightWhite, // Border color
                        width: 0.4, // Border width
                      ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Name",
                          style: TextStyle(
                              color: COLORS.hintTxt,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lato",
                              fontSize: SizeConfig.blockWidth * 4
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHeight*1),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: COLORS.lightWhite,
                                onChanged: (value) {
                                  setState(() {
                                    firstName = value;
                                  });
                                },
                                validator: (String? value) {
                                  RegExp regex =RegExp(r'[a-zA-Z]');
                                  if (!regex.hasMatch(value!)) {
                                    return 'First Name is not valid';
                                  }
                                  return null;
                                },
                                decoration:textDecoration(hint: "First Name"),
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockWidth*5),
                            Expanded(
                              child: TextFormField(
                                cursorColor: COLORS.lightWhite,
                                onChanged: (value) {
                                  setState(() {
                                    lastName = value;
                                  });
                                },
                                validator: (String? value) {
                                  RegExp regex =RegExp(r'[a-zA-Z]');
                                  if (!regex.hasMatch(value!)) {
                                    return 'Last Name is not valid';
                                  }
                                  return null;
                                },
                                  decoration:textDecoration(hint: "Last Name"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  normalTextField(
                    hintText: 'Enter Mobile number',
                    controller: mobile,
                    inputType: TextInputType.phone,
                    maxLength: 10,
                    suffix: verify ? verified() : null,
                    onChanged: (value) {
                      setState(() {
                        verify = value.length == 10 ? true : false;
                        mobileNumber = value;
                      });
                    },
                    validator: (String? value) {
                      RegExp regex=RegExp(r"^(?:[+0]9)?[0-9]{10}$");
                      if (!regex.hasMatch(value!)) {
                        return 'Phone number is not valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1),
                  normalTextField(
                    hintText: 'Enter Email',
                    controller: email,
                    inputType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        emailId = value;
                      });
                    },
                    validator: (String? value) {
                      RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!regex.hasMatch(value!)) {
                        return 'email is not valid';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight*2,horizontal: SizeConfig.blockWidth * 4),
        child: enableButton(
          buttonEnabled: firstName.isEmpty || lastName.isEmpty || selectedSalutation.isEmpty || mobileNumber.isEmpty || emailId.isEmpty ? false : true,
          enableColor: COLORS.yellowLight,
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            if(selectedSalutation != ""){
              if (_formKey.currentState!.validate()) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(
                    create: (context) => SingUpBloc(),
                    child:  CreatePasswordScreen(
                      selectedSalutation: selectedSalutation,
                      firstName: firstName,
                      lastName: lastName,
                      mobile: mobileNumber,
                      email: emailId,
                    ))));
              }
            }else{
              CustomSnackBar.showCustomSnackBar(context: context, title: "Please Select Salutation");
            }
          },
          text: "Proceed",
        ),
      ),
    );
  }
  Widget verified() {
    return Container(
      alignment: Alignment.centerLeft,
      width: SizeConfig.blockWidth*20,
      margin: EdgeInsets.only(right: SizeConfig.blockWidth*2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Verified",
            style: TextStyle(
              color: COLORS.suffixClr,
              fontSize: SizeConfig.blockWidth * 4,
              fontWeight: FontWeight.w500,
              fontFamily: 'Lato',
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth*1,),
          Icon(Icons.check_circle,color: COLORS.yellowLight,size: SizeConfig.blockWidth*4),
        ],
      ),
    );
  }
}
