import 'package:book_store/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPage extends StatefulWidget {
  const SmoothPage({
    super.key,
  });

  @override
  State<SmoothPage> createState() => _SmoothPageState();
}

class _SmoothPageState extends State<SmoothPage> {
  int currentSlide = 0;
  List<String> smooth_page = [
    'assets/images/SmoothPage1.jpg',
    'assets/images/SmoothPage2.jpg',
    'assets/images/SmoothPage3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: double.infinity,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentSlide = value;
                });
              },
              itemCount: smooth_page.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(smooth_page[index]))),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: PageController(initialPage: currentSlide),
            count: 3,
            axisDirection: Axis.horizontal,
            effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.grey,
                activeDotColor: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
