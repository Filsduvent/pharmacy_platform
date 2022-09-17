// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/screens/category/category_drug_details.dart';

import '../../base/no_data_page.dart';
import '../../models/categories_model.dart';
import '../../models/drug_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class CategoryDrugScreen extends StatefulWidget {
  final int pageId;
  final String page;
  final CategoriesModel category;
  const CategoryDrugScreen(
      {Key? key,
      required this.pageId,
      required this.page,
      required this.category})
      : super(key: key);

  @override
  State<CategoryDrugScreen> createState() => _CategoryDrugScreenState();
}

class _CategoryDrugScreenState extends State<CategoryDrugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'All drugs from ${widget.category.name}',
            style: const TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: AppColors.mainColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              child: AppIcon(
                icon: Icons.arrow_back_ios,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Medicines')
                .where('categories', isEqualTo: widget.category.name)
                .where('visibility', isEqualTo: true)
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12.0,
                                      mainAxisSpacing: 12.0,
                                      mainAxisExtent: 280),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                var drugList = snapshot.data!.docs.map((drug) {
                                  return Drug.fromSnap(drug);
                                }).toList();
                                Drug drug = drugList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => CategoryDrugDetailsScreen(
                                          pageId: index,
                                          page: "Details",
                                          drug: drug,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 1,
                                            offset: const Offset(0, 2),
                                            color: Colors.grey.withOpacity(0.3),
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0)),
                                          child: Image.network(
                                            drug.photoUrl,
                                            height: 170,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(drug.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .merge(const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700))),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(drug.price.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .merge(const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .redAccent))),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          CategoryDrugDetailsScreen(
                                                            pageId: index,
                                                            page: "Details",
                                                            drug: drug,
                                                          ));
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                                  .height10 /
                                                              2,
                                                          bottom: Dimensions
                                                                  .height10 /
                                                              2,
                                                          left: Dimensions
                                                                  .width20 /
                                                              4,
                                                          right: Dimensions
                                                                  .width20 /
                                                              4),
                                                      child: Center(
                                                        child: BigText(
                                                          text: "Explore",
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius20 /
                                                                2),
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                  ),
                                                ]))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : const NoDataPage(
                      text: "No drug found in this category",
                      imgPath: "assets/image/No_data.png",
                    );
            }));
  }
}
