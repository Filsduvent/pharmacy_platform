// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:pharmacy_plateform/controllers/categories_controller.dart';
import 'package:pharmacy_plateform/controllers/slide_drug_controller.dart';
import 'package:pharmacy_plateform/models/categories_model.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/screens/category/category_details_screen.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/utils/dimensions.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';
import 'package:pharmacy_plateform/widgets/icon_and_text_widget.dart';
import 'package:pharmacy_plateform/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recent_drug_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../drug/popular_drug_detail.dart';
import '../drug/recent_drug_detail.dart';

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
        StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Medicines')
                .where('visibility', isEqualTo: true)
                .limit(15)
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData
                  ? Container(
                      //color: Colors.redAccent,
                      height: Dimensions.pageView,
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, position) {
                            var drugList = snapshot.data!.docs.map((drug) {
                              return Drug.fromSnap(drug);
                            }).toList();
                            Drug drug = drugList[position];
                            // final slidedata = drugController.slideDrugList[position];
                            return _buildPageItem(position, drug);
                          }),
                    )
                  : CircularProgressIndicator(
                      color: AppColors.mainColor,
                    );
            }),
// dots indicators
        StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Medicines')
                .where('visibility', isEqualTo: true)
                .limit(15)
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? DotsIndicator(
                      dotsCount: snapshot.data!.docs.isEmpty
                          ? 1
                          : snapshot.data!.docs.length,
                      position: _currPageValue,
                      decorator: DotsDecorator(
                        activeColor: AppColors.mainColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )
                  : Container();
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

        StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('Categories').snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      height: Dimensions.height10 * 10,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var categoryList = snapshot.data!.docs.map((cat) {
                            return CategoriesModel.fromjson(cat);
                          }).toList();
                          CategoriesModel category = categoryList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => CategoryDetailsScreen(
                                  pageId: index,
                                  page: "categoryDetails",
                                  category: category,
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width20,
                                      right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    color: Colors.grey.shade100,
                                  ),
                                  height: Dimensions.height30 * 2,
                                  width: Dimensions.width30 * 2,
                                  child:
                                      Image.network(category.image.toString()),
                                ),
                                SizedBox(
                                  height: Dimensions.height15,
                                ),
                                BigText(text: category.name.toString()),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: Dimensions.width20,
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
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
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getViewAllScreen());
                  },
                  child: BigText(
                    text: 'View All',
                    color: AppColors.mainBlackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        //2nd listview of medocs
        StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Medicines')
                .where('visibility', isEqualTo: true)
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? Container(
                      height: Dimensions.pageView,
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: recentdrugController.recentDrugList.length,
                          itemBuilder: (context, index) {
                            var drugList = snapshot.data!.docs.map((drug) {
                              return Drug.fromSnap(drug);
                            }).toList();
                            Drug drug = drugList[index];
                            // final recentdata =
                            //     recentdrugController.recentDrugList[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => PopularDrugDetail(
                                      pageId: index,
                                      page: "home",
                                      drug: drug,
                                    ));
                              },
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => PopularDrugDetail(
                                            pageId: index,
                                            page: "home",
                                            drug: drug,
                                          ));
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
                                              image:
                                                  NetworkImage(drug.photoUrl))),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: Dimensions.pageViewTextContainer,
                                      margin: EdgeInsets.only(
                                          left: Dimensions.width20 * 2.4,
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
                                            BigText(text: drug.title),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Wrap(
                                                //   children:
                                                //       List.generate(5, (index) {
                                                //     return Icon(Icons.star,
                                                //         color:
                                                //             AppColors.mainColor,
                                                //         size: 15);
                                                //   }),
                                                // ),
                                                SmallText(
                                                  text: drug.categories,
                                                  color: AppColors.mainColor,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10,
                                                ),
                                                SmallText(text: "BIF"),
                                                SizedBox(
                                                  width: Dimensions.width10,
                                                ),
                                                SmallText(
                                                  text: drug.price.toString(),
                                                  color: AppColors.yellowColor,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10,
                                                ),
                                                SmallText(text: "BY"),
                                                SizedBox(
                                                  width: Dimensions.width10,
                                                ),
                                                SmallText(
                                                  text: drug.units,
                                                  color:
                                                      AppColors.mainBlackColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.delivery_dining,
                                                    text: "Deliver",
                                                    iconColor:
                                                        AppColors.iconColor1),
                                                IconAndTextWidget(
                                                    icon: Icons.location_on,
                                                    text: "Side",
                                                    iconColor:
                                                        AppColors.mainColor),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: "Time",
                                                    iconColor:
                                                        AppColors.iconColor2)
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
              BigText(text: 'Big sales'),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: GestureDetector(
                  onTap: (() => Get.toNamed(RouteHelper.getViewAllScreen())),
                  child: BigText(
                    text: 'View All',
                  ),
                ),
              ),
            ],
          ),
        ),

        //Recent post list

        StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Medicines')
                .where('units', isEqualTo: "Boxes")
                .where('visibility', isEqualTo: true)
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var drugList = snapshot.data!.docs.map((drug) {
                          return Drug.fromSnap(drug);
                        }).toList();
                        Drug drug = drugList[index];
                        // final recentdata =
                        //     recentdrugController.recentDrugList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => RecentDrugDetail(
                                pageId: index, page: "home", drug: drug));
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
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(drug.photoUrl)),
                                  ),
                                ),
                                //text container
                                Expanded(
                                  child: Container(
                                    height: Dimensions.listViewTextContSize,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BigText(text: drug.title),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Wrap(
                                              //   children:
                                              //       List.generate(5, (index) {
                                              //     return Icon(Icons.star,
                                              //         color:
                                              //             AppColors.mainColor,
                                              //         size: 15);
                                              //   }),
                                              // ),
                                              SmallText(
                                                text: drug.categories,
                                                color: AppColors.mainColor,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width10,
                                              ),
                                              SmallText(text: "BIF"),
                                              SizedBox(
                                                width: Dimensions.width10,
                                              ),
                                              SmallText(
                                                text: drug.price.toString(),
                                                color: AppColors.yellowColor,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width10,
                                              ),
                                              SmallText(text: "BY"),
                                              SizedBox(
                                                width: Dimensions.width10,
                                              ),
                                              SmallText(
                                                text: drug.units,
                                                color: AppColors.mainBlackColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconAndTextWidget(
                                                  icon: Icons.delivery_dining,
                                                  text: "Deliver",
                                                  iconColor:
                                                      AppColors.iconColor1),
                                              IconAndTextWidget(
                                                  icon: Icons.location_on,
                                                  text: "Side",
                                                  iconColor:
                                                      AppColors.mainColor),
                                              IconAndTextWidget(
                                                  icon:
                                                      Icons.access_time_rounded,
                                                  text: "Time",
                                                  iconColor:
                                                      AppColors.iconColor2)
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

  Widget _buildPageItem(int index, Drug drug) {
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
              // Get.toNamed(RouteHelper.getPopularDrug(index, "home"));
              Get.to(() => PopularDrugDetail(
                    pageId: index,
                    page: "home",
                    drug: drug,
                  ));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(drug.photoUrl))),
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
                    BigText(text: drug.title),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Wrap(
                        //   children: List.generate(5, (index) {
                        //     return Icon(Icons.star,
                        //         color: AppColors.mainColor, size: 15);
                        //   }),
                        // ),
                        SmallText(
                          text: "BIF",
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        BigText(
                          text: drug.price.toString(),
                          color: AppColors.yellowColor,
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: "BY", color: AppColors.mainColor),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        BigText(text: drug.units),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.delivery_dining,
                            text: "Deliver",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "Side",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "Time",
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
