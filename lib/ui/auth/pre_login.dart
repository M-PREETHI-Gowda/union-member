import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/login_bloc/login_bloc.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/auth/login_screen.dart';
import 'package:user_app/ui/auth/register_screen.dart';
import 'package:user_app/ui/initial_screen/splash_screen.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.black,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png",
            fit: BoxFit.cover,
            height: SizeConfig.blockHeight * 84,
          ),
          Column(
            children: [
              SizedBox(height: SizeConfig.blockHeight * 79),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 8),
                child: Text(
                  'Curated Collection of Experiences and Benefits',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: COLORS.whiteLight,
                    fontSize: SizeConfig.blockWidth * 4.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                    letterSpacing: SizeConfig.blockWidth * 0.2,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 6),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockHeight * 1.5,
                  horizontal: SizeConfig.blockWidth * 4,
                ),
                child: enableButton(
                  buttonEnabled: true,
                  enableColor: COLORS.blackLight,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => LoginBloc(),
                                  child: const LoginScreen(),
                                )));
                  },
                  text: "Login",
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
                width: SizeConfig.blockWidth * 100,
                height: SizeConfig.blockHeight * 10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(COLORS.lightYellow,),
                    foregroundColor: MaterialStateProperty.all<Color>(COLORS.white,),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeConfig.blockHeight * 6,
                        width: SizeConfig.blockWidth * 6,
                        margin: EdgeInsets.only(
                          right: SizeConfig.blockWidth * 2,
                        ),
                        child: Image.asset(
                          "assets/images/star.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "Activate Membership",
                        style: TextStyle(
                          color: COLORS.white,
                          fontFamily: 'Lato',
                          fontSize: SizeConfig.blockWidth * 4.4,
                          fontWeight: FontWeight.w400,
                          letterSpacing: SizeConfig.blockWidth * 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
