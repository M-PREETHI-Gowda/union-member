import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/auth/pre_login.dart';

class SlideScreen extends StatefulWidget {
  const SlideScreen({super.key});

  @override
  State<SlideScreen> createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> {
  late CarouselController _carouselController;
  List<Map<String, String>> slideItems = [
    {
      'image': 'assets/images/slide1.png',
      'title': 'Namaste',
      'text':
          'Welcome to Mysore Union, Glance through the many features of the app',
    },
    {
      'image': 'assets/images/slide2.png',
      'title': 'Enjoy Member Rates',
      'text': 'Member gets our unlimited access to Mysore union facilities',
    },
    {
      'image': 'assets/images/slide3.png',
      'title': 'Unlock New Experience',
      'text': 'Join the Mysore Union for an extraordinary experience',
    },
    {
      'image': 'assets/images/slide4.png',
      'title': 'Anytime open doors',
      'text': 'For club restaurant and bars, indoor and outdoor seating.',
    },
  ];

  int _currentSlide = 0;
  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.white,
      appBar: actionBar(context: context),
      body: SafeArea(
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: SizeConfig.screenHeight,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                disableCenter: true,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
                animateToClosest: false,
              ),
              items: slideItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockWidth * 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.blockHeight * 80,
                            width: SizeConfig.blockWidth * 100,
                            margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockHeight * 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockWidth * 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockWidth * 3),
                              child: Image.asset(item['image']!),
                            ),
                          ),
                          Text(
                            item['title']!,
                            style: TextStyle(
                                color: COLORS.yellow,
                                fontSize: SizeConfig.blockWidth * 6,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 1),
                          Text(
                            item['text']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: COLORS.lightBlack,
                                fontFamily: 'Lato',
                                fontSize: SizeConfig.blockWidth * 4.2,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: SizeConfig.blockHeight * 8,
                                  width: SizeConfig.blockHeight * 8,
                                  child: _currentSlide == 0
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            _carouselController.previousPage();
                                          },
                                          child: Image.asset(
                                              "assets/images/leftArrow.png",
                                              fit: BoxFit.fill))),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                              const PreLoginScreen()));
                                },
                                child: Text(
                                  "SKIP",
                                  style: TextStyle(
                                      color: COLORS.lightGrey,
                                      fontFamily: 'Lato',
                                      fontSize: SizeConfig.blockWidth * 4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.blockHeight * 8,
                                  width: SizeConfig.blockHeight * 8,
                                  child: InkWell(
                                      onTap: () {
                                        _currentSlide == 3
                                            ? Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) =>
                                                        const PreLoginScreen()))
                                            : _carouselController.nextPage();
                                      },
                                      child: Image.asset("assets/images/rightArrow.png", fit: BoxFit.fill))),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              bottom: SizeConfig.blockHeight * 32,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slideItems.map((item) {
                  int index = slideItems.indexOf(item);
                  return Container(
                    width: SizeConfig.blockWidth * 2,
                    height: SizeConfig.blockHeight * 2,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlide == index
                          ? COLORS.grey
                          : COLORS.greyLight,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
