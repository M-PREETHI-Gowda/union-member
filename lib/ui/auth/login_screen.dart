import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/login_bloc/login_bloc.dart';
import 'package:user_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/custom_snackbar.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/user_dashboard/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController memberID = TextEditingController();
  TextEditingController password = TextEditingController();
  String memberId = '';
  String passcode = '';
  final _formKey = GlobalKey<FormState>();
  late LoginBloc loginBloc;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            loading = true;
          } else if (state is LoginFailed) {
            CustomSnackBar.showCustomSnackBar(
                context: context, title: state.message);
            loading = false;
          } else if (state is LoginSuccess) {
            loading = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => ProfileBloc(),
                        child: UserDashboard(),
                      )),
            );
          }
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/background.png",
                  fit: BoxFit.cover,
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockHeight * 65,
                ),
                Positioned(
                  top: SizeConfig.blockHeight * 40,
                  left: 0,
                  right: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: SizeConfig.blockHeight * 15,
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.blockHeight * 1),
                            child: Image.asset("assets/images/logo.png")),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 4),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockHeight * 68,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back,
                                color: COLORS.black,
                                size: SizeConfig.blockWidth * 8),
                          ),
                          SizedBox(width: SizeConfig.blockWidth * 2.8),
                          headingText(text: "Log in")
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockHeight * 4,
                      ),
                      normalTextField(
                        hintText: 'Member ID',
                        controller: memberID,
                        inputType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            memberId = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.length < 2 || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      normalTextField(
                        hintText: 'Password',
                        password: true,
                        controller: password,
                        inputType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            passcode = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.length < 2 || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: SizeConfig.blockHeight * 2),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: COLORS.lightBlack,
                            fontSize: SizeConfig.blockWidth * 4,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
            vertical: SizeConfig.blockHeight * 2,
            horizontal: SizeConfig.blockWidth * 4),
        child: enableButton(
          buttonEnabled: true,
          enableColor: COLORS.yellowLight,
          onPressed: (loading == true)
              ? () {}
              : () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (_formKey.currentState!.validate()) {
                    loginBloc.add(
                        LoginEvents(memberId: memberId, password: passcode));
                  }
                },
          text: "Log in",
        ),
      ),
    );
  }
}
