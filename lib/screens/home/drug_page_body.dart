// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dots_indicator/dots_indicator.dart';
import 'package:pharmacy_plateform/controllers/categories_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import 'package:pharmacy_plateform/widgets/icon_and_text_widget.dart';
import 'package:pharmacy_plateform/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/recent_drug_controller.dart';
import '../../routes/route_helper.dart';

class DrugPageBody extends StatefulWidget {
  const DrugPageBody({Key? key}) : super(key: key);

  @override
  State<DrugPageBody> createState() => _DrugPageBodyState();
}

class _DrugPageBodyState extends State<DrugPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  final SlideDrugController slidedrugController =
      Get.put(SlideDrugController());
  final RecentDrugController recentdrugController =
      Get.put(RecentDrugController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  final List<String> names = ['s', 's', 's', 's', 's', 's', 's', 's'];

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        Obx(() {
          return slidedrugController.isLoaded
              ? Container(
                  //color: Colors.redAccent,
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: slidedrugController.slideDrugList.length,
                      itemBuilder: (context, position) {
                        // final slidedata = drugController.slideDrugList[position];
                        return _buildPageItem(position,
                            slidedrugController.slideDrugList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
// dots indicators
        Obx(() {
          return DotsIndicator(
            dotsCount: slidedrugController.slideDrugList.isEmpty
                ? 1
                : slidedrugController.slideDrugList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Recent post text
        SizedBox(
          height: Dimensions.height30,
        ),
        //Category
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Categories'),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),

        GetX<CategoriesController>(builder: (categoryController) {
          return Container(
            margin: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            height: Dimensions.height10 * 10,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categoryController.categoryModel.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        color: Colors.grey.shade100,
                      ),
                      height: Dimensions.height30 * 2,
                      width: Dimensions.width30 * 2,
                      child: Image.network(
                          categoryController.categoryModel[index].image!),
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    BigText(
                        text: categoryController.categoryModel[index].name!),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: Dimensions.width20,
              ),
            ),
          );
        }),

        SizedBox(
          height: Dimensions.height30,
        ),

        //Recent and View All
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recent'),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: BigText(
                  text: 'View All',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        //2nd category of drug
        Obx(() {
          return recentdrugController.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: recentdrugController.recentDrugList.length,
                      itemBuilder: (context, index) {
                        final recentdata =
                            recentdrugController.recentDrugList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getRecentDrug(index, "home"));
                          },
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getPopularDrug(
                                      index, "home"));
                                },
                                child: Container(
                                  width: Dimensions.width30 * 9,
                                  height: Dimensions.pageViewContainer,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: index.isEven
                                          ? Color(0xFF69c5df)
                                          : Color(0xFF9294cc),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              recentdata.photoUrl!))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: Dimensions.pageViewTextContainer,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width30,
                                      right: Dimensions.width30,
                                      bottom: Dimensions.height30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFFe8e8e8),
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5)),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-5, 0),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(5, 0),
                                        )
                                      ]),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        left: Dimensions.width15,
                                        right: Dimensions.width15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: recentdata.title!),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(Icons.star,
                                                    color: AppColors.mainColor,
                                                    size: 15);
                                              }),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "4.5"),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "1287"),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "comments"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: "Normal",
                                                iconColor:
                                                    AppColors.iconColor1),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: "1.7km",
                                                iconColor: AppColors.mainColor),
                                            IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                text: "32min",
                                                iconColor: AppColors.iconColor2)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        //Recent and View All
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recent'),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: BigText(
                  text: 'View All',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        //2nd category of drug
        Obx(() {
          return recentdrugController.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: recentdrugController.recentDrugList.length,
                      itemBuilder: (context, index) {
                        final recentdata =
                            recentdrugController.recentDrugList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getRecentDrug(index, "home"));
                          },
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getPopularDrug(
                                      index, "home"));
                                },
                                child: Container(
                                  width: Dimensions.width30 * 9,
                                  height: Dimensions.pageViewContainer,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: index.isEven
                                          ? Color(0xFF69c5df)
                                          : Color(0xFF9294cc),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              recentdata.photoUrl!))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: Dimensions.pageViewTextContainer,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width30,
                                      right: Dimensions.width30,
                                      bottom: Dimensions.height30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFFe8e8e8),
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5)),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-5, 0),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(5, 0),
                                        )
                                      ]),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        left: Dimensions.width15,
                                        right: Dimensions.width15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: recentdata.title!),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(Icons.star,
                                                    color: AppColors.mainColor,
                                                    size: 15);
                                              }),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "4.5"),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "1287"),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "comments"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: "Normal",
                                                iconColor:
                                                    AppColors.iconColor1),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: "1.7km",
                                                iconColor: AppColors.mainColor),
                                            IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                text: "32min",
                                                iconColor: AppColors.iconColor2)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        //Recent and View All
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recent'),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: BigText(
                  text: 'View All',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        //2nd category of drug
        Obx(() {
          return recentdrugController.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: recentdrugController.recentDrugList.length,
                      itemBuilder: (context, index) {
                        final recentdata =
                            recentdrugController.recentDrugList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getRecentDrug(index, "home"));
                          },
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getPopularDrug(
                                      index, "home"));
                                },
                                child: Container(
                                  width: Dimensions.width30 * 9,
                                  height: Dimensions.pageViewContainer,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: index.isEven
                                          ? Color(0xFF69c5df)
                                          : Color(0xFF9294cc),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              recentdata.photoUrl!))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: Dimensions.pageViewTextContainer,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width30,
                                      right: Dimensions.width30,
                                      bottom: Dimensions.height30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFFe8e8e8),
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5)),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-5, 0),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(5, 0),
                                        )
                                      ]),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        left: Dimensions.width15,
                                        right: Dimensions.width15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: recentdata.title!),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(Icons.star,
                                                    color: AppColors.mainColor,
                                                    size: 15);
                                              }),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "4.5"),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "1287"),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            SmallText(text: "comments"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.circle_sharp,
                                                text: "Normal",
                                                iconColor:
                                                    AppColors.iconColor1),
                                            IconAndTextWidget(
                                                icon: Icons.location_on,
                                                text: "1.7km",
                                                iconColor: AppColors.mainColor),
                                            IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                text: "32min",
                                                iconColor: AppColors.iconColor2)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        //Recent and view all
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recent'),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: BigText(
                  text: 'View All',
                ),
              ),
            ],
          ),
        ),

        //Recent post list

        Obx(() {
          return recentdrugController.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recentdrugController.recentDrugList.length,
                  itemBuilder: (context, index) {
                    final recentdata =
                        recentdrugController.recentDrugList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecentDrug(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            //image section
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(recentdata.photoUrl!)),
                              ),
                            ),
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(text: recentdata.title!),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      SmallText(text: 'With  characteristics'),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: 'Normal',
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: '1.7km',
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: '32min',
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, Drug slideDrugList) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularDrug(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(slideDrugList.photoUrl!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: slideDrugList.title!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(Icons.star,
                                color: AppColors.mainColor, size: 15);
                          }),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: "4.5"),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: "1287"),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: "comments"),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
