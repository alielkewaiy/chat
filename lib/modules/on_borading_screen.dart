import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/onBoradingModel.dart';
import '../shared/componentes/components.dart';
import '../shared/network/local/cache_helper.dart';
import 'login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  void submit() {
    CacheHelper.saveData(key: 'onBoard', value: true).then((value) {
      navigateAndFinish(context, LoginScreen());
    });
  }

  var boardPageController = PageController();
  bool isLast = false;

  List<OnBoardingModel> boardList = [
    OnBoardingModel(
        image: 'assets/images/on_boarding.png',
        title: 'Products  ',
        body: 'You Can Brows Ours Hot Offers     '),
    OnBoardingModel(
        image: 'assets/images/on_boarding.png',
        title: 'Favorites ',
        body: ' You Have a Special Favorite List'),
    OnBoardingModel(
        image: 'assets/images/on_boarding.png',
        title: 'Start ',
        body: ' Start Now  '),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salla'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardPageController,
                onPageChanged: (index) {
                  if (index == boardList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    onBoardingBuildItem(boardList[index]),
                itemCount: boardList.length,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardPageController,
                  count: boardList.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      activeDotColor: Colors.blue,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardPageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardingBuildItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${model.image}'),
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      );
}
