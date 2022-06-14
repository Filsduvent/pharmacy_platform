// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/cart_controller.dart';
import '../../../../controllers/slide_drug_controller.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../../../../widgets/expandable_text_widget.dart';

class PharmacyDrugDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const PharmacyDrugDetails(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drug = Get.find<SlideDrugController>().slideDrugList[pageId];
    final SlideDrugController slideDrugController =
        Get.put(SlideDrugController());
    Future.delayed(Duration.zero, () {
      slideDrugController.initData(drug, Get.find<CartController>());
    });
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
                    Get.toNamed(RouteHelper.getPharmacyMedecinePage());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(size: Dimensions.font26, text: drug.title!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
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
                drug.photoUrl!,
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
                        text:
                            "This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've usedThis video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list. firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list." //drug.description!
                        )),
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
              onTap: () {},
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
              onTap: () {},
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
      ),
    );
  }
}
