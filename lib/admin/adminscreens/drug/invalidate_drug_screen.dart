// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/admin/adminscreens/drug/admin_valid_details_screen.dart';

import '../../../models/drug_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/small_text.dart';

class InvalidateDrugScreen extends StatefulWidget {
  const InvalidateDrugScreen({Key? key}) : super(key: key);

  @override
  State<InvalidateDrugScreen> createState() => _InvalidateDrugScreenState();
}

class _InvalidateDrugScreenState extends State<InvalidateDrugScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('Medicines')
                    .where('visibility', isEqualTo: false)
                    .snapshots(),
                builder: (c, snapshot) {
                  return Stack(
                    children: [
                      // color cover back ground
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.popularFoodImgSize,
                          color: AppColors.mainColor,
                        ),
                      ),

                      //The container with the number of items in firebase
                      Positioned(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: Container(
                          height: Dimensions.height45 * 1.3,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.secondColor,
                            borderRadius: BorderRadius.circular(29.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "invalid drugs in stock : ",
                                      color: Colors.white,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height10,
                                          bottom: Dimensions.height10,
                                          left: Dimensions.width10,
                                          right: Dimensions.width10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Dimensions.width10 / 2,
                                          ),
                                          BigText(
                                              text: snapshot.hasData
                                                  ? snapshot.data!.docs.length
                                                      .toString()
                                                  : "0"),
                                          SizedBox(
                                            width: Dimensions.width10 / 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //the white background on wich we have all delails
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: Dimensions.popularFoodImgSize - 190,
                        child: Container(
                          padding: EdgeInsets.only(
                              // left: Dimensions.width20,
                              // right: Dimensions.width20,
                              top: Dimensions.height10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                topLeft: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white),

                          // the content of the white background

                          child: snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty
                              ? Stack(
                                  children: [
                                    GridView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          var drugList = snapshot.data!.docs
                                              .map((category) {
                                            return Drug.fromSnap(category);
                                          }).toList();
                                          Drug drug = drugList[index];

                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminValidDetailsScreen(
                                                        pageId: index,
                                                        page: "valid",
                                                        drug: drug,
                                                      ),
                                                    ));
                                              },
                                              child: Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminValidDetailsScreen(
                                                              pageId: index,
                                                              page: "valid",
                                                              drug: drug,
                                                            ),
                                                          ));
                                                    },
                                                    child: Container(
                                                      width:
                                                          Dimensions.width30 *
                                                              9,
                                                      height: Dimensions
                                                              .pageViewContainer /
                                                          1.4,
                                                      margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius30),
                                                          color: index.isEven
                                                              ? const Color(
                                                                  0xFF69c5df)
                                                              : const Color(
                                                                  0xFF9294cc),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  drug.quantity !=
                                                                          0
                                                                      ? drug
                                                                          .photoUrl
                                                                      : "https://t3.ftcdn.net/jpg/01/38/48/40/360_F_138484065_1enzXuW8NlkppNxSv4hVUrYoeF8qgoeY.jpg"))),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height: Dimensions
                                                              .pageViewTextContainer /
                                                          1.5,
                                                      margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .width20,
                                                          right: Dimensions
                                                              .width20,
                                                          bottom: Dimensions
                                                              .height10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Color(
                                                                    0xFFe8e8e8),
                                                                blurRadius: 5.0,
                                                                offset: Offset(
                                                                    0, 5)),
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              offset:
                                                                  Offset(0, -5),
                                                            ),
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              offset:
                                                                  Offset(5, 0),
                                                            )
                                                          ]),
                                                      child: Container(
                                                        width:
                                                            Dimensions.pageView,
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                    .height10 /
                                                                3,
                                                            left: Dimensions
                                                                    .width15 /
                                                                3,
                                                            right: Dimensions
                                                                    .width15 /
                                                                3),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SmallText(
                                                              text: drug.title,
                                                              color: AppColors
                                                                  .mainBlackColor,
                                                              size: Dimensions
                                                                  .font20,
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                        .height10 /
                                                                    3),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SmallText(
                                                                    text: /*"\$${data.price}"*/ "BIF${drug.price.toString()}",
                                                                    size: Dimensions
                                                                        .font20,
                                                                    color: AppColors
                                                                        .mainColor),
                                                                SmallText(
                                                                  text: drug
                                                                      .categories,
                                                                  size: Dimensions
                                                                      .font16,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                        .height10 /
                                                                    3),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .medical_information,
                                                                  color: AppColors
                                                                      .iconColor1,
                                                                  size: Dimensions
                                                                      .iconSize16,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: AppColors
                                                                      .mainColor,
                                                                  size: Dimensions
                                                                      .iconSize16,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .delivery_dining,
                                                                  color: AppColors
                                                                      .iconColor2,
                                                                  size: Dimensions
                                                                      .iconSize16,
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        })
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(
                                      "assets/image/defauldDrug.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.22,
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Text(
                                      "No data found",
                                      style: TextStyle(
                                          fontSize: Dimensions.font26,
                                          color:
                                              Theme.of(context).disabledColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  );
                })));
  }
}
