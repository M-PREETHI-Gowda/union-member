import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/reuse_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProfileBloc profileBloc;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    print('object');
  }

  List<Map<String, dynamic>> itemList = [
    {
      'image': 'assets/images/dining.png',
      'title': 'Book Dining',
    },
    {
      'image': 'assets/images/fitness.png',
      'title': 'Fitness',
    },
    {
      'image': 'assets/images/kids.png',
      'title': 'Kids Zone',
    },
    {
      'image': 'assets/images/lounge.png',
      'title': 'Theatre Lounge',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.white,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            print("Loading");
            return Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: COLORS.yellow,
                ),
              ),
            );
          }
          if (state is FetchProfileFailed) {
            print("Error");
            return Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
              child: Center(
                child: Text(
                  "Something Went Wrong",
                  style: TextStyle(
                    color: COLORS.yellowLight,
                    fontSize: SizeConfig.blockWidth * 5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            );
          }
          if (state is FetchProfileSuccess) {
            print("${state.lastName},loded");
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/slide2.png",
                    fit: BoxFit.cover,
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.blockHeight * 67,
                  ),
                  Positioned(
                    top: SizeConfig.blockHeight * 4.6,
                    left: 0,
                    right: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: SizeConfig.blockHeight * 15,
                              margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 1),
                              child: Image.asset("assets/images/logo.png")),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.blockHeight * 70),
                        headingText(
                            text: "Namaste ${state.firstName} ${state.lastName}"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Member - 0 Green points",
                              style: TextStyle(
                                color: COLORS.subTxt,
                                fontSize: SizeConfig.blockWidth * 3.6,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Lato',
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockWidth * 2.8),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                  Icons.arrow_forward,
                                  color: COLORS.black,
                                  size: SizeConfig.blockWidth * 5),
                            ),
                          ],
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: SizeConfig.blockHeight * 30,
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockHeight * 5.6,
                                bottom: SizeConfig.blockHeight * 3),
                            child: Column(
                              children: [
                                Image.asset("assets/images/icons/balance.png",
                                    height: SizeConfig.blockHeight * 22.6,
                                    width: SizeConfig.screenWidth),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    balanceTxt(text: "Payment Made"),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: SizeConfig.blockHeight * 0.8,
                                          horizontal: SizeConfig.blockWidth * 8),
                                      decoration: BoxDecoration(
                                        color: Color(0xffC89314),
                                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 5),
                                      ),
                                      child: Text(
                                        "₹ 10,489",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: COLORS.white,
                                          fontSize: SizeConfig.blockWidth * 3.2,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                    ),
                                    balanceTxt(text: "Due Date"),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          width: SizeConfig.blockWidth * 100,
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockHeight * 5),
                          decoration: BoxDecoration(
                            color: COLORS.white,
                            border: Border.all(
                              color: COLORS.lightWhite, // Border color
                              width: 0.4, // Border width
                            ),
                            borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: COLORS.lightWhite,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TabBar(
                                controller: _tabController,
                                tabs: const [
                                  Tab(text: 'Upcoming Reservations'),
                                  Tab(text: 'Celebration Date'),
                                ],
                                padding: EdgeInsets.only(top: SizeConfig.blockHeight * 1),
                                dividerColor: Color(0xffD5D5D5),
                                dividerHeight: SizeConfig.blockHeight * 0.3,
                                indicatorColor: COLORS.divClr,
                                unselectedLabelColor: COLORS.labelTxt,
                                labelStyle: TextStyle(
                                  color: COLORS.yellow,
                                  fontSize: SizeConfig.blockWidth * 3.6,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Lato',
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockHeight * 12,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.blockWidth * 2,
                                          vertical: SizeConfig.blockHeight * 4),
                                      child: Text(
                                        "Your upcoming dining is tomorrow on 30th dec",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: COLORS.lightBlack,
                                          fontSize: SizeConfig.blockWidth * 4,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockWidth * 2,
                                          top: SizeConfig.blockHeight * 4),
                                      child: Text(
                                        "Your Celebration Date is on 20th Mar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: COLORS.lightBlack,
                                          fontSize: SizeConfig.blockWidth * 4,
                                          fontWeight: FontWeight.w600,
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
                        SizedBox(
                          height: SizeConfig.blockHeight * 54,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemCount: itemList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> item = itemList[index];
                              return Container(
                                margin: EdgeInsets.only(
                                    right: SizeConfig.blockWidth * 2,
                                    left: SizeConfig.blockWidth * 2,
                                    bottom: SizeConfig.blockHeight * 4),
                                decoration: BoxDecoration(
                                  color: COLORS.white,
                                  border: Border.all(
                                    color: COLORS.divClr, // Border color
                                    width: 0.1, // Border width
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(SizeConfig.blockWidth * 2.5),
                                    topRight: Radius.circular(SizeConfig.blockWidth * 2.5),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: COLORS.lightWhite,
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        SizeConfig.blockWidth * 2.5),
                                    topRight: Radius.circular(
                                        SizeConfig.blockWidth * 2.5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          item['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(SizeConfig.blockHeight * 2.5),
                                        color: COLORS.white,
                                        child: Text(
                                          item['title'],
                                          textAlign: TextAlign.center,
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
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(left: SizeConfig.blockWidth * 68.2),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: COLORS.yellow,
                                width: SizeConfig.blockHeight * 0.2,
                              ),
                            ),
                          ),
                          child: Text(
                            "VIEW MORE",
                            style: TextStyle(
                              color: COLORS.yellow,
                              fontSize: SizeConfig.blockWidth * 3.8,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 8.8),
                          height: SizeConfig.blockHeight * 22.6,
                          child: Image.asset("assets/images/txt.png",width: SizeConfig.screenWidth),
                        ),
                        Text(
                          "OFFERS AND EVENTS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: COLORS.lightBlack,
                            fontSize: SizeConfig.blockWidth * 4.6,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockWidth * 100,
                          height: SizeConfig.blockHeight * 10,
                          margin: EdgeInsets.only(top: SizeConfig.blockHeight * 1),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(COLORS.button),
                              foregroundColor: MaterialStateProperty.all<Color>(COLORS.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.blockWidth * 2,
                                  ),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/book_mark.png",
                                  height: SizeConfig.blockHeight * 5,
                                  width: SizeConfig.blockWidth * 5,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: SizeConfig.blockWidth * 4),
                                Text(
                                  "Plan with Mysore Union",
                                  style: TextStyle(
                                    color: COLORS.white,
                                    fontFamily: 'Lato',
                                    fontSize: SizeConfig.blockWidth * 4.2,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: SizeConfig.blockWidth * 0.2,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: COLORS.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockWidth * 100,
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.blockHeight * 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockWidth * 6)),
                          child: Image.asset("assets/images/bgImg.png",
                              fit: BoxFit.contain),
                        ),
                        Text(
                          "DINE AND EARN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: COLORS.lightBlack,
                            fontSize: SizeConfig.blockWidth * 4.6,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockWidth * 100,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockHeight * 1,
                              bottom: SizeConfig.blockHeight * 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockWidth * 6)),
                          child: Image.asset("assets/images/dine.png",
                              fit: BoxFit.contain),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget balanceTxt({required String text}) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xff969696),
        fontSize: SizeConfig.blockWidth * 3.2,
        fontWeight: FontWeight.w500,
        fontFamily: 'Lato',
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
