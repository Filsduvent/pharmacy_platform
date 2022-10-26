// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/no_data_page.dart';
import '../../../../models/drug_model.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/small_text.dart';
import '../home/pharmacy_drug_details.dart';

class SearchDrugScreen extends StatefulWidget {
  const SearchDrugScreen({Key? key}) : super(key: key);

  @override
  State<SearchDrugScreen> createState() => _SearchDrugScreenState();
}

class _SearchDrugScreenState extends State<SearchDrugScreen> {
  Future<QuerySnapshot>? drugDocumentsList;
  String drugTitleText = "";

  initSearchingPost(String textEntered) {
    drugDocumentsList = FirebaseFirestore.instance
        .collection('Medicines')
        .where('title', isGreaterThanOrEqualTo: textEntered)
        .get();

    setState(() {
      drugDocumentsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<QuerySnapshot>(
            future: drugDocumentsList,
            builder: (context, AsyncSnapshot snap) {
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

                  //Two buttons

                  Positioned(
                    top: Dimensions.height20 * 2,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper.getPharmacyMedecinePage());
                            },
                            child: AppIcon(icon: Icons.arrow_back_ios)),
                      ],
                    ),
                  ),

                  //The container with the number of items in firebase
                  Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        onChanged: (textEntered) {
                          setState(() {
                            drugTitleText = textEntered;
                          });
                          initSearchingPost(textEntered);
                        },
                        decoration: InputDecoration(
                          hintText: "Search your medicine here...",
                          prefixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                initSearchingPost(drugTitleText);
                              }),
                          // icon: IconButton(icon:Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  //the white background on wich we have all delails
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: Dimensions.popularFoodImgSize - 120,
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

                        child: snap.hasData && snap.data!.docs.isNotEmpty
                            ? Stack(
                                children: [
                                  GridView.builder(
                                      itemCount: snap.data!.docs.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        var drugList =
                                            snap.data!.docs.map((med) {
                                          return Drug.fromSnap(med);
                                        }).toList();
                                        Drug drug = drugList[index];

                                        return drug.uid ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () => PharmacyDrugDetails(
                                                        pageId: index,
                                                        page: "drugDetails",
                                                        drug: drug),
                                                  );
                                                },
                                                child: Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            PharmacyDrugDetails(
                                                                pageId: index,
                                                                page:
                                                                    "drugDetails",
                                                                drug: drug));
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
                                                            EdgeInsets.all(0.8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius30),
                                                            color: index.isEven
                                                                ? Color(
                                                                    0xFF69c5df)
                                                                : Color(
                                                                    0xFF9294cc),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(drug
                                                                            .quantity !=
                                                                        0
                                                                    ? drug
                                                                        .photoUrl
                                                                        .toString()
                                                                    : "https://t3.ftcdn.net/jpg/01/38/48/40/360_F_138484065_1enzXuW8NlkppNxSv4hVUrYoeF8qgoeY.jpg"))),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
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
                                                                  blurRadius:
                                                                      5.0,
                                                                  offset:
                                                                      Offset(0,
                                                                          5)),
                                                              BoxShadow(
                                                                color: Colors
                                                                    .white,
                                                                offset: Offset(
                                                                    0, -5),
                                                              ),
                                                              BoxShadow(
                                                                color: Colors
                                                                    .white,
                                                                offset: Offset(
                                                                    5, 0),
                                                              )
                                                            ]),
                                                        child: Container(
                                                          width: Dimensions
                                                              .pageView,
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
                                                                text:
                                                                    drug.title,
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
                                                                    text:
                                                                        "BIF${drug.price}",
                                                                    size: Dimensions
                                                                        .font20,
                                                                    color: AppColors
                                                                        .mainColor,
                                                                  ),
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
                                                                        .circle_sharp,
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
                                                                        .access_time_rounded,
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
                                                ))
                                            : Container();
                                      })
                                ],
                              )
                            : NoDataPage(
                                text: "No drug found",
                                imgPath: "assets/image/defauldDrug.png",
                              ),
                      )),
                ],
              );
            }));
  }
}
