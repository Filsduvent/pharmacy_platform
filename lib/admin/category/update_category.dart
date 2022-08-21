import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/categories_model.dart';

import '../../base/custom_loader.dart';
import '../../pharmacist/view/screens/widgets/Pharmacy_app_text_field.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final CategoriesModel category;

  UpdateCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  late bool isLoading;
  var nameController;
  var descriptionController;
  var image;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.category.name);
    descriptionController =
        TextEditingController(text: widget.category.description);
    image = widget.category.image;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize / 1.2,
                      //color: Colors.grey.withOpacity(0.1),
                      //color: Colors.transparent,
                      decoration: (image is String)
                          ? BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image.toString())))
                          : BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: FileImage(image)))),
                ),

                //The back button

                Positioned(
                  top: Dimensions.height20 * 2,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Get.toNamed(RouteHelper.getCategoryDetailsScreen(
                            //   widget.pageId,
                            //   "details",
                            //   widget.catId,
                            // ));
                            Get.back();
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: AppColors.mainColor,
                          )),
                    ],
                  ),
                ),

                // choose photo icon
                Positioned(
                  top: Dimensions.height45 * 4.5,
                  left: Dimensions.width45 * 8,
                  child: GestureDetector(
                    onTap:
                        () {}, // => //postDrugController.pickImageUpdate(context),
                    child: AppIcon(
                      icon: Icons.add_a_photo,
                      backgroundColor: Colors.white,
                      iconColor: AppColors.mainColor,
                      iconSize: Dimensions.height30,
                      size: Dimensions.height30 * 2,
                    ),
                  ),
                ),

                // The white background
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: (Dimensions.popularFoodImgSize - 20) / 1.2,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20),
                      ),
                      color: Colors.grey.withOpacity(0.1),
                    ),

                    //All content field
                    child: Column(children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),

                              //The name

                              PharmacyAppTextField(
                                textController: nameController,
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                hintText: "Title",
                              ),
                              SizedBox(
                                height: Dimensions.height20 * 2,
                              ),

                              //Description
                              PharmacyAppTextField(
                                textController: descriptionController,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                hintText: "Description",
                              ),

                              SizedBox(
                                height: Dimensions.height20 * 2,
                              ),

                              //sign up button

                              GestureDetector(
                                onTap: () {
                                  /* uploadCategoryItem(
                                    nameController.text,
                                    categoryController.drugPhoto,
                                    descriptionController.text,
                                  );*/
                                },
                                child: Container(
                                  width: Dimensions.screenWidth / 2,
                                  height: Dimensions.screenHeight / 13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius30),
                                      color: AppColors.mainColor),
                                  child: Center(
                                    child: BigText(
                                      text: "Edit",
                                      size: Dimensions.font20 +
                                          Dimensions.font20 / 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          : CustomLoader(),
    );
  }
}
