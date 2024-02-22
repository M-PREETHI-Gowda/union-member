import 'package:flutter/material.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/auth/pre_login.dart';
import 'package:user_app/ui/user_dashboard/index.dart';

class RegisterSuccessfullScreen extends StatefulWidget {
  String salutation;
  String firstName;
  String lastName;
  String membershipId;
  RegisterSuccessfullScreen(
      {super.key,
        required this.salutation,
        required this.firstName,
        required this.lastName,
        required this.membershipId});

  @override
  State<RegisterSuccessfullScreen> createState() =>
      _RegisterSuccessfullScreenState();
}

class _RegisterSuccessfullScreenState
    extends State<RegisterSuccessfullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: actionBar(context: context),
      backgroundColor: COLORS.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(SizeConfig.blockWidth * 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.blockHeight * 6),
                Text(
                  "Registered Successfully",
                  style: TextStyle(
                      color: COLORS.lightBlack,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Lato",
                      fontSize: SizeConfig.blockWidth * 5),
                ),
                SizedBox(height: SizeConfig.blockHeight * 8),
                primaryText(
                    text:
                    "${widget.salutation}. ${widget.firstName} ${widget.lastName}",
                    size: SizeConfig.blockWidth * 8),
                subText(
                    text: "Welcome to Mysore Union Apps",
                    size: SizeConfig.blockWidth * 3.8),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockHeight * 8,
                      bottom: SizeConfig.blockHeight * 4),
                  width: SizeConfig.blockWidth * 35,
                  child: Image.asset(
                    "assets/images/success.png",
                    fit: BoxFit.contain,
                  ),
                ),
                subText(
                    text: "Your Membership ID",
                    size: SizeConfig.blockWidth * 3.6),
                primaryText(
                    text: "${widget.membershipId}",
                    size: SizeConfig.blockWidth * 7),
                SizedBox(height: SizeConfig.blockHeight * 8),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Begin your journey as a club ',
                          style: TextStyle(
                              color: COLORS.lightBlack,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Lato",
                              fontSize: SizeConfig.blockWidth * 3.6),
                        ),
                        TextSpan(
                          text: 'MYSORE UNION',
                          style: TextStyle(
                              color: COLORS.lightBlack,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Lato",
                              fontSize: SizeConfig.blockWidth * 3.6),
                        ),
                        TextSpan(
                          text:
                          ' member & explore the various features of the app.',
                          style: TextStyle(
                              color: COLORS.lightBlack,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Lato",
                              fontSize: SizeConfig.blockWidth * 3.6),
                        ),
                      ],
                    ),
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
          enableColor: COLORS.black,
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => PreLoginScreen()));
          },
          text: "Proceed",
        ),
      ),
    );
  }
}
