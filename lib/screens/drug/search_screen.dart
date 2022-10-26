// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/screens/drug/popular_drug_detail.dart';
import '../../../../base/no_data_page.dart';
import '../../../../models/drug_model.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

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
                              Get.toNamed(RouteHelper.getInitial());
                            },
                            child: AppIcon(
                              icon: Icons.arrow_back_ios,
                              iconColor: AppColors.mainColor,
                            )),
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
                              icon: Icon(
                                Icons.search,
                                color: AppColors.mainColor,
                              ),
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
                              ? SingleChildScrollView(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 12.0,
                                                  mainAxisSpacing: 12.0,
                                                  mainAxisExtent: 280),
                                          itemCount: snap.data!.docs.length,
                                          itemBuilder: (_, index) {
                                            var drugList =
                                                snap.data!.docs.map((drug) {
                                              return Drug.fromSnap(drug);
                                            }).toList();
                                            Drug drug = drugList[index];
                                            return drug.quantity != 0
                                                ? GestureDetector(
                                                    onTap: () {
                                                      // Get.to(() => CategoryDrugDetailsScreen(
                                                      //       pageId: index,
                                                      //       page: "Details",
                                                      //       drug: drug,
                                                      //     ));
                                                      Get.to(() =>
                                                          PopularDrugDetail(
                                                            pageId: index,
                                                            pages: "home",
                                                            drug: drug,
                                                          ));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 1,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                            )
                                                          ]),
                                                      child: Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16.0)),
                                                            child:
                                                                Image.network(
                                                              drug.photoUrl,
                                                              height: 170,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        drug
                                                                            .title,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle1!
                                                                            .merge(const TextStyle(fontWeight: FontWeight.w700))),
                                                                    const SizedBox(
                                                                      height:
                                                                          8.0,
                                                                    ),
                                                                    Text(
                                                                        "BIF${drug.price.toString()}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle2!
                                                                            .merge(TextStyle(
                                                                                fontWeight: FontWeight.w700,
                                                                                color: AppColors.mainColor))),
                                                                    const SizedBox(
                                                                      height:
                                                                          8.0,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // Get.to(() =>
                                                                        //     CategoryDrugDetailsScreen(
                                                                        //       pageId: index,
                                                                        //       page: "Details",
                                                                        //       drug: drug,
                                                                        //     ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        padding: EdgeInsets.only(
                                                                            top: Dimensions.height10 /
                                                                                2,
                                                                            bottom: Dimensions.height10 /
                                                                                2,
                                                                            left: Dimensions.width20 /
                                                                                4,
                                                                            right:
                                                                                Dimensions.width20 / 4),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              BigText(
                                                                            text:
                                                                                "Explore",
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(Dimensions.radius20 / 2),
                                                                          color:
                                                                              AppColors.secondColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]))
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                          }),
                                    ),
                                  ),
                                )
                              : const NoDataPage(
                                  text: "No drug found ",
                                  imgPath: "assets/image/defauldDrug.png",
                                ))),
                ],
              );
            }));
  }
}
