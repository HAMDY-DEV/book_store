import 'package:book_store/core/util/colors.dart';
import 'package:book_store/features/home/model/slidre_model/slidre_model.dart';
import 'package:book_store/features/home/presentation/manager/home_cubit.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class HaderHome extends StatefulWidget {
  const HaderHome({
    super.key,
  });

  @override
  State<HaderHome> createState() => _HaderHomeState();
}

class _HaderHomeState extends State<HaderHome> {
  int currentSlide = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            SlidreModel? slidreModel = HomeCubit.get(context).slidreModel;
            return slidreModel != null
                ? SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 150,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentSlide = index;
                          });
                        },
                      ),
                      itemCount: slidreModel.data!.sliders!.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Image.network(
                          fit: BoxFit.fitWidth,
                          slidreModel.data!.sliders![index].image ?? '',
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                                width: 150,
                                height: 90,
                                fit: BoxFit.cover,
                                'assets/images/book_stores.jpeg');
                          },
                        );
                      },
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[350]!,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 70,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[350]!,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 90,
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[350]!,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 70,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ],
    );
  }
}
