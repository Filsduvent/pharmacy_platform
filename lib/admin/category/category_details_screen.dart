// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/admin/category/update_category.dart';

import '../../base/show_custom_snackbar.dart';
import '../../models/categories_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final int pageId;
  final String page;
  final CategoriesModel category;

  const CategoryDetailsScreen({
    Key? key,
    required this.pageId,
    required this.page,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCategoriesMainScreen());
                    },
                    child: AppIcon(icon: Icons.clear),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child: BigText(
                          size: Dimensions.font26,
                          text: widget.category.name.toString())),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      )),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.mainColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.category.image.toString(),
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: ExpandableTextWidget(
                          text: widget.category.description.toString())),
                ],
              ),
            ),
          ],
        ),

        //Bottom section
        bottomNavigationBar: Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20 * 2),
                topLeft: Radius.circular(Dimensions.radius20 * 2),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            'There\'s no way to retreive deleted elements!'),
                        content: BigText(
                          text: "Are you sure you want to delete this drug?",
                          color: AppColors.mainBlackColor,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // postDrugController
                                //     .deleteByChangeVisibility(widget.catId);
                                deleteCategories(widget.category.id.toString());
                              },
                              child: BigText(
                                text: "Yes",
                                color: Colors.redAccent,
                              )),
                          TextButton(
                              onPressed: () => Get.back(),
                              child: BigText(
                                text: "No",
                                color: AppColors.mainColor,
                              ))
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: 'Delete',
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed(RouteHelper.getUpdateCategoryScreen(
                  //     widget.catId,
                  //     widget.pageId,
                  //     listCategory![widget.pageId].image.toString(),
                  //     listCategory[widget.pageId].name.toString(),
                  //     listCategory[widget.pageId]
                  //         .description
                  //         .toString()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCategoryScreen(
                          category: widget.category,
                        ),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: 'Update',
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future deleteCategories(String id) async {
    try {
      await firestore.collection('Categories').doc(id).delete().then(
          (value) => /* Navigator.of(context).pop());*/ Get
              .toNamed(RouteHelper.getCategoriesMainScreen()));
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Deleting drug category",
      );
    }
  }
}
